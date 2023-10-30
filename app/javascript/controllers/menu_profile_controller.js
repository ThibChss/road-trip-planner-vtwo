import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from 'stimulus-use'

// Connects to data-controller="menu-profile"
export default class extends Controller {

  static targets = [
    'subMenu',
    'friendMenu',
    'tripMenu',
    'subMenuTrip'
  ]

  static classes = [
    'active'
  ]

  connect() {
  }

  showSubMenu() {
    if (this.hasSubMenuTarget){
      this.subMenuTarget.classList.toggle(this.activeClass)
      this.friendMenuTarget.classList.toggle(this.activeClass)
    }
  }

  hideSubMenu() {
    if (this.hasSubMenuTarget) {
      this.subMenuTarget.classList.remove(this.activeClass)
      this.friendMenuTarget.classList.remove(this.activeClass)
    }
  }

  showSubTripMenu() {
    if (this.hasSubMenuTripTarget){
      this.subMenuTripTarget.classList.toggle(this.activeClass)
      this.tripMenuTarget.classList.toggle(this.activeClass)
    }
  }

  hideSubTripMenu() {
    if (this.hasSubMenuTripTarget) {
      this.subMenuTripTarget.classList.remove(this.activeClass)
      this.tripMenuTarget.classList.remove(this.activeClass)
    }
  }
}
