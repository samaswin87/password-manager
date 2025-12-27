// Users - converted to vanilla JS
// File upload is handled by file_upload_controller.js
// User status is handled by user_status_controller.js
// DataTable functionality needs to be replaced with a vanilla JS solution or Turbo Frames

document.addEventListener('DOMContentLoaded', function() {
  const submitFileBtn = document.getElementById('submit-file-user');
  if (submitFileBtn) {
    submitFileBtn.addEventListener('click', function() {
      const importId = document.getElementById('import_id');
      if (!importId || !importId.value) {
        console.error('Import ID not found');
        return;
      }

      const fieldMap = {
        first_name: document.querySelector("select[name='first_name']")?.value || '',
        last_name: document.querySelector("select[name='last_name']")?.value || '',
        gender: document.querySelector("select[name='gender']")?.value || '',
        email: document.querySelector("select[name='email']")?.value || ''
      };

      putData('/upload/' + importId.value + '/import', { fieldMap: fieldMap })
        .then(data => {
          const searchParams = new URLSearchParams(window.location.search);
          searchParams.set("job", data.job_id);
          window.location.search = searchParams.toString();
        })
        .catch(error => {
          console.error('Error submitting file:', error);
        });

      // Hide modal
      const modal = document.getElementById("user-file-modal");
      if (modal && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
        const bsModal = bootstrap.Modal.getInstance(modal);
        if (bsModal) {
          bsModal.hide();
        }
      }
    });
  }

  // User status toggle is handled by user_status_controller.js

  // DataTable initialization
  // Note: DataTables requires jQuery. For a jQuery-free solution, consider:
  // 1. Using Turbo Frames for server-side rendering
  // 2. Using a vanilla JS table library
  // 3. Implementing custom table with Stimulus controller
  const usersTable = document.getElementById('users-datatable');
  if (usersTable) {
    const source = usersTable.dataset.source;
    console.log('Users table found, source:', source);
    // DataTable initialization would go here if using a vanilla JS alternative
    // For now, the table will work with basic HTML/CSS
  }

  // File upload button
  const uploadFileBtn = document.getElementById('upload_file');
  if (uploadFileBtn) {
    uploadFileBtn.addEventListener('click', function() {
      // Hide form groups
      document.querySelectorAll(".row.form-group.mt-5").forEach(function(row) {
        row.classList.add('d-none');
      });

      // Show modal
      const modal = document.getElementById("user-file-modal");
      if (modal && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
      }
    });
  }
});
