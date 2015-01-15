//= require_directory ../
//= require dataTables/jquery.dataTables

$(document).ready(function () {
  $('.datatable').DataTable({
    "order": [1, 'asc'],
    "pageLength": 25
  });
});
