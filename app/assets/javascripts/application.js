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
//
//= require jquery
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
//= require datatables
//= require_tree .

$(document).ready(function(){
  var clipboard = new ClipboardJS('.clipboard-btn');
  $('.sidebar-menu > li.treeview > a').append("<span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span>")
});

let app = (function(){
  let user_data;

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
