// app/javascript/controllers/photo_preview_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-preview"
export default class extends Controller {
  // Declare our two targets
  static targets = ["input", "preview"];
  connect(){
    console.log("Helloe")
  }

  // Code this callback function
  displayPreview(event) {
    console.log("DISPLAY !!")
    const reader = new FileReader();
    reader.onload = (event) => {
      this.previewTarget.src = event.currentTarget.result;
    }
    reader.readAsDataURL(this.inputTarget.files[0])
    this.previewTarget.classList.remove('d-none');
  }
}