// Locations index - converted to vanilla JS

function init() {}

document.addEventListener('DOMContentLoaded', function() {
  const searchForm = document.querySelector('.search');
  if (searchForm) {
    searchForm.addEventListener('submit', function(event) {
      event.preventDefault();
      const locationInput = document.querySelector("input[name=location]");
      if (locationInput) {
        window.location.href = '/locations?search=' + encodeURIComponent(locationInput.value);
      }
    });
  }

  const locationInput = document.querySelector("input[name=location]");
  if (locationInput) {
    locationInput.addEventListener('keyup', function(event) {
      if (event.keyCode === 8 && !this.value) {
        window.location.href = '/locations';
      }
    });
  }

  const searchInputs = document.querySelectorAll('input[type=search]');
  searchInputs.forEach(function(input) {
    input.addEventListener('click', function() {
      const searchHandler = function() {
        if (!this.value) {
          window.location.href = '/locations';
        }
      };
      input.addEventListener('search', searchHandler);
      setTimeout(function() {
        input.removeEventListener('search', searchHandler);
      }, 1);
    });
  });
});

window.locations_index = {
  init: init,
};
