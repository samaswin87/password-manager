(function() {
  $(function() {
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
          "data": "action",
          bSortable: false
        }
      ]
    });
  });

}).call(this);
