import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-redirect"
export default class extends Controller {

  static targets = [
    'frameNewTrip'
  ]

  static values = {
    user: String
  }

  connect() {
  }

  redirect(event) {
    const success   = event.detail.success
    const path      = event.detail.fetchResponse.response.url

    if (success) Turbo.visit(path)
  }

  redirectNewTrip(event) {
    const success         = event.detail.success
    const destination     = `/profile/${this.userValue}/trips`

    if (success) {
      this.frameNewTripTarget.src = destination
    }

    // if (success) Turbo.visit(path, { frame: 'turbo__profile', source: `/profile/${this.userValue}/trips` })
  }
}
