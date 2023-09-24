import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-redirect"
export default class extends Controller {

  connect() {
  }

  redirect(event) {
    const success   = event.detail.success
    const path      = window.location.origin

    if (success) Turbo.visit(path, { action: 'replace' })
  }
}
