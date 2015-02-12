//= require_directory ../
//= require dataTables/jquery.dataTables

$(document).ready(function () {
  var defaultDataTableOptions = {
    "processing" : true,
    "serverSide" : true,
    "ajax"       : $('.datatable').data('source'),
    "pagingType" : 'full_numbers'
  };

  $('.datatable.questionnaires').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [2, 'asc'],
    "scrollX"    : true,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
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
      {}
    ]
  }));
});
