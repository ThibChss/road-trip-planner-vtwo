import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu-profile"
export default class extends Controller {

  static targets = [
    'subMenu',
    'friendMenu'
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
}
