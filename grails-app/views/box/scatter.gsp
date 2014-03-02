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
    shape-rendering: crispEdges;
}

.dot {
    stroke: #000;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
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
        {sepalLength:5.1,
            sepalWidth:3.5,
            lineage:'colon'
        },
        {sepalLength:4.9,
            sepalWidth:3.0,
            lineage:'colon'
        },
        {sepalLength:4.7,
            sepalWidth:3.2,
            lineage:'lung'
        },
        {sepalLength:4.4,
            sepalWidth:3.7,
            lineage:'lung'
        },
        {sepalLength:5.0,
            sepalWidth:3.6,
            lineage:'endometrium'
        },
        {sepalLength:4.5,
            sepalWidth:3.8,
            lineage:'endometrium'
        },
        {sepalLength:4.4,
            sepalWidth:3.1,
            lineage:'endometrium'
        },
        {sepalLength:4.9,
            sepalWidth:3.3,
            lineage:'endometrium'
        }
    ]
        data.forEach(function(d) {
            d.sepalLength = +d.sepalLength;
            d.sepalWidth = +d.sepalWidth;
        });

        x.domain(d3.extent(data, function(d) { return d.sepalWidth; })).nice();
        y.domain(d3.extent(data, function(d) { return d.sepalLength; })).nice();

        svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis)
                .append("text")
                .attr("class", "label")
                .attr("x", width)
                .attr("y", -6)
                .style("text-anchor", "end")
                .text("Navitoclax AUC");

        svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("class", "label")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("BCL2 expression level")

        svg.selectAll(".dot")
                .data(data)
                .enter().append("circle")
                .attr("class", "dot")
                .attr("r", 3.5)
                .attr("cx", function(d) { return x(d.sepalWidth); })
                .attr("cy", function(d) { return y(d.sepalLength); })
                .style("fill", function(d) { return color(d.lineage); });

        var legend = svg.selectAll(".legend")
                .data(color.domain())
                .enter().append("g")
                .attr("class", "legend")
                .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

        legend.append("rect")
                .attr("x", width - 18)
                .attr("width", 18)
                .attr("height", 18)
                .style("fill", color);

        legend.append("text")
                .attr("x", width - 24)
                .attr("y", 9)
                .attr("dy", ".35em")
                .style("text-anchor", "end")
                .text(function(d) { return d; });



</script>

</body>
</html>