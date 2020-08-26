(function() {
  $(function() {
    $('#user_status').click(function() {
      var isAdmin = false;
      if (app.getUser() != undefined) {
        isAdmin = app.getUser().is_admin
      }
      if (!isAdmin)
        return

      var url = window.location.pathname;
      var id = url.substring(url.lastIndexOf('/') + 1);
      $.ajax({
          type: "PUT",
          url: id+'/status',
          dataType: 'JSON',
          complete: function() {
            location.reload();
          }
      });
    });

    $('#users-datatable').dataTable({
      processing: true,
      serverSide: true,
      dom: "<'row'<'col-sm-3'l><'col-sm-6 text-center'B><'col-sm-3'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-sm-5'i><'col-sm-7'p>>",
      ajax: {
        url: $('#users-datatable').data('source')
      },
      buttons: [
        {
          text: 'Active',
          className: 'active-users',
          action: function ( e, dt, node, config ) {
            $('.active-users').toggleClass("active");
            if ($('.active-users').hasClass('active')) {
              $('.in-active-users').removeClass('active');
              dt.column(6).search('active').draw();
            } else {
              dt.column(6).search('').draw();
            }
          }
        },
        {
          text: 'In Active',
          className: 'in-active-users',
          action: function ( e, dt, node, config ) {
            $('.in-active-users').toggleClass("active");
            if ($('.in-active-users').hasClass('active')) {
              $('.active-users').removeClass('active');
              dt.column(6).search('in-active').draw();
            } else {
              dt.column(6).search('').draw();
            }
          }
        },
        {
            extend: 'csv',
            title: 'Users',
            className: 'btn-space',
            exportOptions: {
              columns: [ 0, 1, 2, 3, 4]
            }
        },
      ],
      pagingType: 'full_numbers',
      columns: [
        {
          data: 'first_name'
        }, {
          data: 'last_name'
        }, {
          data: 'email'
        }, {
          data: 'phone'
        }, {
          data: 'gender',
          'orderable': false,
          bSortable: false
        }, {
          data: 'type',
          'orderable': false,
          bSortable: false
        }, {
          data: 'status'
        }, {
          "data": "action",
          bSortable: false
        }
      ],
      initComplete: function() {
       $('.active-users').html('<i class="fa fa-square" />');
       $('.in-active-users').html('<i class="fa fa-square" />');
       $('.buttons-csv').html('<i class="fa fa-file-excel-o" />');
      }
    });
  });

}).call(this);
