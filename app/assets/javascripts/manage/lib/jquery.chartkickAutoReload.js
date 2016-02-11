$.fn.chartkickAutoReload = function() {
  var reloadData = function() {
    for (i in Chartkick.charts) {
      eval($(Chartkick.charts[i].element).next("script").text());
    }
  };
  setInterval(reloadData, 15000);
};
