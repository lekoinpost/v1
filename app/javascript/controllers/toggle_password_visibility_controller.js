import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {

    const passwordVisibilityButton = document.querySelector(".password-visibility-button");
    const passwordInput = document.querySelector("#user-password");

    passwordVisibilityButton.addEventListener("click", () => {
      if (passwordInput.type === "password") {
        passwordVisibilityButton.innerHTML = "<i class='far fa-eye'></i>"
        passwordInput.type = "text";
      } else {
        passwordVisibilityButton.innerHTML = "<i class='far fa-eye-slash'></i>"
        passwordInput.type = "password";
      }
    })
  }
}