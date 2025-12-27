import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { name: String }

  add(event) {
    event.preventDefault()
    const field = event.currentTarget.id

    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    
    fetch('/field_mappings/create_or_update', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrf
      },
      body: JSON.stringify({
        field_mapping: {
          name: this.nameValue,
          field: field
        }
      })
    })
    .then(() => {
      window.location.reload()
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}

