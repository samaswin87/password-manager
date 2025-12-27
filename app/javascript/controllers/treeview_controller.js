import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    event.preventDefault()
    const parent = this.element
    const isActive = parent.classList.contains("active")
    const menu = parent.querySelector("> .treeview-menu")

    // Close all other treeview menus
    document.querySelectorAll(".sidebar-menu .treeview").forEach((item) => {
      if (item !== parent) {
        item.classList.remove("active")
        const otherMenu = item.querySelector("> .treeview-menu")
        if (otherMenu) {
          otherMenu.style.display = "none"
        }
      }
    })

    // Toggle current menu
    if (!isActive) {
      parent.classList.add("active")
      if (menu) {
        menu.style.display = "block"
      }
    } else {
      parent.classList.remove("active")
      if (menu) {
        menu.style.display = "none"
      }
    }
  }
}

