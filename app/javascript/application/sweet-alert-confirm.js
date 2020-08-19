import Rails from 'rails-ujs'
import Swal from 'sweetalert2/dist/sweetalert2.js'
import 'sweetalert2/src/sweetalert2.scss'

const confirmed = (element, result) => {
  if (result.value) {
    // User clicked confirm button
    element.removeAttribute('data-confirm-swal')
    element.click()
  }
}

// Display the confirmation dialog
const showConfirmationDialog = (element) => {
  const message = element.getAttribute('data-confirm-swal')
  const text = element.getAttribute('data-text')

  Swal.fire({
    title: message || 'Are you sure?',
    text: text || '',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes',
    cancelButtonText: 'Cancel',
  }).then(result => confirmed(element, result))
}

const allowAction = (element) => {
  if (element.getAttribute('data-confirm-swal') === null) {
    return true
  }

  showConfirmationDialog(element)
  return false
}

function handleConfirm(element) {
  if (!allowAction(this)) {
    Rails.stopEverything(element)
  }
}

Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm)
