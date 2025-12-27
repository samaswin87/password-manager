// Cities - converted to vanilla JS

window.editCity = function(cityId, cityName) {
  const nameField = document.getElementById("modal-field-name");
  const idField = document.getElementById("modal-field-id");
  const modal = document.getElementById("city-modal");
  
  if (nameField) nameField.value = cityName || '';
  if (idField) idField.value = cityId || '';
  
  if (modal && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
    const bsModal = new bootstrap.Modal(modal);
    bsModal.show();
  } else if (modal) {
    // Fallback for older Bootstrap
    modal.style.display = 'block';
    modal.classList.add('show');
  }
};

document.addEventListener('DOMContentLoaded', function() {
  const submitBtn = document.getElementById("submit-modal-city");
  if (submitBtn) {
    submitBtn.addEventListener('click', function() {
      const nameField = document.getElementById("modal-field-name");
      const idField = document.getElementById("modal-field-id");
      
      if (!nameField) return;
      
      const name = nameField.value;
      const id = idField ? idField.value : null;
      const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");
      
      let url, method, data;
      
      if (id) {
        url = "/cities/" + id;
        method = "PATCH";
        data = { city: { name: name, id: id } };
      } else {
        url = "/cities/";
        method = "POST";
        data = { city: { name: name } };
      }
      
      fetch(url, {
        method: method,
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrf,
          'Accept': 'application/json'
        },
        body: JSON.stringify(data)
      })
      .then(() => {
        location.reload();
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
  }

  const addCityBtn = document.getElementById("add-city");
  if (addCityBtn) {
    addCityBtn.addEventListener('click', function() {
      const modal = document.getElementById("city-modal");
      const nameField = document.getElementById("modal-field-name");
      const idField = document.getElementById("modal-field-id");
      
      if (nameField) nameField.value = '';
      if (idField) idField.value = '';
      
      if (modal && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
      } else if (modal) {
        modal.style.display = 'block';
        modal.classList.add('show');
      }
    });
  }

  // DataTable replacement - using a simple table for now
  // For full DataTable functionality, consider using a vanilla JS alternative
  // or implementing server-side pagination with Turbo
  const citiesTable = document.getElementById('cities-datatable');
  if (citiesTable && citiesTable.dataset.source) {
    // Basic table initialization - can be enhanced with a Stimulus controller
    // for sorting, pagination, etc.
    console.log('Cities table initialized');
  }
});
