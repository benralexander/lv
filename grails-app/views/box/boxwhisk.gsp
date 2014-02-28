<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 2/18/14
  Time: 7:43 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>boxwhisk</title>
    <script src="../js/d3.js"></script>
    <script src="../js/d3tooltip.js"></script>
    <link media="all" rel="stylesheet" href="../css/d3.slider.css">

</head>
<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.box {
    font: 10px sans-serif;
}

.box line,
.box rect,
.box circle {
    fill: #fff;
    stroke: #000;
    stroke-width: 1.5px;
}

.box .center {
    stroke-dasharray: 3,3;
}

.box .outlier {
    fill: #f00;
    stroke: #111;
}
.d3-tip {
    line-height: 1;
    font-weight: bold;
    padding: 12px;
    background: rgba(0, 0, 0, 0.8);
    color: #fff;
    border-radius: 2px;
}

    /* Creates a small triangle extender for the tooltip */
.d3-tip:after {
    box-sizing: border-box;
    display: inline;
    font-size: 10px;
    width: 100%;
    line-height: 1;
    color: rgba(0, 0, 0, 0.8);
    content: "\25BC";
    position: absolute;
    text-align: center;
}

    /* Style northward tooltips differently */
.d3-tip.n:after {
    margin: -1px 0 0 0;
    top: 100%;
    left: 0;
}

</style>

<style>

.axis {
    font: 10px sans-serif;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
}

.axis .domain {
    fill: none;
    stroke: #000;
    stroke-opacity: .3;
    stroke-width: 10px;
    stroke-linecap: round;
}

.axis .halo {
    fill: none;
    stroke: #ddd;
    stroke-width: 8px;
    stroke-linecap: round;
}

.slider .handle {
    fill: #fff;
    stroke: #000;
    stroke-opacity: .5;
    stroke-width: 1.25px;
    pointer-events: none;
}

</style>

<body>
<div id='plot'></div>
<div id='slider'></div>
<script src="../js/box.js"></script>
<script>

    var margin = {top: 10, right: 50, bottom: 20, left: 50},
            width = 120 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    var globalMinimum = Infinity,
            globalMaximum = -Infinity;

    var interquartileMultiplier = 1.5;


    var chart = d3.box()
            .selectionIdentifier("#plot")
            .width(width)
            .height(height)
        // this next line determines how big the whiskers are.  Without it the
        // whiskers will expand to cover the entire data range. With it they will
        // shrink to cover a multiple of the interquartile range.  Set the parameter
        // two zero and you'll get a box with no whiskers
            .whiskers(iqr(interquartileMultiplier));



    d3.json("http://localhost:8028/cow/box/retrieveBoxData", function (error, json) {
        var data = [];
        json.forEach(function (x) {
                var e = Math.floor(x.Expt - 1),
                        r = Math.floor(x.Run - 1),
                        s = Math.floor(x.Speed),
                        d = data[e];
                if (!d) d = data[e] = [{value:s,
                    description:'first value of '+s}];
                else d.push({value:s,
                             description:'value of '+s});
                if (s > globalMaximum) globalMaximum = s;
                if (s < globalMinimum) globalMinimum = s;
         });

        chart.assignData (data);

        var g=chart.selection()
                .selectAll("svg")
                .attr("class", "box")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.bottom + margin.top)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")") ;

        chart
                .min(globalMinimum)
                .max(globalMaximum)
                .render(g);


        var sliderWidth = 500;
        var x = d3.scale.linear()
                .domain([0, 2])
                .range([0, sliderWidth])
                .clamp(true);

        var brush = d3.svg.brush()
                .x(x)
                .extent([sliderWidth, sliderWidth])
                .on("brush", brushed);

        var svg = d3.select("#slider").append("svg")
                .attr("width", margin.width)
                .attr("height", margin.height)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
        svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height / 2 + ")")
                .call(d3.svg.axis()
                        .scale(x)
                        .orient("bottom")
                        .tickFormat(function(d) { return d + "°"; })
                        .tickSize(0)
                        .tickPadding(12))
                .select(".domain")
                .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
                .attr("class", "halo");

        var slider = svg.append("g")
                .attr("class", "slider")
                .call(brush);

        slider.selectAll(".extent,.resize")
                .remove();

        slider.select(".background")
                .attr("height", height);

        var handle = slider.append("circle")
                .attr("class", "handle")
                .attr("transform", "translate(0," + height / 2 + ")")
                .attr("r", 9);

        slider
                .call(brush.event);
//                .transition() // gratuitous intro!
//                .duration(750)
//                .call(brush.extent([70, 70]))
//                .call(brush.event);

        function brushed() {
            var value = brush.extent()[0];

            if (d3.event.sourceEvent) { // not a programmatic event
                value = x.invert(d3.mouse(this)[0]);
 //               console.log('value ='+value +', this[0] ='+this[0] +'.') ;
                brush.extent([value, value]);
            }
            handle.attr("cx", x(value));
            if (!isNaN(value)){
                interquartileMultiplier = value;
                chart.whiskers(iqr(interquartileMultiplier)).render(g);
            }
        }

    });


    // Returns a function to compute the interquartile range.
    function iqr(k) {
        return function(d, i) {
            var q1 = d.quartiles[0],
                    q3 = d.quartiles[2],
                    iqr = (q3 - q1) * k,
                    i = -1,
                    j = d.length;
            while ((d[++i].value) < q1 - iqr);
            while ((d[--j].value) > q3 + iqr);
            return [i, j];
        };
    }




</script>
</body>
</html>