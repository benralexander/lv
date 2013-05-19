<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 5/18/13
  Time: 6:19 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<meta charset="utf-8">
<style>
body { font: 12px Arial;}
path {
stroke: steelblue;
stroke-width: 3;
fill: none;
}
.axis path,
.axis line {
fill: none;
stroke: grey;
stroke-width: 1;
shape-rendering: crispEdges;
}
</style>
<body>
<script src="../js/d3.js"></script>
<script>
    var margin = {top: 30, right: 20, bottom: 30, left: 50},
            width = 600 - margin.left - margin.right,
            height = 270 - margin.top - margin.bottom;
    var parseDate = d3.time.format("%d-%b-%y").parse;
    var x = d3.time.scale().range([0, width]);
    var y = d3.scale.linear().range([height, 0]);
    var xAxis = d3.svg.axis().scale(x)
            .orient("bottom").ticks(5);
    var yAxis = d3.svg.axis().scale(y)
            .orient("left").ticks(5);
    var valueline = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return y(d.close); });
    var svg = d3.select("body")
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top +
    ")");
    // Get the data
    d3.tsv("http://localhost:8028/cow/graph/feedMeJson", function(error, data) {
        data.forEach(function(d) {
            d.date = parseDate(d.date);
            d.close = +d.close;
        });
// Scale the range of the data
        x.domain(d3.extent(data, function(d) { return d.date; }));
        y.domain([0, d3.max(data, function(d) { return d.close; })]);
        svg.append("path") // Add the valueline path.
                .attr("d", valueline(data));
        svg.append("g") // Add the X Axis
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);
        svg.append("g") // Add the Y Axis
                .attr("class", "y axis")
                .call(yAxis);
    });
</script>
</body>
