$ ->
  $('#users-datatable').dataTable
    processing: true
    serverSide: true
    ajax:
      url: $('#users-datatable').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'first_name'}
      {data: 'last_name'}
      {data: 'email'}
      {data: 'phone'}
      {data: 'gender', 'orderable': false, 'searchable': false}
      {data: 'type', 'orderable': false, 'searchable': false}
      {"data": "action", bSortable: false}
    ]
