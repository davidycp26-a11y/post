import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview"]

  change(event) {
    const filename = event.target.value
    this.previewTarget.src = `/avatars/${filename}`
  }
}