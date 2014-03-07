<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Array as Data</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>
<style>

body {
    font: 10px sans-serif;
}

.axis path,
.axis line {
    fill: none;
    stroke: #000;
    stroke-width: 1.2px;
    shape-rendering: crispEdges;
}
.axis text {
    font-size: 12pt;
}
.axis label {
    font-size: 14pt;
}


.dot {
    stroke: #000;
}

</style>
<body>
%{--<link media="all" rel="stylesheet" href="../css/ctrp/scatter.css">--}%
<script src="../js/d3.js"></script>
<script src="../js/ctrp/scatter.js"></script>
<script src="../js/ctrp/d3tooltip.js"></script>
<div id="scatterPlot"></div>
<script>

    var margin = {top: 20, right: 20, bottom: 30, left: 40},
            width = 960 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    var x = d3.scale.linear()
            .range([0, width]);

    var y = d3.scale.linear()
            .range([height, 0]);

    var color = d3.scale.category10();

    var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom");

    var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left");

    var svg = d3.select("body").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    data = [
        {yValue:5.1,
            xValue:3.5,
            lineage:'colon'
        },
        {yValue:4.9,
            xValue:3.0,
            lineage:'colon'
        },
        {yValue:4.7,
            xValue:3.2,
            lineage:'lung'
        },
        {yValue:4.4,
            xValue:3.7,
            lineage:'lung'
        },
        {yValue:5.0,
            xValue:3.6,
            lineage:'endometrium'
        },
        {yValue:4.5,
            xValue:3.8,
            lineage:'endometrium'
        },
        {yValue:4.4,
            xValue:3.1,
            lineage:'endometrium'
        },
        {yValue:4.9,
            xValue:3.3,
            lineage:'endometrium'
        }
    ];


    d3.scatter()
            .selectionIdentifier("#scatterPlot")
            .width (width)
            .height (height)
            .assignData (data)
            .render() ;
//
//
//        x.domain(d3.extent(data, function(d) { return d.xValue; })).nice();
//        y.domain(d3.extent(data, function(d) { return d.yValue; })).nice();
//
//        svg.append("g")
//                .attr("class", "x axis")
//                .attr("transform", "translate(0," + height + ")")
//                .call(xAxis)
//                .append("text")
//                .attr("class", "label")
//                .attr("x", width)
//                .attr("y", -6)
//                .style("text-anchor", "end")
//                .text("Navitoclax AUC");
//
//        svg.append("g")
//                .attr("class", "y axis")
//                .call(yAxis)
//                .append("text")
//                .attr("class", "label")
//                .attr("transform", "rotate(-90)")
//                .attr("y", 6)
//                .attr("dy", ".71em")
//                .style("text-anchor", "end")
//                .text("BCL2 expression level")
//
//        svg.selectAll(".dot")
//                .data(data)
//                .enter().append("circle")
//                .attr("class", "dot")
//                .attr("r", 3.5)
//                .attr("cx", function(d) { return x(d.xValue); })
//                .attr("cy", function(d) { return y(d.yValue); })
//                .style("fill", function(d) { return color(d.lineage); });
//
//        var legend = svg.selectAll(".legend")
//                .data(color.domain())
//                .enter().append("g")
//                .attr("class", "legend")
//                .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });
//
//        legend.append("rect")
//                .attr("x", width - 18)
//                .attr("width", 18)
//                .attr("height", 18)
//                .style("fill", color);
//
//        legend.append("text")
//                .attr("x", width - 24)
//                .attr("y", 9)
//                .attr("dy", ".35em")
//                .style("text-anchor", "end")
//                .text(function(d) { return d; });



</script>

</body>
</html>