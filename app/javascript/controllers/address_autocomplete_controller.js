// app/javascript/controllers/address_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "region,place,postcode,locality,neighborhood,address", 
      placeholder: 'renseigner une adresse', 
      countries: "fr"
    })
    this.geocoder.addTo(this.element)

    const address_param = document.querySelector("#address-param").dataset.selected;
    document.querySelector(".mapboxgl-ctrl-geocoder--input").value = address_param

    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

  disconnect() {
    this.geocoder.onRemove()
  }


}