// States - converted to vanilla JS

window.editState = function(stateId, stateName) {
  const nameField = document.getElementById("modal-field-name");
  const idField = document.getElementById("modal-field-id");
  const modal = document.getElementById("state-modal");
  
  if (nameField) nameField.value = stateName || '';
  if (idField) idField.value = stateId || '';
  
  if (modal && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
    const bsModal = new bootstrap.Modal(modal);
    bsModal.show();
  } else if (modal) {
    modal.style.display = 'block';
    modal.classList.add('show');
  }
};

document.addEventListener('DOMContentLoaded', function() {
  const submitBtn = document.getElementById("submit-modal-state");
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
        url = "/states/" + id;
        method = "PATCH";
        data = { state: { name: name, id: id } };
      } else {
        url = "/states/";
        method = "POST";
        data = { state: { name: name } };
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

  const addStateBtn = document.getElementById("add-state");
  if (addStateBtn) {
    addStateBtn.addEventListener('click', function() {
      const modal = document.getElementById("state-modal");
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
  const statesTable = document.getElementById('states-datatable');
  if (statesTable && statesTable.dataset.source) {
    console.log('States table initialized');
  }
});
