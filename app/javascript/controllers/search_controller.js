import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"

const MINIMUM_SEARCHABLE_FIELDS_PER_RECORD = 1

export default class extends Controller {

  static targets = ["searchable"]
  static values = {
    searchableFieldsPerRecord: {
      type: Number, default: MINIMUM_SEARCHABLE_FIELDS_PER_RECORD
    }
  }

  connect() {
    console.log("I am here")
  }

  filter(event) {
    const keyword = event.target.value
    console.log(keyword)
  }
}
