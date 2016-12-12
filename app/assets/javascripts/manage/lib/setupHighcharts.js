var setupHighcharts = function() {
  Highcharts.setOptions({
    global: {
      timezoneOffset: 5 * 60,
      useUTC: false
    },
    legend: {
       labelFormatter: function() {
          var total = 0;
          for(var i=this.yData.length; i--;) { total += this.yData[i]; };
          return this.name + ': ' + total;
       }
    },
    chart: {
      backgroundColor: "#f0f0f0"
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
