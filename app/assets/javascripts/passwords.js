(function() {
  $(function() {
    var isAdmin = true;
    if (app.getUser() != undefined) {
      isAdmin = app.getUser().is_admin
    }

    genPassword = function() {
      $("#password_text_password").val(generatePassword(true, true, true, false, 20));
    };

    $('#file_attachments').change(function(e) {
      e.target.files.forEach( function(element, index) {
        var row = '<tr class="template-upload">'+
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
        '    <button class="btn btn-warning cancel pull-right">'+
        '        <i class="fa fa-minus-circle"></i>'+
        '    </button>'+
        '  </td>'+
        '</tr>';
        $('#files_preview > tbody').append(row);
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
        url: $('#passwords-datatable').data('source')
      },
      buttons: [
        {
          text: 'Active',
          className: 'active-passwords',
          action: function ( e, dt, node, config ) {
            $('.active-passwords').toggleClass("active");
            if ($('.active-passwords').hasClass('active')) {
              $('.in-active-passwords').removeClass('active');
              dt.column(3).search('active').draw();
            } else {
              dt.column(3).search('').draw();
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
              dt.column(3).search('in-active').draw();
            } else {
              dt.column(3).search('').draw();
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
          visible: isAdmin
        }, {
          "data": "action",
          bSortable: false
        }
      ],
      columnDefs: [
        { width: 200, targets: 3 }
      ],
    });


    $passwordsDatatable
    .buttons( 'commands', null )
    .containers()
    .addClass('group-right')
    .insertBefore('.dt-buttons');

  });

}).call(this);
