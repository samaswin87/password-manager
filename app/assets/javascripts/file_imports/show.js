(function ($) {
  let params = {};
  let url = {};
  let column_haders = [];

  function init(_params, _url){
    params = _params;
    url = _url;

    (params.headers || []).forEach(header => {
      column_haders.push({
        data: header
      })
    })

    column_haders.push({
        data: 'action',
        bSortable: false
    })

    loadDataTable()

    $('#copy-mappings').val(JSON.stringify(params.mappings, undefined, 4))
  }


  loadDataTable = function() {
    $('#import-records-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#import-records-datatable').data('source')
      },
      pagingType: 'full_numbers',
      columns: column_haders || []
    })
  }

  $('#upload-next').click(function(_event) {
    window.location.href = url.home_path + '?page=mapper'
  });

  $('#upload-cancel').click(function(_event) {
    window.location.href = url.redirect_path
  });

  $('#mapper-next').click(function(_event) {
    fieldMaps = {}
    params.fields.forEach(field => {
      fieldMaps[field] = $("select[name='"+field+"']").val()
    })
    putData(url.home_path, { field_maps: fieldMaps})
    .then(_data => {
      window.location.href = url.home_path + '?page=records'
    });
  });

  $('#mapper-prev').click(function(_event) {
    window.location.href = url.home_path
  });

  $('#preview-prev').click(function(_event) {
    window.location.href = url.home_path + '?page=mapper'
  });

  $('#preview-submit').click(function(_event) {
    putData(url.submit_path).then(_data => {
      window.location.href = url.redirect_path
    });
  });


  $.file_imports_show = {
    init: init,
  }

})(jQuery);
