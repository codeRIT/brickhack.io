//= require_directory ../
//= require_directory .
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require selectize
//= require highcharts
//= require chartkick

$(document).ready(function () {
  $('.selectize').selectize();
  $('select[data-bulk-row-edit]').bulkRowEdit();
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
    "processing" : true,
    "serverSide" : true,
    "ajax"       : {
      "url"   : $('.datatable').data('source'),
      "type"  : "POST"
    },
    "pagingType" : 'full_numbers'
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

$.fn.chartkickAutoReload = function() {
  var reloadData = function() {
    for (i in Chartkick.charts) {
      eval($(Chartkick.charts[i].element).next("script").text());
    }
  };
  setInterval(reloadData, 15000);
};
