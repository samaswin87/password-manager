(function() {
  $(function() {
    $('#passwords-datatable').dataTable({
      processing: true,
      serverSide: true,
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
        }, {
          data: 'created_at'
        }, {
          data: 'updated_at'
        }, {
          "data": "action",
          bSortable: false
        }
      ]
    });
  });

}).call(this);
