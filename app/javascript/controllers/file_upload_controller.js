import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "label", "message"]
  static values = { 
    type: String,
    maxSize: Number,
    allowedExtensions: Array
  }

  connect() {
    this.fileArray = []
    if (this.hasInputTarget) {
      this.inputTarget.addEventListener('change', this.handleFileSelect.bind(this))
    }
  }

  handleFileSelect(event) {
    const files = Array.from(event.target.files)
    
    files.forEach(file => {
      // Validate file size
      const maxSize = this.hasMaxSizeValue ? this.maxSizeValue : 10000000 // 10MB default
      if (file.size > maxSize) {
        this.showError('Error: Not a valid file. Please import file less than 10 MB')
        return
      }

      // Validate extension
      const extension = file.name.split('.').pop().toLowerCase()
      const allowedExtensions = this.hasAllowedExtensionsValue ? this.allowedExtensionsValue : ['csv']
      if (!allowedExtensions.includes(extension)) {
        this.showError(`Error: Not a valid file. Please import ${allowedExtensions.join(' or ')} file`)
        return
      }

      this.fileArray.push(file)
      this.updatePreview()
      
      // Update label
      if (this.hasLabelTarget) {
        this.labelTarget.textContent = file.name
      }
    })
  }

  updatePreview() {
    if (!this.hasPreviewTarget) return

    // Clear existing preview
    this.previewTarget.querySelectorAll('.template-upload').forEach(row => row.remove())

    const tbody = this.previewTarget.querySelector('tbody')
    if (!tbody) return

    this.fileArray.forEach((file, index) => {
      const row = document.createElement('tr')
      row.className = 'template-upload'
      row.innerHTML = `
        <td><p class="id">${index + 1}</p></td>
        <td><p class="name">${this.escapeHtml(file.name)}</p><strong class="error text-danger"></strong></td>
        <td>
          <button class="btn btn-warning cancel pull-right remove-file" data-action="click->file-upload#removeFile" data-index="${index}">
            <i class="fa fa-minus-circle"></i>
          </button>
        </td>
      `
      tbody.appendChild(row)
    })
  }

  removeFile(event) {
    const index = parseInt(event.currentTarget.dataset.index)
    if (index >= 0 && index < this.fileArray.length) {
      this.fileArray.splice(index, 1)
      this.updatePreview()
    }
  }

  upload(event) {
    event.preventDefault()
    
    if (this.fileArray.length === 0) {
      this.showError('Please select a file to upload')
      return
    }

    const formData = new FormData()
    this.fileArray.forEach(file => {
      formData.append("attachments[]", file)
    })

    if (this.hasTypeValue) {
      formData.append("type", this.typeValue)
    }

    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")

    fetch('/upload', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'X-CSRF-Token': csrf
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      // Handle CSV parsing if needed
      if (data.files && data.files.length > 0) {
        this.parseCSV(data.files[0])
      }
      this.handleUploadSuccess(data)
    })
    .catch(error => {
      console.error('Upload error:', error)
      this.showError('Error uploading file')
    })
  }

  parseCSV(file) {
    if (typeof Papa === 'undefined') {
      console.warn('PapaParse not available')
      return
    }

    Papa.parse(file, {
      header: true,
      skipEmptyLines: true,
      complete: (results) => {
        if (results.errors.length) {
          this.showError('CSV Error: ' + results.errors[0].message)
        } else {
          this.populateFieldMappings(results.meta.fields)
        }
      }
    })
  }

  populateFieldMappings(fields) {
    // Populate select fields with CSV columns
    document.querySelectorAll('select.form-control').forEach((select, index) => {
      // Remove first option if it's a placeholder
      const firstOption = select.querySelector('option')
      if (firstOption && !firstOption.value) {
        firstOption.remove()
      }

      fields.forEach((field, fieldIndex) => {
        const option = document.createElement('option')
        option.value = field
        option.textContent = field
        if (index === fieldIndex) {
          option.selected = true
        }
        select.appendChild(option)
      })
    })
  }

  handleUploadSuccess(data) {
    // Store import ID if provided
    const importIdField = document.getElementById('import_id')
    if (importIdField && data.id) {
      importIdField.value = data.id
    }

    // Show form if hidden
    document.querySelectorAll('.row.form-group.mt-5').forEach(row => {
      row.classList.remove('d-none')
    })

    // Dispatch custom event
    this.dispatch('uploaded', { detail: data })
  }

  showError(message) {
    if (this.hasMessageTarget) {
      const code = this.messageTarget.querySelector('code')
      if (code) {
        code.textContent = message
      }
    }
  }

  escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
}

