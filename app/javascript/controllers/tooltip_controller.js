// app/javascript/controllers/tooltip_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["tooltip"];

    connect() {
        this.initializeTooltips();
    }

    initializeTooltips() {
        // Assuming tippy is available globally from the CDN
        if (typeof tippy !== "undefined") {
            tippy(this.tooltipTargets, {
                content: (reference) => reference.getAttribute("data-tippy-content"),
                placement: "top",
            });
        } else {
            console.warn("Tippy.js is not loaded.");
        }
    }
}
