(function() {
  $(function() {
    var isAdmin = true;
    if (app.getUser() != undefined) {
      isAdmin = app.getUser().is_admin
    }

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

    $( "#show_password" ).click(function() {
      var $pwd = $("#copy-password");
      if ($pwd.attr('type') === undefined) {
        $pwd = $("#password_password");
      }
      if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
      } else {
        $pwd.attr('type', 'password');
      }
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
