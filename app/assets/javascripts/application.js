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
//= require jquery_ujs
//= require bootstrap
//= require adminlte
//= require bootstrap-wysihtml5
//= require selectize
//= require bootstrap-datepicker
//= require bootstrap-switch
//= require jQuery-Mask-Plugin
//= require jquery.slimscroll
//= require momentjs
//= require notifyjs
//= require toastr
//= require jquery-fileupload/basic
//= require papaparse
//= require vendor/notifyset
//= require datatables
//= require select2-full
//= require bs-stepper
//= require api
// require_tree .

$(document).ready(function(){

  var clipboard;
  if (typeof ClipboardJS !== 'undefined')
    clipboard = new ClipboardJS('.clipboard-btn');

  $('.nav-tabs > li').on('click', function(event){
    $(".nav-tabs > li").removeClass("active");
    $(event.target).parent().addClass('active');
  });
});

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
