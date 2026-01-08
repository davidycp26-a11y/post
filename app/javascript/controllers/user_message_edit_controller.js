import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-message-edit"
export default class extends Controller {
  static targets = ["display", "form", "textarea", "actions"]

  connect() {
    // Ensure correct initial state when controller connects
    this.reset()
  }

  edit() {
    // Hide display content and show edit form
    this.displayTarget.style.display = "none"
    this.formTarget.style.display = "block"
    this.actionsTarget.style.display = "none"

    // Focus on textarea
    this.textareaTarget.focus()
  }

  cancel() {
    this.reset()
  }

  reset() {
    // Show display content and hide edit form
    this.displayTarget.style.display = "block"
    this.formTarget.style.display = "none"
    this.actionsTarget.style.display = "flex"
  }
}
