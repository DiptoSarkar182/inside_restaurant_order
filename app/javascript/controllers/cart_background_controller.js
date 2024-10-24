import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart-background"
export default class extends Controller {
  static get targets() {
    return ["cart"];
  }

  connect() {
    this.handleScroll = this.handleScroll.bind(this);
    window.addEventListener("scroll", this.handleScroll);
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll);
  }

  handleScroll() {
    const scrollPosition = window.scrollY;

    if (scrollPosition > 955) {
      this.cartTarget.classList.add("bg-red-600");
    } else {
      this.cartTarget.classList.remove("bg-red-600");
    }
  }
}
