import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calendar-select"
export default class extends Controller {

  static targets = [
    'calendarFrame',
    'background'
  ]

  static values = {
    tripId: Number
  }

  connect() {
  }

  monthCalendar(event) {
    this.backgroundTarget.classList.remove('week')
    this.calendarFrameTarget.src = `${window.location.origin}/trips/${this.tripIdValue}/month_calendar`
  }

  weekCalendar(event) {
    this.backgroundTarget.classList.add('week')
    this.calendarFrameTarget.src = `${window.location.origin}/trips/${this.tripIdValue}/week_calendar`
  }
}
