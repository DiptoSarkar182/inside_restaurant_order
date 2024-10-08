import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["menu"];
    timeout;

    show() {
        clearTimeout(this.timeout);
        this.menuTarget.classList.remove("hidden");
    }

    hide() {
        this.timeout = setTimeout(() => {
            this.menuTarget.classList.add("hidden");
        }, 200);
    }
}
