(function() {
  $(function() {
    editState = function(stateId, stateName) {
      $("#modal-field-name").val(stateName);
      $("#modal-field-id").val(stateId);
      $("#state-modal").modal("show");
    };

    $( "#submit-modal-state" ).click(function() {
      var name = $("#modal-field-name").val();
      var id = $("#modal-field-id").val();
      if (typeof id !== 'undefined' && id) {
        var data = {state: {name: name, id: id}};
        var url = "/states/"+id;
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
        var url = "/states/";
        var data = {state: {name: name}};
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

    $( "#add-state" ).click(function() {
      $("#state-modal").modal("show");
    });

    $('#states-datatable').dataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: $('#states-datatable').data('source')
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
