//= require_directory ../
//= require_directory .
//= require ../vendor/jquery.dataTables.min
//= require ../vendor/dataTables.buttons.min
//= require ../vendor/buttons.html5.min
//= require ../vendor/pdfmake.min
//= require ../vendor/vfs_fonts
//= require selectize
//= require highcharts
//= require chartkick
//= require_directory ./lib

$(document).ready(function () {
  $('.selectize').selectize();
  $('select[data-bulk-row-edit]').bulkRowEdit();
  $().bulkRowSelect();
  $('body').chartkickAutoReload();
  setupDataTables();
  setupHighcharts();
});
