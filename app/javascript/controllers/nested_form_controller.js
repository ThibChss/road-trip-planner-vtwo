import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {

  static targets = [
    'template',
    'addedParticipantsContainer',
    'form',
    'friendCard'
  ]

  connect() {
    console.log(this.formTarget.method === 'post');
  }

  addParticipant(event) {
    event.preventDefault()

    const link                = event.target.closest('.link_add_participant_select')
    const card                = link.querySelector('.container_card_friend_select')
    const cardBack            = card.parentElement
    const id                  = link.dataset.id
    const participantsList    = Array.from(this.addedParticipantsContainerTarget.querySelectorAll('#input_user'))
    const participantExist    = participantsList.find(input => input.value === id)

    const flashMessage = this.#cannotAddTwice()

    if (typeof participantExist !== 'undefined') {
        const flash = document.querySelector('#flash')
        flash.insertAdjacentHTML('afterbegin', flashMessage)
    } else {
      const name    = link.querySelector('.name_user_to_select').innerText
      const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().getTime())

      card.classList.add('focused')
      cardBack.classList.add('resized')

      this.addedParticipantsContainerTarget.insertAdjacentHTML('afterbegin', content)
      this.addedParticipantsContainerTarget.firstElementChild.querySelector('#input_user').value      = id
      this.addedParticipantsContainerTarget.firstElementChild.querySelector('#user_name').innerText   = name
    }
  }

  removeParticipant(event) {
    event.preventDefault()

    const wrapper     = event.target.closest('.nested_participant')
    const id          = wrapper.querySelector('#input_user').value
    const link        = this.friendCardTargets.find(card => card.dataset.id === id)
    const card        = link.querySelector('.container_card_friend_select')
    const cardBack    = card.parentElement

    if (this.formTarget.method === 'post') {
      wrapper.remove()
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none'
    }

    card.classList.remove('focused')
    cardBack.classList.remove('resized')
  }

  #cannotAddTwice() {
    return `
      <div class="flash__message flash__alert",
            data-controller='flash-removal'
            data-action='animationend->flash-removal#remove'>
        You cannot add the same personne twice ❌
      </div>
    `
  }
}
