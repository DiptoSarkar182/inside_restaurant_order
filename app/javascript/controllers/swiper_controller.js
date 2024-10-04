import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log("swiper stimulus connected")
    const swiper = new Swiper(this.element, {
      direction: 'horizontal',
      loop: true,
      loopFillGroupWithBlank: true,
      pagination: {
        el: this.element.querySelector('.swiper-pagination'),
        clickable: true,
      },
      navigation: {
        nextEl: this.element.querySelector('.swiper-button-next'),
        prevEl: this.element.querySelector('.swiper-button-prev'),
      },
    });
  }
}
