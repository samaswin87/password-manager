(function ($) {

  function init(_params) {
    loadData();
  }

  loadData = function() {

    let countryNameSelect = $("#country_name");
    countryNameSelect.select2({
      theme: "bootstrap",
      tags: true,
      ajax: {
        url: '/locations/countries?type=name',
        processResults: function (data) {
          return {
            results: data.records
          };
        }
      }
    });

    let countryAliasSelect = $("#country_alias");
    countryAliasSelect.select2({
      theme: "bootstrap",
      tags: true,
      ajax: {
        url: '/locations/countries?type=alias',
        processResults: function (data) {
          return {
            results: data.records
          };
        }
      }
    });

    let stateSelect = $("#state_name");
    stateSelect.select2({
      theme: "bootstrap",
      tags: true,
      ajax: {
        url: '/locations/states',
        processResults: function (data) {
          return {
            results: data.records
          };
        }
      }
    });

    let citySelect = $("#city_name");
    citySelect.select2({
      theme: "bootstrap",
      tags: true,
      ajax: {
        url: '/locations/cities',
        processResults: function (data) {
          return {
            results: data.records
          };
        }
      }
    });

  }

  $.location_create = {
    init: init,
  }

})(jQuery);
