import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="phone-number"
export default class extends Controller {
  static targets = ["dropdownMenu", "dropdownSpan", "phoneNumberInput", "fullPhoneNumber"];

  connect() {
    console.log("phone number controller connected")
    this.updateFullPhoneNumber();
  }

  toggleDropdown(event) {
    event.preventDefault();
    event.stopPropagation();
    this.dropdownMenuTarget.classList.toggle('hidden');
  }

  selectCountryCode(event) {
    if (event.target.tagName === 'LI') {
      const dataValue = event.target.getAttribute('data-value');
      this.dropdownSpanTarget.textContent = dataValue;
      this.dropdownMenuTarget.classList.add('hidden');
      this.updateFullPhoneNumber();
    }
  }

  closeDropdown(event) {
    const isClickInside = this.element.contains(event.target);
    if (!isClickInside) {
      this.dropdownMenuTarget.classList.add('hidden');
    }
  }

  updatePhoneNumber(event) {
    event.target.value = event.target.value.replace(/\D/g, '').slice(0, 12);
    this.updateFullPhoneNumber();
  }

  updateFullPhoneNumber() {
    const countryCode = this.dropdownSpanTarget.textContent;
    const phoneNumber = this.phoneNumberInputTarget.value;
    this.fullPhoneNumberTarget.value = countryCode + phoneNumber;
  }
}
