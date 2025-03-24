import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter"]
  static values = {
    max: Number
  }

  connect() {
    this.update()
  }

  update() {
    let value = this.inputTarget.value

    // Trim if too long
    if (value.length > this.maxValue) {
      value = value.slice(0, this.maxValue)
      this.inputTarget.value = value
    }

    const currentLength = value.length
    this.counterTarget.textContent = `${currentLength} / ${this.maxValue} caractères`

    // Add red color class if limit reached
    if (currentLength === this.maxValue) {
      this.counterTarget.classList.add("red")
    } else {
      this.counterTarget.classList.remove("red")
    }
  }
}
