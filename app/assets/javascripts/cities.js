(function() {
  $(function() {
    editCity = function(cityId, cityName) {
      $("#modal-field-name").val(cityName);
      $("#modal-field-id").val(cityId);
      $("#city-modal").modal("show");
    };

    $( "#submit-modal-city" ).click(function() {
      let name = $("#modal-field-name").val();
      let id = $("#modal-field-id").val();
      if (typeof id !== 'undefined' && id) {
        let data = {city: {name: name, id: id}};
        let url = "/cities/"+id;
        $.ajax({
          type: "PATCH",
          url: url,
          data: data,
          dataType: 'JSON',
          complete: function() {
            location.reload();
          }
         });
      } else {
        let url = "/cities/";
        let data = {city: {name: name}};
        $.ajax({
          type: "POST",
          url: url,
          data: data,
          dataType: 'JSON',
          complete: function() {
            location.reload();
          }
         });
      }
    });

    $( "#add-city" ).click(function() {
      $("#city-modal").modal("show");
    });


    $('#cities-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#cities-datatable').data('source')
      },
      pagingType: 'full_numbers',
      columns: [
        {
          data: 'name'
        }, {
          data: 'created_at'
        }, {
          data: 'updated_at'
        }, {
          "data": "action",
          bSortable: false
        }
      ]
    });
  });

}).call(this);
