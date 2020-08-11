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
      sEmptyTable: "Nenhum registro encontrado"
      sInfo: "Mostrando de _START_ até _END_ de _TOTAL_ registros"
      sInfoEmpty: "Mostrando 0 até 0 de 0 registros"
      sInfoFiltered: "(Filtrados de _MAX_ registros)"
      sInfoPostFix: ""
      sInfoThousands: "."
      sLengthMenu: "_MENU_ resultados por página"
      sLoadingRecords: "Carregando..."
      sProcessing: "Processando..."
      sZeroRecords: "Nenhum registro encontrado"
      sSearch: "Pesquisar"
      oPaginate:
        sNext: "Próximo"
        sPrevious: "Anterior"
        sFirst: "Primeiro"
        sLast: "Último"
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
