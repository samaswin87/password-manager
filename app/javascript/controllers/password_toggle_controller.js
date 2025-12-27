import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["password", "icon"]

  toggle() {
    const passwordField = this.passwordTarget
    const icon = this.iconTarget || this.element.querySelector('i')
    
    if (icon) {
      icon.classList.toggle("fa-eye")
      icon.classList.toggle("fa-eye-slash")
    }
    
    if (passwordField.type === 'password') {
      passwordField.type = 'text'
      if (this.element.setAttribute) {
        this.element.setAttribute('title', 'Hide password')
      }
    } else {
      passwordField.type = 'password'
      if (this.element.setAttribute) {
        this.element.setAttribute('title', 'Show password')
      }
    }
  }
}

