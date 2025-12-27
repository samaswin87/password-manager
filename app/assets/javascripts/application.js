// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require popper
//= require bootstrap
//= require papaparse
//= require bs-stepper
//= require api
//= require admin
// require_tree .

// Initialize clipboard on page load
document.addEventListener('DOMContentLoaded', function() {
  if (typeof ClipboardJS !== 'undefined') {
    new ClipboardJS('.clipboard-btn');
  }
});

// User data cache
window.app = (function(){
  var user_data = null;
  var userDataPromise = null;

  function fetchUserData() {
    if (userDataPromise) {
      return userDataPromise;
    }
    
    userDataPromise = fetch('/current_user', {
      method: 'GET',
      credentials: 'same-origin',
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.json())
    .then(data => {
      user_data = data;
      return data;
    })
    .catch(error => {
      console.error('Error fetching user data:', error);
      return null;
    });
    
    return userDataPromise;
  }

  // Fetch user data on initialization
  fetchUserData();

  return {
    getUser: function() {
      return user_data;
    },
    fetchUser: function() {
      return fetchUserData();
    }
  };
})();
