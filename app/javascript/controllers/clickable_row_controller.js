import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    // Ändert den Mauszeiger, um zu signalisieren, dass die Zeile klickbar ist
    this.element.style.cursor = "pointer"
  }

  visit(event) {
    // Verhindert das Auslösen, wenn der Nutzer auf einen echten Link oder Button innerhalb der Zeile klickt
    if (event.target.closest("a") || event.target.closest("button")) return

    // Nutzt Turbo für schnelles Laden ohne kompletten Seiten-Refresh
    if (typeof Turbo !== "undefined") {
      Turbo.visit(this.urlValue)
    } else {
      window.location.href = this.urlValue
    }
  }
}