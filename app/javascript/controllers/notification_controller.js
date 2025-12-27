// Simple notification system to replace $.notify
// This is a utility module, not a Stimulus controller

export function showNotification(type, position, title, message) {
  // Create notification element
  const notification = document.createElement('div')
  notification.className = `alert alert-${type === 'error' ? 'danger' : type} alert-dismissible fade show`
  notification.style.cssText = `
    position: fixed;
    ${position.includes('top') ? 'top' : 'bottom'}: 20px;
    ${position.includes('right') ? 'right' : 'left'}: 20px;
    z-index: 9999;
    min-width: 300px;
    max-width: 400px;
  `
  
  // Escape HTML to prevent XSS
  const escapeHtml = (text) => {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
  }
  
  notification.innerHTML = `
    <strong>${escapeHtml(title)}</strong> ${escapeHtml(message)}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  `
  
  document.body.appendChild(notification)
  
  // Auto-hide after 3 seconds
  setTimeout(() => {
    if (notification.parentNode) {
      notification.classList.remove('show')
      setTimeout(() => {
        if (notification.parentNode) {
          notification.remove()
        }
      }, 150)
    }
  }, 3000)
}

