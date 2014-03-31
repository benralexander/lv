(function () {

    d3.doseResponse = function () {
        var _chart = {};

        var _width = 600, _height = 300,
            _margins = {top: 30, left: 40, right: 30, bottom: 40},
            _x, _y,
            _data = [],
            _colors = d3.scale.category10(),
            _svg,
            _bodyG,
            _line,
            _displayGridLines,
            _xAxisLabel='',
            _yAxisLabel='',
            // private variables
            _expansionPercent  = 10.0, // percent we extend beyond the min max of the raw data
            _pointsDefiningGeneratedLine = 100  // the curve we generate from the four parameters is a series of
        // straight-line segments. This variable describes how many exactly.
            ;

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

            renderAreas();

            renderDots();

            renderErrorBars();
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
                    return _line(d.lines);
                });
        }


        function renderErrorBars(){
            renderErrorBarCenterline ();
     //       renderErrorBarCrossbars ()
        }


        function renderErrorBarCenterline () {

            var crossbarWidth = 0.8;

            // we only need to deal with points that have error bars
            var relevantDataOnly = function(sourceArray,orientation, direction){
                var filtered = [];
                if (orientation === 'vertical') {
                    sourceArray.forEach(function(d){
                        if ((typeof d.dyp !== "undefined") &&
                            (direction === "up")){
                            filtered.push(d);
                        }  else if ((typeof d.dyn !== "undefined") &&
                            (direction === "down")){
                            filtered.push(d);
                        }
                    });
                }  else {
                    sourceArray.forEach(function(d){
                        sourceArray.forEach(function(d){
                            if ((typeof d.dxp !== "undefined") &&
                                (direction === "up")){
                                filtered.push(d);
                            }  else if ((typeof d.dxn !== "undefined") &&
                                (direction === "down")){
                                filtered.push(d);
                            }
                        });
                    });
                };
                return filtered;
            };

            var addSegmentToErrorBar = function (dataset,name, orientation, direction, portion,i){

                var extractOffset = function (d, orientation, direction)  {
                    var offset;
                    if (orientation ==='vertical'){
                        if (direction ==='up')  {
                            offset =  d.dyp;
                        }  else {// direction must be down
                            offset =  (0-d.dyn);
                        }
                    } else {  // orientation must be horizontal
                        if (direction ==='right')  {
                            offset =  d.dxp;
                        }  else {// direction must be left
                            offset =  (0-d.dxn);
                        }
                    }
                   return offset;
                }




                var dataNeedingErrorBars =  _bodyG.selectAll(name + i)
                    .data(relevantDataOnly (dataset,orientation,direction));

                dataNeedingErrorBars
                    .enter()
                    .append("line")
                    .attr("class", orientation + " " + portion + " _" + i);

                dataNeedingErrorBars
                    .classed('errorbar', true)
                    .attr("x1", function (d){
                        if (portion ==='mainline'){
                            return _x(d.x);
                        }  else if (portion ==='crossbar') {
                            return _x(d.x-crossbarWidth);
                        }
                    })
                    .attr("y1", function (d){
                        var offset = extractOffset (d, orientation, direction);
                         if (portion ==='mainline'){
                            return _y(d.y);
                        }  else if (portion ==='crossbar') {
                            return _y(d.y+ offset);
                        }
                    })
                    .attr("x2", function (d){
                            if (portion ==='mainline'){
                                return _x(d.x);
                            }  else if (portion ==='crossbar') {
                                return  _x(d.x+crossbarWidth);
                            }
                        })
                    .attr("y2",  function (d){
                        var offset = extractOffset (d, orientation, direction);
                                if (portion ==='mainline'){
                                    return _y(d.y+offset);
                                }  else if (portion ==='crossbar') {
                                    return _y(d.y+ offset);
                                }
                            })
                    .style("stroke", function (d) {
                        return _colors(i);
                    });

                dataNeedingErrorBars
                    .exit()
                    .remove();

            };




            _data.forEach(function (list, i) {

                addSegmentToErrorBar(list.dots, 'line.errorbar.m',
                    'vertical', 'up', 'mainline',i);
                addSegmentToErrorBar(list.dots, 'line.errorbar.m',
                    'vertical', 'up', 'crossbar',i);
                addSegmentToErrorBar(list.dots, 'line.errorbar.m',
                    'vertical', 'down', 'mainline',i);
                addSegmentToErrorBar(list.dots, 'line.errorbar.m',
                    'vertical', 'down', 'crossbar',i);

//
//                var dataNeedingErrorBars =  _bodyG.selectAll("line.errorbar.m" + i)
//                    .data(relevantDataOnly (list.dots,'vertical','up'));
//
//                dataNeedingErrorBars
//                    .enter()
//                    .append("line")
//                    .attr("class", "vertical mainline _" + i);
//
//                dataNeedingErrorBars
//                    .classed('errorbar', true)
//                    .attr("x1", function (d){return _x(d.x);})
//                    .attr("y1", function (d){return _y(d.y);})
//                    .attr("x2", function (d){return _x(d.x);})
//                    .attr("y2",  function (d){return _y(d.y+ d.dyp);})
//                    .style("stroke", function (d) {
//                        return _colors(i);
//                    });
//
//                dataNeedingErrorBars
//                    .exit()
//                    .remove();
//
//                dataNeedingErrorBars =  _bodyG.selectAll("line.errorbar.c" + i)
//                    .data(relevantDataOnly (list.dots,'vertical','up'));
//
//                dataNeedingErrorBars
//                    .enter()
//                    .append("line")
//                    .attr("class", "vertical crossbar _" + i);
//
//                dataNeedingErrorBars
//                    .classed('errorbar', true)
//                    .attr("x1", function (d){return _x(d.x+1);})
//                    .attr("y1", function (d){return _y(d.y+ d.dyp);})
//                    .attr("x2", function (d){return _x(d.x-1);})
//                    .attr("y2",  function (d){return _y(d.y+ d.dyp);})
//                    .style("stroke", function (d) {
//                        return _colors(i);
//                    });
//
//                dataNeedingErrorBars
//                    .exit()
//                    .remove();




                /*
                            _data.forEach(function (list, i) {
                                _bodyG.selectAll("line.center _" + i) //<-4E
                                    .data(list.dots)
                                    .enter()
                                    .append("line")
                                    .filter( function(d){return typeof d.dyp !== "undefined"} )
                                       .attr("class", "center _" + i);

                                _bodyG.selectAll("line.center _" + i)
                                    .data(list.dots)
                                    .filter( function(d){return typeof d.dyp !== "undefined"} )
                                       .classed('center', true);

                                _bodyG.selectAll("line.center _" + i)
                                    .data(list.dots)
                                    .exit()
                                    .remove();
                 */

//                center.enter().append("line", "rect")
//                .attr("class", "center")
//                .attr("x1", width / 2)
//                .attr("y1", function (d) {
//                    return yScaleOld(d[0]);
//                })
//                .attr("x2", width / 2)
//                .attr("y2", function (d) {
//                    return yScaleOld(d[1]);
//                })
//                .style("opacity", 1e-6)
//                .transition()
//                .duration(duration)
//                .style("opacity", 1)
//                .attr("y1", function (d) {
//                    return yScale(d[0]);
//                })
//                .attr("y2", function (d) {
//                    return yScale(d[1]);
//                });

            });
        }


        function renderErrorBarCrossbars () {
            center.enter().append("line", "rect")
                .attr("class", "center")
                .attr("x1", width / 2)
                .attr("y1", function (d) {
                    return yScaleOld(d[0]);
                })
                .attr("x2", width / 2)
                .attr("y2", function (d) {
                    return yScaleOld(d[1]);
                })
                .style("opacity", 1e-6)
                .transition()
                .duration(duration)
                .style("opacity", 1)
                .attr("y1", function (d) {
                    return yScale(d[0]);
                })
                .attr("y2", function (d) {
                    return yScale(d[1]);
                });

        }





        function renderDots() {
            // go here to draw circles
//            _data.forEach(function (list, i) {
//                _bodyG.selectAll("circle._" + i) //<-4E
//                    .data(list.dots)
//                    .enter()
//                    .append("circle")
//                    .attr("class", "dot _" + i);
//
//                _bodyG.selectAll("circle._" + i)
//                    .data(list.dots)
//                    .style("stroke", function (d) {
//                        return _colors(i); //<-4F
//                    })
//                    .transition() //<-4G
//                    .attr("cx", function (d) {
//                        return _x(d.x);
//                    })
//                    .attr("cy", function (d) {
//                        return _y(d.y);
//                    })
//                    .attr("r", 4.5);
//            });


            // go here to draw shapes
            _data.forEach(function (list, i) {
                _bodyG.selectAll("path._" + i) //<-4E
                    .data(list.dots)
                    .enter()
                    .append("path")
                    .attr("class", "symbol _" + i);

                _bodyG.selectAll("path._" + i)
                    .data(list.dots)
                    .classed('cross', true)
                    .style("stroke", function (d) {
                        return _colors(i);
                    })
                    .style("fill", function (d) {
                        return '#ffffff';
                    })
                    .transition()
                    .attr("transform", function(d){
                        return "translate(" // <-D
                            + _x(d.x)
                            + ","
                            + _y(d.y)
                            + ")";
                    })
                    .attr("d",
                        d3.svg.symbol() // <-E
                            .type('cross')
                    );

//                .attr("cx", function (d) {
//                        return _x(d.x);
//                    })
//                    .attr("cy", function (d) {
//                        return _y(d.y);
//                    })
//                    .attr("r", 4.5);
            });






        }


        function renderAreas() {
            var area = d3.svg.area() // <-A
                .x(function(d) { return _x(d.x); })
                .y0(yStart())
                .y1(function(d) { return _y(d.y); });

            _bodyG.selectAll("path.area")
                .data(_data)
                .enter() // <-B
                .append("path")
                .style("fill", function (d, i) {
                    return _colors(i);
                })
                .attr("class", "area");

            _bodyG.selectAll("path.area")
                .data(_data)
                .transition() // <-D
                .attr("d", function (d) {
                    return area(d.lines); // <-E
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

        /***
         * Add another data set. Each additional data set will contribute both
         * a line (based on the four sigmoid line spec properties) as well as
         * a set of points intended to represent the raw data from which the line
         * is generated. The accumulation of all of these data sets will appear
         * on the same set of axes.
         *
         * Calculate the range of the calculated line based on the minimum/maximum
         * of the x/y points given plus _expansionPercent  on all sides.
         *
         * @param series
         * @returns {{}}
         */
        _chart.addSeries = function (series) {
            var minimumX = d3.min(series.elements, function (d){
                     return d.x;
                }),
                maximumX = d3.max(series.elements, function (d){
                    return d.x;
                }),
                minimumY = d3.min(series.elements, function (d){
                    return d.y;
                }),
                maximumY = d3.max(series.elements, function (d){
                    return d.y;
                }),
            // special restriction.  X values must be nonnegative in order for the EC50 calculation
            // to be valid.  Therefore we can go ahead and increase the range, but we cannot increase
            // to include x-values smaller than zero.
                lowXRange =  Math.max(minimumX-((maximumX- minimumX) * (_expansionPercent/100.0)),0.0),
                highXRange =  maximumX+((maximumX- minimumX) * (_expansionPercent/100.0)),
                lowYRange =  minimumY-((maximumY- minimumY) * (_expansionPercent/100.0)),
                highYRange =  maximumY+((maximumY- minimumY) * (_expansionPercent/100.0)),
                generatedLine = _chart.generateSigmoidPoints ( series.yMinimum,
                                                               series.yMaximum,
                                                               series.hillslope,
                                                               series.inflection,
                                                               _pointsDefiningGeneratedLine,
                                                               lowXRange,
                                                               highXRange );
                dataHolder = { lines: generatedLine,
                               elements: series.elements,
                               dots: series.elements};
            _data.push(dataHolder);
            return _chart;
        };

        _chart.generateSigmoidPoints = function (yMin,yMax,hillSlope,Ec50,
                                                 numberOfPoints,xStart,xEnd) {
            var xVector = [];
            var returnValue = [];
            // first create the X factor
            for ( var  i=0 ; i<(numberOfPoints-1) ; i++ ){
                xVector.push(xStart + ((((numberOfPoints-1)-i)/(numberOfPoints-1))*(xEnd-xStart)));
            }
            xVector = xVector.reverse();
            // now apply x vector to the sigmoid function
            for ( var  i=0 ; i<xVector.length ; i++) {
                // sanity check.  We cannot derive a line if the X values are less than zero
                // ( strictly speaking X values less than zero are only illegal if raised to
                //  a fractional power but we're splitting hairs -- if the concentration values
                //  are less than zero and clearly something is wrong ).  Therefore every time
                //  we will avoid generating any numbers for any points unless the X values are
                // nonnegative.
                if (xVector[i] >= 0) {
                    returnValue.push({x:xVector[i],
                                      y:(yMin + (yMax - yMin)/(1 +Math.pow((xVector[i]/Ec50), (0-hillSlope))))});
                }
            }
            return returnValue;
        }

        return _chart; // <-1E
    };


})();
