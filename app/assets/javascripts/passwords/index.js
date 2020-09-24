(function ($) {
  let params = {};
  let url = {};
  let isAdmin = true;

  function init(_params, _url){
    params = _params;
    url = _url;
    isAdmin = params.isAdmin;
  }

  var $passwordsDatatable = $('#passwords-datatable').DataTable({
    processing: true,
    serverSide: true,
    autoWidth: false,
    dom: "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
          "<'row'<'col-sm-12'tr>>" +
          "<'row'<'col-sm-5'i><'col-sm-7'p>>",
    ajax: {
      url: url.home
    },
    buttons: [
      {
        text: 'Active',
        className: 'active-passwords',
        action: function ( e, dt, node, config ) {
          $('.active-passwords').toggleClass("active");
          if ($('.active-passwords').hasClass('active')) {
            $('.in-active-passwords').removeClass('active');
            dt.column(4).search(true).draw();
          } else {
            dt.column(4).search('').draw();
          }
        }
      },
      {
        text: 'In Active',
        className: 'in-active-passwords',
        action: function ( e, dt, node, config ) {
          $('.in-active-passwords').toggleClass("active");
          if ($('.in-active-passwords').hasClass('active')) {
            $('.active-passwords').removeClass('active');
            dt.column(4).search(false).draw();
          } else {
            dt.column(4).search('').draw();
          }
        }
      },
      {
          extend: 'csv',
          title: 'Passwords',
          className: 'btn-space',
          exportOptions: {
            columns: [ 0, 1, 2, 3 ]
          }
      },
    ],
    initComplete: function() {
     $('.active-passwords').html('<i class="fa fa-square" />');
     $('.in-active-passwords').html('<i class="fa fa-square" />');
     $('.buttons-csv').html('<i class="fa fa-file-excel-o" />');
    },
    pagingType: 'full_numbers',
    columns: [
      {
        "data": "logo",
        bSort: false,
        searchable: false
      },{
        data: 'name'
      }, {
        data: 'username'
      }, {
        data: 'url'
      },{
        data: 'status',
        visible: isAdmin,
      }, {
        "data": "action",
        bSortable: false
      }
    ],
    columnDefs: [
      { width: 200, targets: 3 }
    ],
  }).on("init.dt", function (e, settings) {
    $button = $("<button type='button' name='upload_file' id='upload_file' data-targe='#password-file-modal' class='btn btn-file btn-primary btn-sm'><i class='fa fa-upload fa-lg btn-file'></i>Import CSV</button>");
    $('#passwords-datatable_filter').prepend($button);
    $('#upload_file').click(function() {
      $("#password-file-modal").modal("show");
    });

    $('#fileupload').fileupload({
      maxNumberOfFiles: 1,
      url: '/upload',
      formData: {
        type: 'passwords'
      },
      add: function (e, data) {
        $('.custom-file-label').html(data.files[0].name);
        var extension = data.files[0].name.split('.').pop();
        if(data.files[0].size > 10000000) {
          $('.message > code').html('Error: Not a valid file. Please import file less than 10 MB');
          return false;
        }
        if (extension === 'csv'){
          data.submit();
        } else {
          $('.message > code').html('Error: Not a valid file. Please import csv file');
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


  $passwordsDatatable
  .buttons( 'commands', null )
  .containers()
  .addClass('group-right')
  .insertBefore('.dt-buttons');

  $.password_index = {
    init: init,
  }

})(jQuery);
