import { Controller } from "@hotwired/stimulus"

// Simple table controller to replace DataTables
// For full DataTables functionality, consider using a vanilla JS library
// or implementing server-side rendering with Turbo Frames

export default class extends Controller {
  static values = {
    source: String,
    processing: Boolean
  }

  connect() {
    this.currentPage = 1
    this.searchQuery = ''
    this.statusFilter = ''
    this.loadData()
  }

  loadData() {
    if (!this.hasSourceValue) return

    const params = new URLSearchParams({
      draw: this.currentPage,
      start: (this.currentPage - 1) * 10,
      length: 10
    })

    if (this.searchQuery) {
      params.set('search[value]', this.searchQuery)
    }

    if (this.statusFilter) {
      params.set('status', this.statusFilter)
    }

    fetch(`${this.sourceValue}?${params.toString()}`, {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.json())
    .then(data => {
      this.renderTable(data)
    })
    .catch(error => {
      console.error('Error loading table data:', error)
    })
  }

  renderTable(data) {
    // Basic table rendering
    // This is a simplified version - enhance as needed
    console.log('Table data loaded:', data)
  }

  search(event) {
    this.searchQuery = event.target.value
    this.currentPage = 1
    this.loadData()
  }

  filterStatus(status) {
    this.statusFilter = status
    this.currentPage = 1
    this.loadData()
  }
}

