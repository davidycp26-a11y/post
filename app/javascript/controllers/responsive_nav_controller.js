import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.updateNavigation()
    window.addEventListener("resize", () => this.updateNavigation())
  }

  disconnect() {
    window.removeEventListener("resize", () => this.updateNavigation())
  }

  updateNavigation() {
    const isMobile = window.innerWidth <= 768

    this.linkTargets.forEach(link => {
      if (isMobile) {
        // On mobile: remove turbo-frame to enable full page navigation
        link.removeAttribute("data-turbo-frame")
      } else {
        // On desktop: add turbo-frame to load content in right panel
        link.setAttribute("data-turbo-frame", "post_detail")
      }
    })
  }
}
