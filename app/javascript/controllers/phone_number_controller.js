import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["phoneInput", "countryCodeInput"];

  connect() {
    if (this.phoneInputTarget) {
      this.initializePhoneInput();
    }
  }

  initializePhoneInput() {
    const countryCode = this.countryCodeInputTarget.value || 'bd'; // Use saved country code or default to 'bd'

    this.iti = intlTelInput(this.phoneInputTarget, {
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: this.getCountryFromCode(countryCode),
      getNumber: true,
    });

    this.phoneInputTarget.addEventListener('countrychange', () => {
      this.updateCountryCode();
    });

    this.updateCountryCode();
  }

  updateCountryCode() {
    const countryCode = this.iti.getSelectedCountryData().dialCode;
    this.countryCodeInputTarget.value = countryCode;
  }

  getCountryFromCode(dialCode) {
    const country = window.intlTelInputGlobals.getCountryData().find(country => country.dialCode === dialCode);
    return country ? country.iso2 : 'bd';
  }
}
