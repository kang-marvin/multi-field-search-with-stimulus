import { Controller } from "@hotwired/stimulus"

const MINIMUM_SEARCHABLE_FIELDS_PER_RECORD = 1;
const MINIMUM_REQUIRED_CHARACTERS_FOR_SEARCH = 3;

export default class extends Controller {

  static targets = ["searchable"]
  static values = {
    searchableFieldsPerRecord: {
      type: Number, default: MINIMUM_SEARCHABLE_FIELDS_PER_RECORD
    }
  }

  connect() {}

  filter(event) {
    const keyword = event.target.value
    for (let counter = 0; counter < this.#totalLoopsToPerform(); counter++) {
      const data = this.#generateSearchableContent(counter)
      if (keyword.length < MINIMUM_REQUIRED_CHARACTERS_FOR_SEARCH) {
        data.parent.style.display = null
        continue
      }

      if (data.contents.toLowerCase().includes(keyword.toLowerCase())) {
        data.parent.style.display = null
      } else {
        data.parent.style.display = 'none'
      }
    }
  }

  #totalLoopsToPerform() {
    return this.searchableTargets.length / this.searchableFieldsPerRecordValue;
  }

  #generateSearchableContent(index) {
    const arrayStartIndex = index * this.searchableFieldsPerRecordValue
    const searchableElements = this.searchableTargets.slice(
      arrayStartIndex,
      (arrayStartIndex + this.searchableFieldsPerRecordValue)
    )

    return {
      contents: searchableElements.map(el => this.#cleanupContent(el.textContent)).join('-'),
      parent: searchableElements[0].parentElement
    }
  }

  #cleanupContent(content) {
    return content.replace(/(\r\n|\n|\r)/gm,"").trim()
  }

}
