(function ($) {
  let params = {};
  let url = {};

  function init(_params, _url){
    params = _params;
    url = _url;
  }

  $('#upload-next').click(function(event) {
    var stepperNode = document.querySelector('#file_upload')
    var stepper = new Stepper(document.querySelector('#file_upload'))

    stepperNode.addEventListener('show.bs-stepper', function (event) {
      console.warn('show.bs-stepper', event)
    })
    stepperNode.addEventListener('shown.bs-stepper', function (event) {
      console.warn('shown.bs-stepper', event)
    })
    stepper.next();
  });

  $.file_imports_show = {
    init: init,
  }

})(jQuery);
