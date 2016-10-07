$.fn.initMap = function() {
  if (!this || this.length == 0) {
    return;
  }

  var width = 950,
  height = 600;

  var appsById = d3.map();

  var formatNumber = d3.format(",.0f");

  var path = d3.geo.path()
      .projection(null);

  var radius = d3.scale.sqrt()
      .domain([0, 50])
      .range([0, 1]);

  var svg = d3.select(this[0]).append("svg:svg")
      .attr("width", width)
      .attr("height", height);

  queue()
      .defer(d3.json, "/us.json")
      .defer(d3.tsv, "/manage/dashboard/map_data.tsv", function(d) { appsById.set(d.id, +d.apps); })
      .await(ready);

  function ready(error, us) {
    if (error) return console.error(error);

    svg.append("path")
        .datum(topojson.feature(us, us.objects.nation))
        .attr("class", "land")
        .attr("d", path);

    svg.append("path")
        .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
        .attr("class", "border border--state")
        .attr("d", path);

    svg.append("g")
        .attr("class", "county")
      .selectAll("path")
        .data(topojson.feature(us, us.objects.counties).features
          .sort(function(a, b) { return (appsById.get(b.id) || 0) - (appsById.get(a.id) || 0); }))
      .enter().append("path")
        .attr("d", path)
        .attr("fill-opacity", function(d) { return radius(appsById.get(d.id) || 0); })
      .append("title")
        .text(function(d) {
          return d.properties.name
              + "\nApplications: " + formatNumber(appsById.get(d.id) || 0);
        });
  };

  d3.select(self.frameElement).style("height", height + "px");
};
