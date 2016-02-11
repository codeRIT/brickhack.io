var setupDataTables = function() {
  var defaultDataTableOptions = {
    dom: 'Bfrtip',
    "processing" : true,
    "serverSide" : true,
    "ajax"       : {
      "url"   : $('.datatable').data('source'),
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
  };

  window.questionnairesDataTable = $('.datatable.questionnaires').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [2, 'desc'],
    "scrollX"    : true,
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
  }));

  $('.datatable.users').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [1, 'asc'],
    "scrollX"    : true,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {}
    ]
  }));

  $('.datatable.messages').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [1, 'desc'],
    "scrollX"    : true,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
      { "orderable" : false }
    ]
  }));

  $('.datatable.schools').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [5, 'desc'],
    "scrollX"    : true,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
      {},
      {}
    ]
  }));
};
