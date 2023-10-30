import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-trips"
export default class extends Controller {

  static values = {
    user: String
  }

  connect() {
  }

  reloadFrameSearch(event) {
    const value         = event.target.value
    const searchPath    = `/profile/${this.userValue}/trips?query=${value}`

    Turbo.visit(searchPath, { frame: 'search_trip_frame' })
  }
}
