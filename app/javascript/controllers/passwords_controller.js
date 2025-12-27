import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    passwordsUrl: String
  }

  static targets = ["container", "search", "filter", "card"]

  connect() {
    this.currentPage = 1
    this.searchQuery = ''
    this.currentFilter = 'all'
    this.searchTimeout = null
    this.setupEventListeners()
  }

  setupEventListeners() {
    if (this.hasSearchTarget) {
      this.searchTarget.addEventListener('input', (e) => {
        this.searchQuery = e.target.value
        clearTimeout(this.searchTimeout)
        this.searchTimeout = setTimeout(() => {
          this.loadPasswords(1)
        }, 300)
      })
    }

    if (this.hasFilterTarget) {
      this.filterTargets.forEach((filter) => {
        filter.addEventListener('click', (e) => {
          e.preventDefault()
          this.filterTargets.forEach((f) => f.classList.remove('active'))
          filter.classList.add('active')
          this.currentFilter = filter.dataset.filter || 'all'
          this.loadPasswords(1)
        })
      })
    }
  }

  loadPasswords(page) {
    page = page || this.currentPage
    const params = new URLSearchParams({ page: page })

    if (this.searchQuery) {
      params.set('search', this.searchQuery)
    }

    if (this.currentFilter !== 'all') {
      params.set('filter', this.currentFilter)
    }

    fetch(`${this.passwordsUrlValue}?${params.toString()}`, {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.json())
    .then(data => {
      this.renderPasswords(data)
      this.currentPage = page
    })
    .catch(error => {
      console.error('Error loading passwords:', error)
      this.showError('Error loading passwords. Please refresh the page.')
    })
  }

  renderPasswords(data) {
    const passwords = data.data || []
    const pagy = data.pagy

    if (passwords.length === 0) {
      this.showEmptyState()
      return
    }

    const cardsHtml = passwords.map(password => this.createPasswordCard(password)).join('')
    this.containerTarget.innerHTML = '<div class="passwords-grid">' + cardsHtml + '</div>'
    
    if (pagy && pagy.pages > 1) {
      this.renderPagination(pagy)
    }
  }

  createPasswordCard(password) {
    const strength = this.calculatePasswordStrength(password)
    const status = this.getPasswordStatus(password)
    const logoHtml = this.getLogoHtml(password)
    const isActive = status === 'Active'

    return `
      <div class="password-card" data-id="${password.DT_RowId}">
        <div class="password-card-header">
          <div class="password-card-logo">${logoHtml}</div>
          <div class="password-card-title-section">
            <h3 class="password-card-title">${this.escapeHtml(password.name || 'Unnamed')}</h3>
            <div class="password-card-url">
              <i class="fa fa-globe"></i>
              <span>${this.escapeHtml(password.url || 'No URL')}</span>
            </div>
          </div>
          <div class="password-card-status">
            <span class="label ${isActive ? 'label-success' : 'label-danger'}">${status}</span>
          </div>
        </div>
        <div class="password-card-info">
          <div class="password-info-row">
            <div class="password-info-icon"><i class="fa fa-user"></i></div>
            <div class="password-info-content">
              <div class="password-info-label">Username</div>
              <div class="password-info-value">${this.escapeHtml(password.username || 'Not set')}</div>
            </div>
            ${password.username ? `
              <button class="quick-copy-btn" data-copy="${this.escapeHtml(password.username)}" title="Copy username">
                <i class="fa fa-copy"></i>
              </button>
            ` : ''}
          </div>
          <div class="password-info-row">
            <div class="password-info-icon"><i class="fa fa-key"></i></div>
            <div class="password-info-content">
              <div class="password-info-label">Password</div>
              <div class="password-info-value hidden">••••••••</div>
            </div>
            <button class="quick-copy-btn" data-copy="password" data-id="${password.DT_RowId}" title="Copy password">
              <i class="fa fa-copy"></i>
            </button>
          </div>
          <div class="password-info-row">
            <div class="password-info-icon"><i class="fa fa-link"></i></div>
            <div class="password-info-content">
              <div class="password-info-label">URL</div>
              <div class="password-info-value">${this.escapeHtml(password.url || 'Not set')}</div>
            </div>
            ${password.url ? `
              <a href="${this.escapeHtml(password.url)}" target="_blank" class="quick-copy-btn" title="Open URL">
                <i class="fa fa-external-link"></i>
              </a>
            ` : ''}
          </div>
        </div>
        <div class="password-strength">
          <div class="password-strength-label">
            <span>Password Strength</span>
            <span class="password-strength-text ${strength.level}">${strength.label}</span>
          </div>
          <div class="password-strength-bar">
            <div class="password-strength-fill ${strength.level}"></div>
          </div>
        </div>
        <div class="password-card-actions">
          <a href="/passwords/${password.DT_RowId}" class="password-card-btn password-card-btn-primary">
            <i class="fa fa-eye"></i><span>View</span>
          </a>
          <a href="/passwords/${password.DT_RowId}/edit" class="password-card-btn password-card-btn-success">
            <i class="fa fa-edit"></i><span>Edit</span>
          </a>
          <a href="/passwords/${password.DT_RowId}" data-method="delete" data-confirm-swal="Are you sure?" class="password-card-btn password-card-btn-danger">
            <i class="fa fa-trash"></i><span>Delete</span>
          </a>
        </div>
      </div>
    `
  }

  calculatePasswordStrength() {
    // Simplified - in production, fetch from server
    return { level: 'medium', label: 'Medium' }
  }

  getPasswordStatus(password) {
    if (typeof password.status === 'string') {
      const tempDiv = document.createElement('div')
      tempDiv.innerHTML = password.status
      return tempDiv.textContent.trim()
    }
    return password.status || 'Active'
  }

  getLogoHtml(password) {
    if (password.logo) {
      const tempDiv = document.createElement('div')
      tempDiv.innerHTML = password.logo
      const img = tempDiv.querySelector('img')
      if (img) {
        return `<img src="${img.src}" alt="${this.escapeHtml(password.name)}">`
      }
    }
    return '<i class="fa fa-lock"></i>'
  }

  renderPagination(pagy) {
    let html = '<nav class="pagy-nav" role="navigation" aria-label="Pagination"><ul class="pagination">'

    if (pagy.prev) {
      html += `<li class="page-item"><a class="page-link" href="#" data-action="click->passwords#goToPage" data-page="${pagy.prev}"><span>&laquo;</span></a></li>`
    } else {
      html += '<li class="page-item disabled"><span class="page-link">&laquo;</span></li>'
    }

    const startPage = Math.max(1, pagy.page - 2)
    const endPage = Math.min(pagy.pages, pagy.page + 2)

    if (startPage > 1) {
      html += `<li class="page-item"><a class="page-link" href="#" data-action="click->passwords#goToPage" data-page="1">1</a></li>`
      if (startPage > 2) {
        html += '<li class="page-item disabled"><span class="page-link">...</span></li>'
      }
    }

    for (let i = startPage; i <= endPage; i++) {
      if (i === pagy.page) {
        html += `<li class="page-item active"><span class="page-link">${i}</span></li>`
      } else {
        html += `<li class="page-item"><a class="page-link" href="#" data-action="click->passwords#goToPage" data-page="${i}">${i}</a></li>`
      }
    }

    if (endPage < pagy.pages) {
      if (endPage < pagy.pages - 1) {
        html += '<li class="page-item disabled"><span class="page-link">...</span></li>'
      }
      html += `<li class="page-item"><a class="page-link" href="#" data-action="click->passwords#goToPage" data-page="${pagy.pages}">${pagy.pages}</a></li>`
    }

    if (pagy.next) {
      html += `<li class="page-item"><a class="page-link" href="#" data-action="click->passwords#goToPage" data-page="${pagy.next}"><span>&raquo;</span></a></li>`
    } else {
      html += '<li class="page-item disabled"><span class="page-link">&raquo;</span></li>'
    }

    html += '</ul>'
    html += `<div class="pagy-info">Showing ${pagy.from} to ${pagy.to} of ${pagy.count} passwords</div>`
    html += '</nav>'

    const grid = this.containerTarget.querySelector('.passwords-grid')
    if (grid) {
      grid.insertAdjacentHTML('afterend', html)
    }
  }

  goToPage(event) {
    event.preventDefault()
    const page = parseInt(event.currentTarget.dataset.page)
    if (page && page !== this.currentPage) {
      this.loadPasswords(page)
      const container = document.getElementById('passwords-container')
      if (container) {
        window.scrollTo({
          top: container.offsetTop - 100,
          behavior: 'smooth'
        })
      }
    }
  }

  showEmptyState(message) {
    const emptyMessage = message || 'No passwords found'
    this.containerTarget.innerHTML = `
      <div class="passwords-empty-state">
        <div class="passwords-empty-icon"><i class="fa fa-key"></i></div>
        <h3 class="passwords-empty-title">No Passwords Yet</h3>
        <p class="passwords-empty-text">${emptyMessage}</p>
        <a href="/passwords/new" class="btn btn-primary btn-lg">
          <i class="fa fa-plus margin-r-5"></i>Add Your First Password
        </a>
      </div>
    `
  }

  showError(message) {
    this.showEmptyState(message)
  }

  escapeHtml(text) {
    if (!text) return ''
    const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    }
    return String(text).replace(/[&<>"']/g, m => map[m])
  }
}

