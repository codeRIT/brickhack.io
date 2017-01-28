var setupDataTables = function() {

  var defaultDataTableOptions = function() {
    return {
      dom: 'Bfrtip',
      "processing" : true,
      "serverSide" : true,
      "ajax"       : {
        "url"   : $(this).data('source'),
        "type"  : "POST"
      },
      "pagingType" : 'full_numbers',
      lengthMenu: [
        [ 10, 25, 50, 100, -1 ],
        [ '10 rows', '25 rows', '50 rows', '100 rows', 'Show all' ]
      ],
      buttons: [
        'pageLength',
        {
          extend: 'collection',
          text: 'Export',
          buttons: [
            'csvHtml5',
            'pdfHtml5'
          ]
        }
      ]
    }
  };

  var setupDataTable = function($table, options) {
    var lastTable;
    $table.each(function() {
      lastTable = $(this).DataTable($.extend(defaultDataTableOptions.call(this), options));
    });

    return lastTable;
  };

  window.questionnairesDataTable = setupDataTable($('.datatable.questionnaires'), {
    "order"      : [2, 'desc'],
    "scrollX"    : false,
    "columns"    : [
      { "orderable" : false },
      { "orderable" : false },
      {},
      {},
      {},
      {},
      {},
      {},
      {}
    ]
  });

  setupDataTable($('.datatable.users'), {
    "order"      : [1, 'asc'],
    "scrollX"    : false,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {}
    ]
  });

  setupDataTable($('.datatable.messages'), {
    "order"      : [1, 'desc'],
    "scrollX"    : false,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
      { "orderable" : false }
    ]
  });

  setupDataTable($('.datatable.schools'), {
    "order"      : [5, 'desc'],
    "scrollX"    : false,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
      {},
      {},
      { "orderable" : false }
    ]
  });

  setupDataTable($('.datatable.stats'), {
    "scrollX"    : false,
    "processing" : false,
    "serverSide" : false
  });
};
