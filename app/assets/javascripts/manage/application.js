//= require_directory ../
//= require dataTables/jquery.dataTables

$(document).ready(function () {
  $('.datatable').DataTable({
    "order"      : [2, 'asc'],
    "processing" : true,
    "serverSide" : true,
    "ajax"       : $('.datatable').data('source'),
    "pagingType" : 'full_numbers',
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
      {}
    ]
  });
});
