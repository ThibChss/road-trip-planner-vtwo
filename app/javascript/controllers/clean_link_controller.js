import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clean-link"
export default class extends Controller {

  static values = {
    user: String
  }

  connect() {
  }

  cleanLinkProfile() {
    window.history.pushState(null, null, `${window.location.origin}/profile/${this.userValue}`)
  }
}
