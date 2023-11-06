import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {

  static targets = [
    'template',
    'addedParticipantsContainer',
    'form'
  ]

  connect() {
    console.log(this.formTarget.method === 'post');
  }

  addParticipant(event) {
    event.preventDefault()

    const id                  = event.target.closest('.link_add_participant_select').dataset.id
    const participantsList    = Array.from(this.addedParticipantsContainerTarget.querySelectorAll('#input_user'))
    const participantExist    = participantsList.find(input => input.value === id)

    const flashMessage = this.#cannotAddTwice()

    if (typeof participantExist !== 'undefined') {
        const flash = document.querySelector('#flash')
        flash.insertAdjacentHTML('afterbegin', flashMessage)
    } else {
      const name    = event.target.innerText
      const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())

      this.addedParticipantsContainerTarget.insertAdjacentHTML('afterbegin', content)
      this.addedParticipantsContainerTarget.firstElementChild.querySelector('#input_user').value      = id
      this.addedParticipantsContainerTarget.firstElementChild.querySelector('#user_name').innerText   = name
    }
  }

  removeParticipant(event) {
    event.preventDefault()

    const wrapper = event.target.closest('.nested_participant')
    if (this.formTarget.method === 'post') {
      wrapper.remove()
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none'
    }
  }

  #cannotAddTwice() {
    return `
      <div class="flash__message flash__notice",
            data-controller='flash-removal'
            data-action='animationend->flash-removal#remove'>
        You cannot add the same personne twice ❌
      </div>
    `
  }
}
