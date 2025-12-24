import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-edit"
export default class extends Controller {
  static targets = ["display", "form", "textarea", "actions"]

  edit() {
    // Hide display content and show edit form
    this.displayTarget.style.display = "none"
    this.formTarget.style.display = "block"
    this.actionsTarget.style.display = "none"

    // Focus on textarea
    this.textareaTarget.focus()
  }

  cancel() {
    // Show display content and hide edit form
    this.displayTarget.style.display = "block"
    this.formTarget.style.display = "none"
    this.actionsTarget.style.display = "flex"
  }
}
