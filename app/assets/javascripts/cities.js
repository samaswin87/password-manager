(function() {
  $(function() {
    $('#cities-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#cities-datatable').data('source')
      },
      pagingType: 'full_numbers',
      columns: [
        {
          data: 'name'
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
