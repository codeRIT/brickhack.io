//= require_directory ../
//= require dataTables/jquery.dataTables
//= require selectize

$(document).ready(function () {
  $('.selectize').selectize();

  var defaultDataTableOptions = {
    "processing" : true,
    "serverSide" : true,
    "ajax"       : $('.datatable').data('source'),
    "pagingType" : 'full_numbers'
  };

  $('.datatable.questionnaires').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [1, 'desc'],
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
      {},
      {}
    ]
  }));

  $('.datatable.messages').DataTable($.extend(defaultDataTableOptions, {
    "order"      : [1, 'asc'],
    "scrollX"    : true,
    "columns"    : [
      { "orderable" : false },
      {},
      {},
      {},
      { "orderable" : false }
    ]
  }));
});
