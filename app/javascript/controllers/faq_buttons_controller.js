import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    
    const detailsElements = document.querySelectorAll('details');
    
    detailsElements.forEach(function(details) {
      details.addEventListener('toggle', function() {
        this.querySelector('summary').classList.toggle('opened');
      });
    });
  }
}