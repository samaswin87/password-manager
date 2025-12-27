// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require selectize
//= require jquery.mask.min
//= require jquery.slimscroll
//= require moment
//= require notifyjs_rails
//= require toastr
//= require papaparse
//= require vendor/simple-fileupload
//= require vendor/notifyset
//= require datatables
//= require select2-full
//= require bs-stepper
//= require api
//= require admin
// require_tree .

$(document).ready(function(){

  var _clipboard;
  if (typeof ClipboardJS !== 'undefined')
    _clipboard = new ClipboardJS('.clipboard-btn');

  $('.nav-tabs > li').on('click', function(event){
    $(".nav-tabs > li").removeClass("active");
    $(event.target).parent().addClass('active');
  });
});

// eslint-disable-next-line no-unused-vars
var app = (function(){
  var user_data;

  $.ajax({
    type: "GET",
    url: "/current_user",
    async: false,
    success : function(data) {
      user_data = data;
    }
  });

  return {getUser : function()
  {
    return user_data;
  }};
})();
