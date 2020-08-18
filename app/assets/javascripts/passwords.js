(function() {
  $(function() {
    let isAdmin = true;
    if (app.getUser() != undefined) {
      isAdmin = app.getUser().is_admin
    }
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
