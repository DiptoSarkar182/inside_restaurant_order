import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview"];

  connect() {
    console.log("Connected");
  }

  preview() {
    const input = this.inputTarget;
    const previewContainer = this.previewTarget;

    // Clear previous previews
    previewContainer.innerHTML = "";

    // Loop through each file
    Array.from(input.files).forEach(file => {
      const reader = new FileReader();

      reader.onloadend = function () {
        const img = document.createElement("img");
        img.src = reader.result;
        img.classList.add("image", "w-32", "h-auto", "object-contain", "rounded", "mr-2");
        previewContainer.appendChild(img);
      };

      if (file) {
        reader.readAsDataURL(file);
      }
    });
  }
}
