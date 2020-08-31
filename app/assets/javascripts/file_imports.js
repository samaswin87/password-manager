(function() {
  $(function() {
    $('#file_imports-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#file_imports-datatable').data('source')
      },
      pagingType: 'full_numbers',
      columns: [
        {
          data: 'data_file_name'
        }, {
          data: 'data_content_type'
        }, {
          data: 'source_type'
        }, {
          "data": "counts",
          bSortable: false
        }
      ]
    });
  });

}).call(this);
