(function() {
  $(function() {
    var isAdmin = true;
    if (app.getUser() != undefined) {
      isAdmin = app.getUser().is_admin
    }

    genPassword = function() {
      $("#password_text_password").val(generatePassword(true, true, true, false, 20));
    };

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

    $('#passwords-datatable').dataTable({
      processing: true,
      serverSide: true,
      autoWidth: false,
      ajax: {
        url: $('#passwords-datatable').data('source')
      },
      pagingType: 'full_numbers',
      columns: [
        {
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
  });

}).call(this);
