var setupHighcharts = function() {
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
};
