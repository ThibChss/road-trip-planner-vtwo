import { Controller } from "@hotwired/stimulus"
// import { Turbo } from "@hotwired/turbo"

// Connects to data-controller="form-redirect"
export default class extends Controller {
  connect() {
    console.log('Yo');
  }

  next(event) {
    // console.log(event.detail.success)
    // if (event.detail.success) {
      // const fetchResponse = event.detail.fetchResponse
      // console.log(fetchResponse);

      // history.pushState(
      //   {},
      //   "",
      //   fetchResponse.response.url
      // )

    //   Turbo.visit('/profile')
    // }
  }
}
