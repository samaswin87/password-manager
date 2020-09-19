(function ($) {
  let params = {};
  let url = {};

  function init(_params, _url){
    params = _params;
    url = _url;
  }

  $('#upload-next').click(function(event) {
    window.location.href = url.home_path + '?page=mapper'
  });

  $('#upload-cancel').click(function(event) {
    window.location.href = url.redirect_path
  });

  $('#mapper-next').click(function(event) {
    fieldMaps = {}
    params.fields.forEach(field => {
      fieldMaps[field] = $("select[name='"+field+"']").val()
    })
    putData(url.home_path, { field_maps: fieldMaps})
    .then(data => {
      window.location.href = url.home_path + '?page=records'
    });
  });

  $('#mapper-cancel').click(function(event) {
    window.location.href = url.home_path + '?page=mapper'
  });

  $('#import-records-datatable').dataTable({
    processing: true,
    serverSide: true,
    ajax: {
      url: $('#import-records-datatable').data('source')
    },
    pagingType: 'full_numbers',
    columns: [
      {
        data: 'data_file_name'
      }
    ]
  });

  $.file_imports_show = {
    init: init,
  }

})(jQuery);
