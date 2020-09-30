(function ($) {
  let params = {};

  function init(_params) {
    params = _params;

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

    var option = new Option(params.country.name, params.country.id, true, true);
    countryNameSelect.append(option).trigger('change');

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

    var option = new Option(params.country.alias, params.country.id, true, true);
    countryAliasSelect.append(option).trigger('change');

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

    var option = new Option(params.state.name, params.state.id, true, true);
    stateSelect.append(option).trigger('change');

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

    var option = new Option(params.city.name, params.state.id, true, true);
    citySelect.append(option).trigger('change');
  }

  $.locations_edit = {
    init: init,
  }

})(jQuery);
