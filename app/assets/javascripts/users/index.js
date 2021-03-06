(function ($) {
  let params = {};
  let url = {};
  let isAdmin = true;

  function init(_params, _url){
    params = _params;
    url = _url;
    isAdmin = params.isAdmin;

    loadDataTable()
  }

  loadDataTable = function() {
    var $usersDatatable = $('#users-datatable').DataTable({
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
          action: function ( e, dt, node, config ) {
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
          action: function ( e, dt, node, config ) {
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
          bSortable: false
        }, {
          "data": "action",
          bSortable: false
        }
      ],
      initComplete: function() {
       $('.filter-button').html('<i class="fa fa-square" />');
       $('.buttons-csv').html('<i class="fa fa-file-excel-o" />');
      }
    })
    .on("init.dt", function (e, settings) {
      $button = $("<button type='button' name='upload_file' id='upload_file' data-target='#user-file-modal' class='btn btn-file btn-primary btn-sm'>"+
        "<i class='fa fa-upload fa-lg btn-file'></i>"+params.import_csv+"</button>");
      $('#users-datatable_filter').prepend($button);
      $('#upload_file').click(function() {
        $(".row.form-group.mt-5").addClass('d-none');
        $("#user-file-modal").modal("show");
      });

      $('#fileupload').fileupload({
        maxNumberOfFiles: 1,
        url: '/upload',
        formData: {
          type: 'users'
        },
        add: function (e, data) {
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

      $('#fileupload').bind('fileuploaddone', function(e, data) {
        window.location.replace("/file_imports/"+data.result.import_id);
      });

      $('#fileupload').bind('fileuploadfail', function(e, data) {
        if(data.jqXHR.responseText) {
          $("#password-file-modal").modal("hide");
          $.notify.autoHideNotify('error', 'top right', 'Alert', data.jqXHR.responseText);
        }
      });
    });
  }

  $.users_index = {
    init: init,
  }

})(jQuery);
