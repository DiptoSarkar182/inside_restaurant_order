import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["phoneInput"];

  connect() {
    if (this.phoneInputTarget) {
      this.initializePhoneInput();
    }
  }

  initializePhoneInput() {
    intlTelInput(this.phoneInputTarget, {
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: "bd",
      getNumber: true,
    });
  }
}
