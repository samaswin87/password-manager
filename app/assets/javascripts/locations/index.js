(function ($) {
  function init() {}

  //Referred: https://stackoverflow.com/a/35047611/2634405
  $(".search").submit( function(event) {
    event.preventDefault();
    window.location.href =  '/locations?search='+ $("input[name=location]").val()
  });

  $("input[name=location]").keyup( function(event) {
    if (event.keyCode === 8 && !$("input[name=location]").val()) {
      window.location.href =  '/locations'
    }
  });


  $('input[type=search]').on('click', function(){
    $('input[type=search]').on('search', function(){
      if(!this.value){
        window.location.href =  '/locations'
      }
    });
    setTimeout(function() {
      $('input[type=search]').off('search');
    }, 1);
  });

  $.locations_index = {
    init: init,
  }

})(jQuery);
