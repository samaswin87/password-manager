(function() {
  $(function() {
    $('#user_status').click(function() {
      var isAdmin = false;
      if (app.getUser() != undefined) {
        isAdmin = app.getUser().is_admin
      }
      if (!isAdmin)
        return

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

    $('#users-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#users-datatable').data('source')
      },
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
          data: 'status'
        }, {
          "data": "action",
          bSortable: false
        }
      ]
    });
  });

}).call(this);
