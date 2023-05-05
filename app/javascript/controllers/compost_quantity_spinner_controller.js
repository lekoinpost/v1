import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let spinner = document.querySelector("#spinner")
    let spinner_value = parseInt(spinner.value, 10);

    document.querySelector(".minus").addEventListener("click", (event) => {
      if (spinner_value >= 2) {
        spinner_value =  spinner_value - 1
        spinner.value = spinner_value
      }
    })

    document.querySelector(".plus").addEventListener("click", (event) => {
      spinner_value =  spinner_value + 1
      spinner.value = spinner_value
    })
  }
}
