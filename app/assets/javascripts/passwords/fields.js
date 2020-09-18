(function ($) {
  let params = {};
  let url = {};
  let isAdmin = true;

  function init(_params, _url){
    params = _params;
    url = _url;
    isAdmin = params.isAdmin;
  }

  Array.prototype.remove = function (v) {
    if (this.indexOf(v) != -1) {
        this.splice(this.indexOf(v), 1);
        return true;
    }
    return false;
  }

  let fileArray = [];

  genPassword = function(e) {
    $("#password_text_password").val(generatePassword(true, true, true, false, 20));
  };

  $('#file_upload').click(function(e) {
    e.preventDefault();
    var formData = new FormData();
    for (var i = 0; i < fileArray.length; i++) {
      formData.append("attachments[]", fileArray[i]);
    }
    putFiles('uploads', formData).then(data => {
      location.reload();
    });
  });

  $('#file_attachments').change(function(e) {
    let filesArray = $.merge(fileArray, e.target.files);

    $('.template-upload').remove();
    filesArray.forEach( function(element, index) {
      const row = '<tr class="template-upload">'+
      '  <td>'+
      '    <p class="id">'+(index + 1)+
      '    </p>'+
      '  </td>'+
      '  <td>'+
      '    <p class="name">'+element.name+
      '    </p>'+
      '    <strong class="error text-danger"></strong>'+
      '  </td>'+
      '  <td>'+
      '    <button class="btn btn-warning cancel pull-right remove-file" id="remove_'+index+'">'+
      '        <i class="fa fa-minus-circle"></i>'+
      '    </button>'+
      '  </td>'+
      '</tr>';
      $('#files_preview > tbody').append(row);
      $('#remove_'+index).click(function(e) {
        e.preventDefault();
        fileArray.remove(element);
        $(this).parent().parent().remove();
      });
    });
  });

  $('.eye-btn').click(function() {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var $pwd = $("#copy-text_password");
    if ($pwd.attr('type') === undefined) {
      $pwd = $("#password_text_password");
    }
    if ($pwd.attr('type') === 'password') {
      $pwd.attr('type', 'text');
    } else {
      $pwd.attr('type', 'password');
    }
  });

  $('#password_status').click(function() {
    var url = window.location.pathname;
    var id = url.substring(url.lastIndexOf('/') + 1);
    $.ajax({
        type: "PUT",
        url: id+'/status',
        dataType: 'JSON',
        complete: function() {
          location.reload();
        }
    });
  });

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

  $.password = {
    init: init,
  }

})(jQuery);
