import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-friends"
export default class extends Controller {

  static targets = [
    'searchFrame'
  ]

  static values = {
    user: String
  }

  connect() {
  }

  reloadFrameSearch(event) {
    const value         = event.target.value
    const searchPath    = `/profile/${this.userValue}/friends?query=${value}`

    Turbo.visit(searchPath, { frame: 'search_mutual_friends' })
  }

  reloadFrameSearchSuggestion(event) {
    const value         = event.target.value
    const searchPath    = `/profile/${this.userValue}/search_friends?query=${value}`

    Turbo.visit(searchPath, { frame: 'search_new_friends' })
  }
}
