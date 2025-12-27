import { Controller } from "@hotwired/stimulus"

// Simple input mask implementation
function applyMask(input, mask) {
  let value = input.value.replace(/\D/g, '')
  let maskedValue = ''
  let valueIndex = 0

  for (let i = 0; i < mask.length && valueIndex < value.length; i++) {
    if (mask[i] === '0') {
      maskedValue += value[valueIndex]
      valueIndex++
    } else {
      maskedValue += mask[i]
    }
  }

  return maskedValue
}

export default class extends Controller {
  static values = { mask: String }

  connect() {
    this.applyMask()
    this.element.addEventListener('input', this.handleInput.bind(this))
  }

  disconnect() {
    this.element.removeEventListener('input', this.handleInput.bind(this))
  }

  handleInput() {
    this.applyMask()
  }

  applyMask() {
    if (this.hasMaskValue) {
      this.element.value = applyMask(this.element, this.maskValue)
    }
  }
}

// Initialize masks for common patterns
document.addEventListener('DOMContentLoaded', function() {
  // CPF: 000.000.000-00
  document.querySelectorAll('.cpf').forEach(function(input) {
    input.addEventListener('input', function() {
      let value = this.value.replace(/\D/g, '')
      if (value.length <= 11) {
        value = value.replace(/(\d{3})(\d)/, '$1.$2')
        value = value.replace(/(\d{3})(\d)/, '$1.$2')
        value = value.replace(/(\d{3})(\d{1,2})$/, '$1-$2')
        this.value = value
      }
    })
  })

  // CNPJ: 00.000.000/0000-00
  document.querySelectorAll('.cnpj').forEach(function(input) {
    input.addEventListener('input', function() {
      let value = this.value.replace(/\D/g, '')
      if (value.length <= 14) {
        value = value.replace(/^(\d{2})(\d)/, '$1.$2')
        value = value.replace(/^(\d{2})\.(\d{3})(\d)/, '$1.$2.$3')
        value = value.replace(/\.(\d{3})(\d)/, '.$1/$2')
        value = value.replace(/(\d{4})(\d)/, '$1-$2')
        this.value = value
      }
    })
  })

  // Phone: +91 9999999999
  document.querySelectorAll('.phone').forEach(function(input) {
    input.addEventListener('input', function() {
      let value = this.value.replace(/\D/g, '')
      if (value.length > 0) {
        if (value.length <= 2) {
          this.value = '+' + value
        } else if (value.length <= 12) {
          this.value = '+' + value.substring(0, 2) + ' ' + value.substring(2)
        }
      }
    })
  })

  // CEP: 00000-000
  document.querySelectorAll('.cep').forEach(function(input) {
    input.addEventListener('input', function() {
      let value = this.value.replace(/\D/g, '')
      if (value.length <= 8) {
        if (value.length > 5) {
          value = value.substring(0, 5) + '-' + value.substring(5)
        }
        this.value = value
      }
    })
  })
})

