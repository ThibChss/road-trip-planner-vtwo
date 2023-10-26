import { Controller } from "@hotwired/stimulus"
import { useClickOutside, useHover } from 'stimulus-use'

// Connects to data-controller="actions-friends"
export default class extends Controller {

  static targets = [
    'menu'
  ]

  connect() {
    useClickOutside(this, { element: this.menuTarget })
    useHover(this, { element: this.element })
  }

  clickOutside() {
    this.menuTarget.classList.remove('active')
  }

  mouseLeave() {
    this.menuTarget.classList.remove('active')
  }

  displayMenu() {
    this.menuTarget.classList.toggle('active')
  }
}
