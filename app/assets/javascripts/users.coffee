$ ->
  window.UserDataTable = $("#users").dataTable(
    sDom: "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#users").data("source")
    fnServerData: (sSource, aaData, fnCallback) ->
      $.getJSON sSource, aaData, (json) ->
        fnCallback json

    oLanguage:
      sEmptyTable: "No records found"
      sInfo: "Showing _START_ to _END_ of _TOTAL_ entries"
      sInfoEmpty: "Showing 0 to 0 of 0 entries"
      sInfoFiltered: "(Filtrados de _MAX_ registros)"
      sInfoPostFix: ""
      sInfoThousands: "."
      sLengthMenu: "_MENU_ entries"
      sLoadingRecords: "Carregando..."
      sProcessing: "Processando..."
      sZeroRecords: "No records found"
      sSearch: "Search"
      oPaginate:
        sNext: "Next"
        sPrevious: "Previous"
        sFirst: "First"
        sLast: "Current"
      oAria:
        sSortAscending: ": Ordenar colunas de forma ascendente"
        sSortDescending: ": Ordenar colunas de forma descendente"

    aoColumnDefs: [
      bSortable: false
      aTargets: [3]
    ]

    fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
      $("td:eq(3)", nRow).addClass "text-center"

    bAutoWidth: false
  )
