import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs-nav"
export default class extends Controller {

  static targets = [
    'link',
    'frame'
  ]

  static classes = [
    'active'
  ]

  connect() {
  }

  activeTab(event) {
    const frame = event.target

    this.linkTargets.forEach(link => {
      if (link.href === frame.src) {
        link.classList.add(this.activeClass)
      } else {
        link.classList.remove(this.activeClass)
      }
    });
  }
}
