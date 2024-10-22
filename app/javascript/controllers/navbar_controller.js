import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static get targets() {
    return ["navbar"];
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

    if (scrollPosition > 200) {
      this.navbarTarget.classList.add("shadow-md", "bg-opacity-25", "backdrop-blur-md", "border-b", "border-gray-200");
    } else {
      this.navbarTarget.classList.remove("shadow-md", "bg-opacity-25", "backdrop-blur-md", "border-b", "border-gray-200");
    }
  }
}

