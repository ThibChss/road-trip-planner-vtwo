import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-focus"
export default class extends Controller {

  static targets = [
    'label',
    'wrapper'
  ]

  static classes = [
    'focused'
  ]

  connect() {
  }

  focused(event) {
    const input     = event.target
    const wrapper   = this.wrapperTargets.find(wrap => wrap.dataset.identity === input.dataset.identity)
    const label     = this.labelTargets.find(lab => lab.dataset.identity === input.dataset.identity)
    const active    = document.activeElement === input
    let value       = input.value

    if (active) {
      wrapper.classList.add(this.focusedClass)
      label.classList.add(this.focusedClass)
    }

    input.addEventListener('keyup', () => value = input.value)

    input.addEventListener('focusout', () => {
      if (value === '') {
        wrapper.classList.remove(this.focusedClass)
        label.classList.remove(this.focusedClass)
      }
    })
  }
}
