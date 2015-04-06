Chartkick.options = {
  height: "165px",
  colors: ["#4886C2", "#62A0DC", "#7BB9F5", "#95D3FF", "#AEECFF", "#C7FFFF"],
  library: {
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
  }
}
