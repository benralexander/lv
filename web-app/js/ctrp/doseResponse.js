(function () {

    d3.doseResponse = function () {
        var _chart = {};

        var _width = 600, _height = 300, // <-1B
            _margins = {top: 30, left: 40, right: 30, bottom: 40},
            _x, _y,
            _data = [],
            _colors = d3.scale.category10(),
            _svg,
            _bodyG,
            _line,
            _displayGridLines,
            _xAxisLabel='',
            _yAxisLabel='';

        _chart.render = function () { // <-2A
            if (!_svg) {
                _svg = d3.select("body").append("svg") // <-2B
                    .attr("height", _height)
                    .attr("width", _width);

                renderAxes(_svg,_displayGridLines);

                defineBodyClip(_svg);
            }

            renderBody(_svg);
        };

        function renderAxes(svg,displayGridLines) {
            var axesG = svg.append("g")
                .attr("class", "axes");

            renderXAxis(axesG,displayGridLines);

            renderYAxis(axesG,displayGridLines);
        }

        function renderXAxis(axesG,displayGridLines) {
            var xAxis = d3.svg.axis()
                .scale(_x.range([0, quadrantWidth()]))
                .orient("bottom");

            var xAxisTextGoesHere = axesG.append("g")
                .attr("class", "x axis")
                .attr("transform", function () {
                    return "translate(" + xStart() + "," + yStart() + ")";
                })
                .call(xAxis);

            if ((_xAxisLabel) &&
                (_xAxisLabel) )  {
                xAxisTextGoesHere
                    .append("text")
                    .attr("class", "label")
                    .attr("x", _width/2)
                    .attr("y", _margins.bottom)
                    .style("text-anchor", "middle")
                    .style("font-weight", "bold")
                    .text(_xAxisLabel);
            }

            if (displayGridLines){
                d3.selectAll("g.x g.tick")
                    .append("line")
                    .classed("grid-line", true)
                    .attr("x1", 0)
                    .attr("y1", 0)
                    .attr("x2", 0)
                    .attr("y2", -quadrantHeight());
            }
        }

        function renderYAxis(axesG,displayGridLines) {
            var yAxis = d3.svg.axis()
                .scale(_y.range([quadrantHeight(), 0]))
                .orient("left");

            var yAxisTextGoesHere = axesG.append("g")
                .attr("class", "y axis")
                .attr("transform", function () {
                    return "translate(" + xStart() + "," + yEnd() + ")";
                })
                .call(yAxis);

            if ((_yAxisLabel) &&
                (_yAxisLabel) )  {
                yAxisTextGoesHere
                    .append("text")
                    .attr("class", "label")
                    .attr("transform", "rotate(-90)")
                    .attr("y", 0)  // works together with dy
                    .attr("dy", "-3em") // how far from the y-axis should the word appear
                    .attr("x", -_height/2)    // how far up the y-axis
                    .style("text-anchor", "middle")
                    .style("font-weight", "bold")
                    .text(_yAxisLabel);
            }

            if (displayGridLines){
                d3.selectAll("g.y g.tick")
                    .append("line")
                    .classed("grid-line", true)
                    .attr("x1", 0)
                    .attr("y1", 0)
                    .attr("x2", quadrantWidth())
                    .attr("y2", 0);
            }
        }

        function defineBodyClip(svg) { // <-2C
            var padding = 5;

            svg.append("defs")
                .append("clipPath")
                .attr("id", "body-clip")
                .append("rect")
                .attr("x", 0 - padding)
                .attr("y", 0)
                .attr("width", quadrantWidth() + 2 * padding)
                .attr("height", quadrantHeight());
        }

        function renderBody(svg) { // <-2D
            if (!_bodyG)
                _bodyG = svg.append("g")
                    .attr("class", "body")
                    .attr("transform", "translate("
                        + xStart() + ","
                        + yEnd() + ")") // <-2E
                    .attr("clip-path", "url(#body-clip)");

            renderLines();

            renderDots();
        }

        function renderLines() {
            _line = d3.svg.line() //<-4A
                .x(function (d) {
                    return _x(d.x);
                })
                .y(function (d) {
                    return _y(d.y);
                });

            _bodyG.selectAll("path.line")
                .data(_data)
                .enter() //<-4B
                .append("path")
                .style("stroke", function (d, i) {
                    return _colors(i); //<-4C
                })
                .attr("class", "line");

            _bodyG.selectAll("path.line")
                .data(_data)
                .transition() //<-4D
                .attr("d", function (d) {
                    return _line(d.elements);
                });
        }

        function renderDots() {
            _data.forEach(function (list, i) {
                _bodyG.selectAll("circle._" + i) //<-4E
                    .data(list)
                    .enter()
                    .append("circle")
                    .attr("class", "dot _" + i);

                _bodyG.selectAll("circle._" + i)
                    .data(list)
                    .style("stroke", function (d) {
                        return _colors(i); //<-4F
                    })
                    .transition() //<-4G
                    .attr("cx", function (d) {
                        return _x(d.x);
                    })
                    .attr("cy", function (d) {
                        return _y(d.y);
                    })
                    .attr("r", 4.5);
            });
        }

        function xStart() {
            return _margins.left;
        }

        function yStart() {
            return _height - _margins.bottom;
        }

        function xEnd() {
            return _width - _margins.right;
        }

        function yEnd() {
            return _margins.top;
        }

        function quadrantWidth() {
            return _width - _margins.left - _margins.right;
        }

        function quadrantHeight() {
            return _height - _margins.top - _margins.bottom;
        }

        _chart.displayGridLines = function (w) {
            if (!arguments.length) return _displayGridLines;
            _displayGridLines = w;
            return _chart;
        };

        _chart.xAxisLabel = function (w) {
            if (!arguments.length) return _xAxisLabel;
            _xAxisLabel = w;
            return _chart;
        };

        _chart.yAxisLabel = function (w) {
            if (!arguments.length) return _yAxisLabel;
            _yAxisLabel = w;
            return _chart;
        };


        _chart.width = function (w) {
            if (!arguments.length) return _width;
            _width = w;
            return _chart;
        };

        _chart.height = function (h) { // <-1C
            if (!arguments.length) return _height;
            _height = h;
            return _chart;
        };

        _chart.margins = function (m) {
            if (!arguments.length) return _margins;
            _margins = m;
            return _chart;
        };

        _chart.colors = function (c) {
            if (!arguments.length) return _colors;
            _colors = c;
            return _chart;
        };

        _chart.x = function (x) {
            if (!arguments.length) return _x;
            _x = x;
            return _chart;
        };

        _chart.y = function (y) {
            if (!arguments.length) return _y;
            _y = y;
            return _chart;
        };

        _chart.addSeries = function (series) { // <-1D
            _data.push(series);
            return _chart;
        };

        return _chart; // <-1E
    };


})();
