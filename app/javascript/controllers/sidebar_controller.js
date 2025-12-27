import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this.restoreState()
  }

  toggle(event) {
    event.preventDefault()
    const isMobile = window.innerWidth <= 768

    if (isMobile) {
      document.body.classList.toggle("sidebar-open")
      document.body.classList.add("sidebar-collapse")
    } else {
      document.body.classList.toggle("sidebar-collapse")
      const state = document.body.classList.contains("sidebar-collapse") ? "collapsed" : "expanded"
      localStorage.setItem("sidebar-state", state)
    }
  }

  restoreState() {
    if (window.innerWidth > 768) {
      const state = localStorage.getItem("sidebar-state")
      if (state === "collapsed") {
        document.body.classList.add("sidebar-collapse")
      }
    }
  }
}

