import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tinymce"
export default class extends Controller {
  connect() {
    console.log("tinymce controller connected")
    this.loadTinyMCE().then(() => {
      this.initializeTinyMCE();
    });
  }

  disconnect() {
    this.destroyTinyMCE();
  }

  loadTinyMCE() {
    return new Promise((resolve, reject) => {
      if (typeof tinymce !== "undefined") {
        resolve();
        return;
      }

      const apiKey = document.querySelector('meta[name="tinymce-api-key"]').content;
      const script = document.createElement("script");
      script.src = `https://cdn.tiny.cloud/1/${apiKey}/tinymce/7/tinymce.min.js`;
      script.referrerPolicy = "origin";
      script.onload = () => resolve();
      script.onerror = () => reject(new Error("Failed to load TinyMCE script"));
      document.head.appendChild(script);
    });
  }

  initializeTinyMCE() {
    tinymce.init({
      target: this.element,
      plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
      toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
    });
  }

  destroyTinyMCE() {
    if (tinymce.get(this.element.id)) {
      tinymce.get(this.element.id).remove();
    }
  }
}
