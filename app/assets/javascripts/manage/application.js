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

$(document).ready(function () {
  $('.selectize').selectize();
  $('select[data-bulk-row-edit]').bulkRowEdit();
  $().bulkRowSelect();
  $('body').chartkickAutoReload();

  Highcharts.setOptions({
    global: {
      timezoneOffset: 4 * 60
    },
    legend: {
       labelFormatter: function() {
          var total = 0;
          for(var i=this.yData.length; i--;) { total += this.yData[i]; };
          return this.name + ': ' + total;
       }
    },
    chart: {
      backgroundColor: "#f9f6f3"
    },
    tooltip: {
      shared: true
    },
    plotOptions: {
      series: {
        animation: false
      },
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.y}'
        }
      }
    }
  });

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
});

$.fn.bulkRowEdit = function() {

  var applyAction = function() {
    $('[type=submit][data-bulk-row-edit]').prop('disabled', true);

    var ids = [];
    $('input[type=checkbox][data-bulk-row-edit]:checked').each(function() {
      ids[ids.length] = $(this).data('bulk-row-edit');
    });

    var action = $('select[data-bulk-row-edit]').val();

    if (ids.length == 0) {
      alert('No rows are selected to be modified!');
      $('[type=submit][data-bulk-row-edit]').prop('disabled', false);
      return false;
    }

    $.ajax({
      url: $('form[data-bulk-row-edit]').attr('action'),
      type: 'PATCH',
      data: {
        bulk_action: action,
        bulk_ids: ids
      }
    }).done(function() {
      window.questionnairesDataTable.draw(false);
    }).fail(function() {
      alert("Request failed, please refresh the page or try again later.");
    }).always(function() {
      $('[type=submit][data-bulk-row-edit]').prop('disabled', false);
    });

    return true;
  };

  $('[type=submit][data-bulk-row-edit]').on('click', function(e) {
    e.preventDefault();
    return applyAction();
  });

};

$.fn.bulkRowSelect = function() {

  var applyAction = function() {
    var checkState = $('[data-bulk-row-select]').prop('checked');
    $('input[type=checkbox][data-bulk-row-edit]').prop('checked', checkState);
    return true;
  };

  $('[data-bulk-row-select]').on('click', function(e) {
    return applyAction();
  });

};

$.fn.chartkickAutoReload = function() {
  var reloadData = function() {
    for (i in Chartkick.charts) {
      eval($(Chartkick.charts[i].element).next("script").text());
    }
  };
  setInterval(reloadData, 15000);
};
