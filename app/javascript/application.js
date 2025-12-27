// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { showNotification } from "controllers/notification_controller"

// Make notification available globally
window.showNotification = showNotification
