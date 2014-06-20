var cbbo = cbbo || {};

(function () {
    "use strict";

    cbbo.scatterPlot = function () {

        // the variables we intend to surface
        var
            width = 1,
            height = 1,
            margin = {},
            selectionIdentifier = '',
            data = {},
            xAxisLabel = '',
            yAxisLabel = '',
            clickCallback = function (d, i) {
            },
            xAxisDataAccessor,
            yAxisDataAccessor,
            colorByDataAccessor,



        // private variables
            instance = {},
            selection = {},
            x,
            y,
            color,
            xAxis,
            yAxis,
            svg,

        //  private variable
            tip = d3.tip()
                .attr('class', 'd3-tip scatter-tip')
                .style('z-index', 51)
                .offset([-10, 0])
                .html(function (d) {
                    var textToPresent = "";
                    if (d) {
                        if (d.cellName) {
                            textToPresent = "CCLE: " + d.cellName.toString();
                        }
                        else {
                            textToPresent = "CCLE: " + d.toString();
                        }
                    }
                    return "<strong><span>" + textToPresent + "</span></strong> ";
                });


        // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            return instance;
        };


        // Now walk through the DOM and create the enrichment plot
        instance.render = function (g) {
            var previouslyExistingScatterPlot = selection.selectAll("svg"),
                legend;

            x = d3.scale.linear()
                .range([0, width]);

            y = d3.scale.linear()
                .range([height, 0]);

            color = d3.scale.category10();

            xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");

            if (previouslyExistingScatterPlot) {
                previouslyExistingScatterPlot.remove();
            }

            if (!svg) {
                svg = selection
                    .append("svg")
                    .attr("width", width + margin.left + margin.right)
                    .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                    .attr("class", "scatter")
                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
                    .call(tip);
            }

            x.domain(d3.extent(data, function (d) {
                return d.cpdAUC;
            })).nice();
            y.domain(d3.extent(data, function (d) {
                return d.geneFeatureValue;
            })).nice();

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis)
                .append("text")
                .attr("class", "label")
                .attr("x", width / 2)
                .attr("y", 40)
                .style("text-anchor", "middle")
                .style("font-weight", "bold")
                .text(xAxisLabel);

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("class", "label")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", "-3em")
                .attr("x", -height / 2)
                .style("text-anchor", "middle")
                .style("font-weight", "bold")
                .text(yAxisLabel);

            svg.selectAll(".dot")
                .data(data)
                .enter()
                .append("circle")
                .on('mouseover', tip.show)
                .on('mouseout', tip.hide)
                .on('click', clickCallback)

                .attr("class", "dot")
                .attr("r", 3.5)
                .attr("cx", function (d) {
                    return x(xAxisDataAccessor(d));
                })
                .attr("cy", function (d) {
                    return y(yAxisDataAccessor(d));
                })
                .style("fill", function (d) {
                    return color(colorByDataAccessor(d));
                });

            legend = svg.selectAll(".legend")
                .data(color.domain())
                .enter().append("g")
                .attr("class", "legend")
                .attr("transform", function (d, i) {
                    return "translate(0," + ((i * 20) - margin.top) + ")";
                });

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
                .text(function (d) {
                    return d;
                });

        };

        instance.width = function (x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function (x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };


        instance.xAxisLabel = function (x) {
            if (!arguments.length) return xAxisLabel;
            xAxisLabel = x;
            return instance;
        };

        instance.yAxisLabel = function (x) {
            if (!arguments.length) return yAxisLabel;
            yAxisLabel = x;
            return instance;
        };

        instance.margin = function (x) {
            if (!arguments.length) return margin;
            margin = x;
            return instance;
        };

        instance.clickCallback = function (x) {
            if (!arguments.length) return clickCallback;
            clickCallback = x;
            return instance;
        };

        instance.xAxisDataAccessor = function (x) {
            if (!arguments.length) return xAxisDataAccessor;
            xAxisDataAccessor = x;
            return instance;
        };

        instance.yAxisDataAccessor = function (x) {
            if (!arguments.length) return yAxisDataAccessor;
            yAxisDataAccessor = x;
            return instance;
        };

        instance.colorByDataAccessor = function (x) {
            if (!arguments.length) return colorByDataAccessor;
            colorByDataAccessor = x;
            return instance;
        };

        instance.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };

        return instance;
    };

})();