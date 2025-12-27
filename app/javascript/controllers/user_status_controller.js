import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    event.preventDefault()
    
    // Check if user is admin
    const user = window.app && window.app.getUser()
    if (!user || !user.is_admin) {
      return
    }

    const url = window.location.pathname
    const id = url.substring(url.lastIndexOf('/') + 1)
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")

    fetch(`${id}/status`, {
      method: 'PUT',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': csrf,
        'Accept': 'application/json'
      }
    })
    .then(() => {
      window.location.reload()
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}

