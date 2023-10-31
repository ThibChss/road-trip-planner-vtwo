import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {

  static targets = [
    'template',
    'addedParticipantsContainer'
  ]

  connect() {
  }

  addParticipant(event) {
    event.preventDefault()

    const id      = event.target.dataset.id
    const name    = event.target.innerText
    const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())

    this.addedParticipantsContainerTarget.insertAdjacentHTML('afterbegin', content)
    this.addedParticipantsContainerTarget.firstElementChild.querySelector('#input_user').value      = id
    this.addedParticipantsContainerTarget.firstElementChild.querySelector('#user_name').innerText   = name
  }

  removeParticipant(event) {
    event.preventDefault()

    const wrapper = event.target.closest('.nested_participant')

    wrapper.querySelector("input[name*='_destroy']").value = 1
    wrapper.style.display = 'none'
  }
}
