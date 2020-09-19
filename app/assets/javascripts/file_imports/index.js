(function ($) {
  function init() {}

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
        data: 'data_updated_on'
      }, {
        data: 'completed_on'
      }, {
        data: 'status'
      }, {
        "data": "counts",
        bSortable: false
      }
    ]
  });
  $.file_imports_show = {
    init: init,
  }

})(jQuery);
