(function ($) {
  var params;

  function init(_params){
    params = _params;
  }

  $( ".add-field" ).click(function(e) {
    postData('/field_mappings/create_or_update', {field_mapping: {name: params.name, field: this.id}})
    .then(data => {
      location.reload();
    });
  });

  $.mapper = {
    init: init,
  }

})(jQuery);
