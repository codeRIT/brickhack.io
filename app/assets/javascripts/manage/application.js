//= require_directory ../
//= require dataTables/jquery.dataTables

$(document).ready(function () {
  $('.datatable').DataTable({
    "order"      : [1, 'asc'],
    "pageLength" : 25,
    "processing" : true,
    "serverSide" : true,
    "ajax"       : $('.datatable').data('source'),
    "pagingType" : 'full_numbers',
    "scrollX"    : true
  });
});
