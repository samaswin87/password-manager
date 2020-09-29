(function ($) {
  let params = {};

  function init(_params) {
    params = _params;

    loadData();
  }

  loadData = function() {
    let country_names = [];
    params.countries.forEach( function(element, index) {
      country_names.push({
        id: element[0],
        text: element[1]
      });
    });

    let country_alias = [];
    params.countries.forEach( function(element, index) {
      country_alias.push({
        id: element[0],
        text: element[2]
      });
    });

    let states = [];
    params.states.forEach( function(element, index) {
      states.push({
        id: element[0],
        text: element[1]
      });
    });

    let cities = [];
    params.cities.forEach( function(element, index) {
      cities.push({
        id: element[0],
        text: element[1]
      });
    });

    $( "#country_name" ).select2({
      theme: "bootstrap",
      tags: true,
      data: country_names
    });
    $( "#country_alias" ).select2({
      theme: "bootstrap",
      tags: true,
      data: country_alias
    });
    $( "#state_name" ).select2({
      theme: "bootstrap",
      tags: true,
      data: states
    });
    $( "#city_name" ).select2({
      theme: "bootstrap",
      tags: true,
      data: cities
    });
  }

  $.locations_edit = {
    init: init,
  }

})(jQuery);
