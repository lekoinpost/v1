import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    if (window.innerWidth > 768) {

      const faqItems = document.querySelectorAll('.faq-item');

      faqItems.forEach((item) => {
        item.addEventListener('click', () => {
          faqItems.forEach((otherItem) => {
            if (otherItem !== item) {
              otherItem.removeAttribute('open');
            }
          });
        });
      });
    }
  }
}