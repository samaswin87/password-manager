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

  $.file_imports_show = {
    init: init,
  }

})(jQuery);
