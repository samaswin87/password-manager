// Password fields - converted to vanilla JS
// Password toggle is now handled by Stimulus: password_toggle_controller.js
// Password status is now handled by Stimulus: password_status_controller.js

let params;
let _url;
let _isAdmin;

function init(_params, url) {
  params = _params;
  _url = url;
  _isAdmin = params.isAdmin;
}

Array.prototype.remove = function (v) {
  if (this.indexOf(v) != -1) {
    this.splice(this.indexOf(v), 1);
    return true;
  }
  return false;
}

let fileArray = [];

window.genPassword = function(_e) {
  const passwordField = document.getElementById("password_text_password");
  if (passwordField && typeof generatePassword === 'function') {
    passwordField.value = generatePassword(true, true, true, false, 20);
  }
};

document.addEventListener('DOMContentLoaded', function() {
  const fileUploadBtn = document.getElementById('file_upload');
  if (fileUploadBtn) {
    fileUploadBtn.addEventListener('click', function(e) {
      e.preventDefault();
      const formData = new FormData();
      for (let i = 0; i < fileArray.length; i++) {
        formData.append("attachments[]", fileArray[i]);
      }
      putFiles('uploads', formData).then(_data => {
        location.reload();
      });
    });
  }

  const fileAttachments = document.getElementById('file_attachments');
  if (fileAttachments) {
    fileAttachments.addEventListener('change', function(e) {
      const newFiles = Array.from(e.target.files);
      fileArray = fileArray.concat(newFiles);

      // Remove existing preview rows
      document.querySelectorAll('.template-upload').forEach(function(row) {
        row.remove();
      });

      const tbody = document.querySelector('#files_preview > tbody');
      if (tbody) {
        fileArray.forEach(function(element, index) {
          const row = document.createElement('tr');
          row.className = 'template-upload';
          row.innerHTML = 
            '<td><p class="id">' + (index + 1) + '</p></td>' +
            '<td><p class="name">' + element.name + '</p><strong class="error text-danger"></strong></td>' +
            '<td><button class="btn btn-warning cancel pull-right remove-file" id="remove_' + index + '"><i class="fa fa-minus-circle"></i></button></td>';
          
          tbody.appendChild(row);
          
          const removeBtn = document.getElementById('remove_' + index);
          if (removeBtn) {
            removeBtn.addEventListener('click', function(e) {
              e.preventDefault();
              fileArray.remove(element);
              row.remove();
            });
          }
        });
      }
    });
  }
});

window.passwordFields = {
  init: init,
};
