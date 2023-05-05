import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {

    const faqItems = document.querySelectorAll(".faq-item");

    faqItems.forEach((item) => {
      const title = item.querySelector(".faq-title");
      const content = item.querySelector(".faq-content");
      
      // When the user clicks on the title 
      title.addEventListener("click", () => {
        // Hide all other faq-content elements
        faqItems.forEach((otherItem) => {
          if (otherItem !== item) {
            otherItem.querySelector(".faq-content").classList.add("d-none");
            otherItem.querySelector(".faq-title").classList.remove("d-none");
          }
        });
  
        // Toggle visibility of this faq-content element
        content.classList.toggle("d-none");
        title.classList.toggle("d-none");
      });
      
      // Close the faq-content when the user clicks outisde
      // document.addEventListener('click', (event) => {
      //   if (item.contains(event.target)){
      //     console.log("I clicked inside")
      //   } else {
      //     console.log("I clicked outside")
      //   } 
      // })
    })
  }
}