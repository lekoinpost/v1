import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["products", "form"]

  connect() {
    this.formTarget.value = ""
  }

  add() {
    event.preventDefault();
    // Display the new product in the view
    const newProduct = this.formTarget.value
    this.productsTarget.insertAdjacentHTML("beforeend", this.new_product_button(newProduct))
    // Clear the form
    this.formTarget.value = ""
    // Pass the new product to the database
    const addedProductsField = document.querySelector('input[name="added_products_list[]"]');
    console.log(addedProductsField.value)
    let productList = addedProductsField.value.trim().split(",").map(item => item.trim());
    productList.push(newProduct);
    addedProductsField.value = productList.join(", ");
    console.log(addedProductsField.value)
  }

  remove(event) {
    console.log("I clicked !!")
    event.preventDefault();
    const productElement = event.target.closest('.product');
    const removedProduct = productElement.dataset.value;

    // Remove the product button from the view
    productElement.remove();
    // Pass the removed product to the database
    const removedProductsField = document.querySelector('input[name="removed_products_list[]"]');
    console.log(removedProductsField.value)
    let productList = removedProductsField.value.split(",").map(item => item.trim());
    productList.push(removedProduct);
    removedProductsField.value = productList.join(", ");
    console.log(removedProductsField.value)
  }

  new_product_button(newProduct) {
    return `<div class="product" value="${newProduct}">
      <div class="d-flex">${newProduct}<i class="fa-solid fa-xmark ms-2"></i></div>
    </div>`;
  }

  // initialize() {
  //   this.productsTarget.addEventListener('click', this.remove.bind(this));
  // }

  // disconnect() {
  //   this.productsTarget.removeEventListener('click', this.remove.bind(this));
  // }
}
