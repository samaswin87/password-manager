(function() {
  $(function() {
    editCity = function(cityId, cityName) {
      $("#modal-field-name").val(cityName);
      $("#modal-field-id").val(cityId);
      $("#city-modal").modal("show");
    };

    $( "#modal-submit" ).click(function() {
      let name = $("#modal-field-name").val();
      let id = $("#modal-field-id").val();
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
