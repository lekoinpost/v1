import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"


export default class extends Controller {

  static targets = [ "appointmentTime"]

  connect() {
    flatpickr(this.appointmentTimeTarget, {
      "locale": French, 
      // altInput: true,
      // altFormat: "F j, Y"
    })
  }
}