var cbbo = cbbo || {};


(function () {
    "use strict";

    cbbo.barChart = function module() {

        var chart = {},
            margin = {top: 20, right: 20, bottom: 40, left: 40},
            width = 500,
            height = 500,
            gap = 20,
            ease = "bounce",
            chartClass = "chart";

        chart.render = function (selection) {
            selection.each(function (data) {

                var chartW = width - margin.left - margin.right,
                    chartH = height - margin.top - margin.bottom,

                    x1 = d3.scale.linear()
                        .domain([0, d3.max(data, function (d, i) {
                            return d;
                        })])
                        .range([0, chartW]),

                    y1 = d3.scale.linear()
                        .domain([0, 300])
                        .range([chartH, 0]),

                    xAxis = d3.svg.axis()
                        .scale(x1)
                        .orient("bottom"),

                    yAxis = d3.svg.axis()
                        .scale(y1)
                        .orient("left"),


                    svg = d3.select(this)
                        .selectAll("svg")
                        .data([data]),

                    container = svg.enter().append("svg")
                        .classed(chartClass, true)
                        .append("g").classed("container-group", true)
                        .append("g").classed("chart-group", true),
                    barH = 50,

                    bars = svg.select(".chart-group")
                        .selectAll(".bar")
                        .data(data);

//                bars.enter().append("rect")
//                    .classed("bar", true)
//                    .attr({x: chartW,
//                        width: barW,
//                        y: function (d, i) {
//                            return y1(d);
//                        },
//                        height: function (d, i) {
//                            return chartH - y1(d);
//                        }
//                    });
//                bars.transition()
//                    .ease(ease)
//                    .attr({
//                        width: barW,
//                        x: function (d, i) {
//                            return x1(i) + gapSize / 2;
//                        },
//                        y: function (d, i) {
//                            return y1(d);
//                        },
//                        height: function (d, i) {
//                            return chartH - y1(d);
//                        }
//                    });
//                bars.exit().transition().style({opacity: 0}).remove();
                bars.enter().append("rect")
                    .classed("bar", true)
                    .attr({x: margin.left,
                        width: 0,
                        y: function (d, i) {
                            return (barH+gap)*i;
                        },
                        height: function (d, i) {
                            return barH;
                        }
                    });
                bars.transition()
                    .ease(ease)
                    .attr({x: margin.left,
                        width:function (d, i) {
                            return x1(d);
                        },
                        y: function (d, i) {
                            return (barH+gap)*i;
                        },
                        height: function (d, i) {
                            return barH;
                        }
                    });
                bars.exit().transition().style({opacity: 0}).remove();

            });
            return chart.render;
        };
        chart.width = function (x) {
            if (!arguments.length) {return width;}
            width = parseInt(x,10);
            return this;
        };
        chart.height = function (x) {
            if (!arguments.length) {return height;}
            height = parseInt(x,10);
            return this;
        };
        chart.gap = function (x) {
            if (!arguments.length) {return gap;}
            gap = x;
            return this;
        };
        chart.ease = function (x) {
            if (!arguments.length) {return ease;}
            ease = x;
            return this;
        };

        return chart;
    };


})();
