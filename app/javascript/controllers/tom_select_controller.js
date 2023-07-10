import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select";

export default class extends Controller {
  connect() {
    document.querySelectorAll('.select').forEach((el) => {
      new TomSelect(el, {
        allowEmptyOption: true,
      });
    });
  }
}
