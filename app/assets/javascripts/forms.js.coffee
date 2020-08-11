window.applyFormControls = ->
  $('.selectize-single').selectize
    create: false

  $(".texteditor").wysihtml5 toolbar:
    'fa': true
    'link': false
    'image': false
    'font-styles': false

  $('img').lazyload()

  $('.cpf').mask '000.000.000-00'
  $('.cnpj').mask '00.000.000/0000-00'
  $('.phone').mask '(00) 000000000'
  $('.cep').mask '00000-000'

$ ->
  applyFormControls()
