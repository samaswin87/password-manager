(function() {
  window.applyFormControls = function() {
    $('.selectize-single').selectize({
      create: false
    });
    $(".texteditor").wysihtml5({
      toolbar: {
        'fa': true,
        'link': false,
        'image': false,
        'font-styles': false
      }
    });
    $('img').lazyload();
    $('.cpf').mask('000.000.000-00');
    $('.cnpj').mask('00.000.000/0000-00');
    $('.phone').mask('+91 9999999999');
    return $('.cep').mask('00000-000');
  };

  $(function() {
    return applyFormControls();
  });

}).call(this);
