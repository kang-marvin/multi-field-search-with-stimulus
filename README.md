# Multi Field Keyword Search using Stimulus JS

## Problem

Assume you have a table with multi fields and are asked to create a search by keyword input that only searches specific fields in that table.

**Example**

In a table that contains the following fields, Create a `Search by Keyword` input that only searches the fields `Author Name, Book Title and Book Original Language`.

Note, the fields can be in any order.

```
  Books Table
   - Author Name
   - Author Pen Name
   - Author Country
   - Publisher Name
   - Book Title
   - Book Genre
   - Book Publishing Date
   - Book Rating
   - Book Original Language
```

## Solution

Before we start, here are a few things to keep in mind

 - The solution should be able to work for any table provided the necessary information is given. This means that for the stimulus controller, we are going to build, it should work even when that table data changes ie more searchable fields are added or removed
 - We will try to ensure the user knows which fields are being searchable.


Let me start with building the Dashboard UI

```erb

<!-- app/views/dashboard/index.html.erb -->

<div>

  <input
    type="text"
    name="keyword"
    placeholder="Search by keyword"
  />

  <table>
    <caption>
      Searchable Fields Are:-
      <!-- List Fields That Are Searchable -->
    </caption>

    <thead>
      <!-- Headers -->
    </thead>

    <tbody>
      <% @books.each do |book| %>
        <!--  Book Details -->
      <% end %>
    </tbody>
  </table>
</div>
```

When we create `search` stimulus controller, we can connect it to the div wrapper in the code above. Also, we need to pass a stimulus value called `searchable-fields-per-record` which is a number of fields the table has.

A table might have 15 fields but only 2 fields are searchable.

Another thing we need to do is for each field that you want it to be searchable, add `Stimulus target` called `searchable`.

```erb
  <!-- app/views/dashboard/index.html.erb -->

  <div
    data-controller="search"
    data-search-searchable-fields-per-record-value={NUMBER_OF_FIELDS_THAT_ARE_SEARCHABLE}
  >

    <!--
      The data action is similar to saying: When data of this Input changes, call the function `filter` located in the `search` stimulus controller
    -->
    <input
      type="text"
      name="keyword"
      placeholder="Search by keyword"
      data-action="input->search#filter"
    />

    <table>
      <caption>
        Searchable Fields Are:-
        <div data-search-target="listFieldsOutput"></div>
      </caption>

      <thead>
        <!-- Headers -->
      </thead>

      <tbody>
        <% @books.each do |book| %>
          <!--  Book Details -->

          <!-- Example: for fields that ARE NOT searchable  -->
          <td id="publisher_name">
            <%= book.publisher_name %>
          </td>

          <!-- Example: for fields that ARE searchable  -->
          <td id="author_name" data-search-target="searchable">
            <%= book.publisher_name %>
          </td>
        <% end %>
      </tbody>
    </table>

  </div>
```

So, NOTE the following :-

  - Each table body `td` must have `ID`
  - Only fields that you want to be searchable should have the `data-search-target="searchable"`
  - The value of `NUMBER_OF_FIELDS_THAT_ARE_SEARCHABLE` is the count of all fields that have the data attribute `data-search-target="searchable"`. Always ensure this value is the correct count.

Now, Let us look at our `search` stimulus controller

```js
/* app/javascript/controllers/search_controller.js */

import { COntroller } from "@hotwired/stimulus"

const MINIMUM_SEARCHABLE_FIELDS = 1

export default class extends Controller {

  static targets = ["searchable", "listFieldsOutput"]
  static values = {
    searchableFieldsPerRecord: {
      type: Number, default: MINIMUM_SEARCHABLE_FIELDS
    }
  }

  connect(){
    /**
     * Display the IDs of the searchable fields to the user
     * **/
    this.searchableTargets.slice(
      0, this.searchableFieldsPerRecordValue
    ).map(component => component.id).forEach(element => {
      let elementComponent = document.createElement('span')
      elementComponent.textContent = `"${element}"`
      this.listFieldsOutputTarget.appendChild(elementComponent)
    })
  }

  filter(event) {
    const searchedKeyword = event.target.value
    const noOfLoopsToPerform = this.#totalLoopsToPerform()

    for(let counter = 0; counter < noOfLoopsToPerform; counter++) {
      count data = this.#generateSearchableContent(counter)

      /* Do nothing if the searchedKeyword is empty */
      if (searchedKeyword.length < 1) {
        data.parent.style.display = null
        continue
      }

      /* Check if the combined searchable data contains the searched keyword */
      if (data.contents.toLowerCase().includes(keyword.toLowerCase())) {
        data.parent.style.display = null
      } else {
        /* Hide the row because it does not match the searched keyword */
        data.parent.style.display = 'none'
      }
    }
  }

  /**
   * The reason we are doing this is to
   * avoid performing alot of loops.
   *
   * Take a table that has 50 records but each record
   * has 15 searchable fields,
   * this means `searchableTargets` length is 50 * 15
   *
   * To avoid that, we only want to loop 50 times only
   * **/
  #totalLoopsToPerform() {
    return this.searchableTargets.length / this.searchableFieldsPerRecordValue;
  }

  /**
   * What we want is to combine all textContent
   * of all searchable fields per row.
   *
   * Remember, we are not looping over ALL `searchable` elements.
   *
   * We are also returning the parent element ie table row,
   * we use this to `hide` or `show` rows that contain the data we want.
   * **/
  #generateSearchableContent(index) {
    const arrayStartIndex = index * this.searchableFieldsPerRecordValue
    const searchableElements = this.searchableTargets.slice(
      arrayStartIndex,
      (arrayStartIndex + this.searchableFieldsPerRecordValue)
    )

    return {
      contents: searchableElements.map(el => el.textContent).join(' '),
      parent: searchableElements[0].parentElement
    }
  }
}
```


## Conclusion

Try changing which fields are `searchable` and also remember to update the `data-search-searchable-fields-per-record-value` if you add / remove fields that are searchable.

Enjoy :)