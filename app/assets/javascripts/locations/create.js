// Locations create - converted to vanilla JS
// Select2 is replaced with native select or can use a Stimulus controller for enhanced selects

function init(_params) {
  loadData();
}

function loadData() {
  // Select2 replacement - using native select with fetch for dynamic options
  // For enhanced select functionality, consider using a Stimulus controller
  
  const countryNameSelect = document.getElementById("country_name");
  if (countryNameSelect) {
    setupSelectWithAjax(countryNameSelect, '/locations/countries?type=name');
  }

  const countryAliasSelect = document.getElementById("country_alias");
  if (countryAliasSelect) {
    setupSelectWithAjax(countryAliasSelect, '/locations/countries?type=alias');
  }

  const stateSelect = document.getElementById("state_name");
  if (stateSelect) {
    setupSelectWithAjax(stateSelect, '/locations/states');
  }

  const citySelect = document.getElementById("city_name");
  if (citySelect) {
    setupSelectWithAjax(citySelect, '/locations/cities');
  }
}

function setupSelectWithAjax(select, url) {
  // Load options on focus or input
  select.addEventListener('focus', function() {
    if (this.options.length <= 1) {
      loadSelectOptions(this, url);
    }
  });

  // Allow custom input (tags: true equivalent)
  if (select.hasAttribute('data-tags')) {
    select.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' && e.target.value) {
        e.preventDefault();
        const option = document.createElement('option');
        option.value = e.target.value;
        option.textContent = e.target.value;
        option.selected = true;
        this.appendChild(option);
      }
    });
  }
}

function loadSelectOptions(select, url) {
  fetch(url, {
    method: 'GET',
    credentials: 'same-origin',
    headers: {
      'Accept': 'application/json'
    }
  })
  .then(response => response.json())
  .then(data => {
    // Clear existing options except the first one (if it's a placeholder)
    const firstOption = select.querySelector('option');
    const isPlaceholder = firstOption && !firstOption.value;
    
    if (!isPlaceholder) {
      select.innerHTML = '';
    } else {
      while (select.children.length > 1) {
        select.removeChild(select.lastChild);
      }
    }

    // Add new options
    if (data.records) {
      data.records.forEach(record => {
        const option = document.createElement('option');
        option.value = record.id || record.value;
        option.textContent = record.text || record.name;
        select.appendChild(option);
      });
    }
  })
  .catch(error => {
    console.error('Error loading options:', error);
  });
}

window.location_create = {
  init: init,
};
