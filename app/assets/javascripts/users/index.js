(function ($) {
  let params;
  let url;
  let _isAdmin;

  function init(_params, _url){
    params = _params;
    url = _url;
    _isAdmin = params.isAdmin;

    loadDataTable()
  }

  loadDataTable = function() {
    $('#users-datatable').DataTable({
      processing: true,
      serverSide: true,
      dom: "<'row'<'col-sm-6 text-right'B><'col-sm-6'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-5'i><'col-sm-7'p>>",
      ajax: {
        url: url.home
      },
      buttons: [
        {
          extend: 'copyHtml5',
          text: params.active,
          titleAttr: params.active,
          className: 'filter-button active-users',
          action: function ( _e, dt, _node, _config ) {
            $('.active-users').toggleClass("active");
            if ($('.active-users').hasClass('active')) {
              $('.in-active-users').removeClass('active');
              dt.column(6).search('active').draw();
            } else {
              dt.column(6).search('').draw();
            }
          }
        },
        {
          extend: 'copyHtml5',
          text: params.in_active,
          titleAttr: params.in_active,
          className: 'filter-button in-active-users',
          action: function ( _e, dt, _node, _config ) {
            $('.in-active-users').toggleClass("active");
            if ($('.in-active-users').hasClass('active')) {
              $('.active-users').removeClass('active');
              dt.column(6).search('in-active').draw();
            } else {
              dt.column(6).search('').draw();
            }
          }
        },
        {
            extend: 'csv',
            title: params.title,
            className: 'filter-button btn-space',
            exportOptions: {
              columns: [ 0, 1, 2, 3, 4]
            }
        },
      ],
      pagingType: 'full_numbers',
      columns: [
        {
          data: 'first_name'
        }, {
          data: 'last_name'
        }, {
          data: 'email'
        }, {
          data: 'phone'
        }, {
          data: 'gender',
          'orderable': false,
          bSortable: false
        }, {
          data: 'type',
          'orderable': false,
          bSortable: false
        }, {
          data: 'status',
          bSortable: false,
          visible: false
        }, {
          "data": "action",
          bSortable: false
        }
      ],
      initComplete: function() {
       $('.filter-button').html('<i class="fa-solid fa-square"></i>');
       $('.buttons-csv').html('<i class="fa-solid fa-file-csv"></i>');
      }
    })
    .on("init.dt", function (_e, _settings) {
      $button = $("<button type='button' name='upload_file' id='upload_file' data-target='#user-file-modal' class='btn btn-file btn-primary btn-sm'>"+
        "<i class='fa-solid fa-upload'></i> "+params.import_csv+"</button>");
      $('#users-datatable_filter').prepend($button);
      $('#upload_file').click(function() {
        $(".row.form-group.mt-5").addClass('d-none');
        // Use Bootstrap 5 modal API if available, otherwise fall back to jQuery
        if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
          var modalElement = document.getElementById('user-file-modal');
          var modal = new bootstrap.Modal(modalElement);
          modal.show();
        } else {
          $("#user-file-modal").modal("show");
        }
      });

      $('#fileupload').fileupload({
        maxNumberOfFiles: 1,
        url: '/upload',
        formData: {
          type: 'users'
        },
        add: function (_e, data) {
          $('.custom-file-label').html(data.files[0].name);
          var extension = data.files[0].name.split('.').pop();
          if(data.files[0].size > 10000000) {
            $('.message > code').html(params.file_size_error);
            return false;
          }
          if (extension === 'csv'){
            data.submit();
          } else {
            $('.message > code').html(params.file_type_error);
            return false;
          }
        },
      });

      $('#fileupload').bind('fileuploaddone', function(_e, data) {
        window.location.replace("/file_imports/"+data.result.import_id);
      });

      $('#fileupload').bind('fileuploadfail', function(_e, data) {
        if(data.jqXHR.responseText) {
          // Use Bootstrap 5 modal API if available, otherwise fall back to jQuery
          if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
            var modalElement = document.getElementById('user-file-modal');
            var modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) {
              modal.hide();
            }
          } else {
            $("#user-file-modal").modal("hide");
          }
          $.notify.autoHideNotify('error', 'top right', 'Alert', data.jqXHR.responseText);
        }
      });
    });
  }

  $.users_index = {
    init: init,
  }

})(jQuery);
