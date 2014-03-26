(function () {

    var firstInstance = true;


// Inspired by http://informationandvisualization.de/blog/box-plot
    d3.boxWhiskerPlot = function () {
        var instance = {},
            width = 1,
            height = 1,
            selectionIdentifier = '',
            duration = 500,
            domain = null,
            min = Infinity,
            max = -Infinity,
            whiskers = boxWhiskers,
            quartiles = boxQuartiles,
            xAxis = {},
            yAxis = {},
            boxWhiskerName = '',
            outlierRadius = 7,
            compoundIdentifier = '',
            scatterDataCallback = {},

        // these sizes referred to each individual bar in the bar whisker plot
            margin = {top: 50, right: 50, bottom: 20, left: 50},
            width = 420 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom,

        // the variables that will never be exposed
            value = Number,
            tickFormat = null,
            selection = {};


        /***
         *  This module adds a handler for clicks on the outlier elements in the
         *  box whisker plot, and then retrieves the data necessary to insert
         *  a scatter plot into a common div.  We use prototype definition tricks
         *  JQuery here, so make sure those libraries are available.
         */
        var clickHandling = (function () {

            function deselect() {
                $(".pop").slideFadeToggle(function () {
                    $("#examineCorrelation").removeClass("selected");
                });
            }

            $("#examineCorrelation").focusout( function(event){
                    console.log('focusout1');
                }

            );
            $(document.body).on('focusout','#examineCorrelation', function () {
                    console.log('focusout2');
                }

            );

            $(function () {
                if (firstInstance) {
                    firstInstance = false;
                        $(document.body).on('click','a.clickable', function () {
                    if ($(this).hasClass("selected")) {
                        deselect();
                    } else {
                        $(this).addClass("selected");
                       var genePrimaryName = $(this).attr('gpn');
                        $(".pop").slideFadeToggle(function () {
                                retrieveCorrelationData(compoundIdentifier,
                                    genePrimaryName);
                                $("#examineCorrelation").focus();
                            }
                        );
                    }
                    return false;
                });
                }

                $(document.body).on('click','.close', function () {
                    deselect();
                    return false;
                });
            });

            $.fn.slideFadeToggle = function (easing, callback) {
                return this.animate({ opacity: 'toggle', height: 'toggle' }, "fast", easing, callback);
            };

            var retrieveCorrelationData = function (compoundId, geneName) {
                var regObj = new Object();
                regObj.cpd_id = compoundId;
                regObj.gene_primary_name = geneName;


                var res = $.ajax({
                    url: './correlationPoints',
                    type: 'post',
                    context: document.body,
                    data: JSON.stringify(regObj),
                    contentType: 'application/json',
                    async: true,
                    success: function (data) {
                        var obj = (JSON.parse(data));
                        scatterDataCallback(obj.results);
                    },
                    error: function () {
                        alert('Contact message failed');
                    }
                });
            };
            return {
                // public variables

                // public methods
            }

        }());


        /***
         *  jitter module provides an offset so that points that would be near
         *  to one another along the y-axis are offset in the x-axis to keep
         *  points from overlaying one another
         *
         *  Assumption: this method requires the data to be monotonic in descending order
         */
        var jitter = (function () {
           var lastX = null,
               lastY = null,
               centralXPosition = null,
               lastAxialPoint = null,
               radiusOfPoint =  outlierRadius,
               shiftLeftNext = true,
               currentX = 0,

               determinePositioning = function(xValue,yValue){
                   if ((lastX === null) && (lastY === null)) {  // this is our first time through
                       lastX =  0;
                       centralXPosition =  xValue;
                       lastAxialPoint =  yValue;
                       lastY = yValue;
                       shiftLeftNext = true;
                   }
                   else {  // this is not our first time
                       if (yValue > (lastAxialPoint-(2*radiusOfPoint)))  { // potential overlap. Shift it.
                           if (shiftLeftNext){    // let's shift to the left.  expand on left shifts only
                               if (lastX<0){
                                   lastX = (0 - lastX);
                               }
                               lastX +=  (2*radiusOfPoint);
                               shiftLeftNext = false;
                           } else {  // we are shifting to the right. Change sign.
                               lastX = (0 - lastX);
                               shiftLeftNext = true;
                           }
                       } else { // no overlap possible. Return to center
                           lastX =  0;
                           lastAxialPoint =  yValue;
                           shiftLeftNext = true;
                       }
                       lastY = yValue;
                   }
                   currentX =  (centralXPosition+lastX);
               },
               shiftedX  = function(xValue,yValue){
                   if (yValue>lastY) {
                       initialize();
                   }
                   determinePositioning(xValue,yValue);
                   return currentX;
               },
               shiftedY  = function(xValue,yValue){
                   if (yValue>lastY) {
                       initialize();
                   }
                   determinePositioning(xValue,yValue);
                   return lastY;
               },
               initialize = function (){
                   lastX = null;
                   lastY = null;
               }

               return {
                   // public variables

                   // public methods
                   currentX :  shiftedX,
                   currentY :  shiftedY,
                   initialize: initialize
               }

        }());

        //  private variable
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function (d) {
                var nodeData = d3.select(this.parentNode).datum()[d];
                return "<strong></strong> <span style='color:#00ff00'>Gene: " + nodeData.description + "<br/>"+
                    "Correlation: " +  nodeData.value+ "</span>";
            });


        // For each small multiple…
        instance.render = function () {

            selection
                .select("svg").select("g.boxHolder")
                .each(function (d, i) {
                    d = d.sort(function (a, b) {
                        return a.value - b.value;
                    });
                    var g = d3.select(this),
                        n = d.length;

                    // Compute quartiles. Must return exactly 3 elements.
                    var quartileData = d.quartiles = quartiles(d);

                    // Compute whiskers. Must return exactly 2 elements, or null.
                    var whiskerIndices = whiskers && whiskers.call(this, d, i),
                        whiskerData = whiskerIndices && whiskerIndices.map(function (i) {
                            return d[i].value;
                        });

                    // Compute outliers. If no whiskers are specified, all data are "outliers".
                    // We compute the outliers as indices, so that we can join across transitions!
                    var outlierIndices = whiskerIndices
                        ? d3.range(0, whiskerIndices[0]).concat(d3.range(whiskerIndices[1] + 1, n))
                        : d3.range(n);

                    // Compute the new x-scale.
                    var xScale = d3.scale.linear()
                        .domain([0, 1])
                        .range([width+margin.right+margin.left, 0]);



                    // Compute the new y-scale.
                    var yScale = d3.scale.linear()
                        .domain([min-((max-min)*0.05), max+((max-min)*0.05)])
                        .range([height ,0]);

                    // Right now we are only using one scale so that yScale is equivalent to  yScaleOld, but let's retain
                    var yScaleOld = this.__chart__ || d3.scale.linear()
                        .domain([min-((max-min)*0.05), max+((max-min)*0.05)])
                        .range([height/* + margin.bottom + margin.top*/,0]);


                    // Stash the new scale.
                    this.__chart__ = yScale;


                    xAxis = d3.svg.axis()
                        .scale(xScale)
                        .orient("bottom");

                    yAxis = d3.svg.axis()
                        .scale(yScale)
                        .orient("left");


                    // Note: the box, median, and box tick elements are fixed in number,
                    // so we only have to handle enter and update. In contrast, the outliers
                    // and other elements are variable, so we need to exit them! Variable
                    // elements also fade in and out.

                    // Update center line: the vertical line spanning the whiskers.
                    var center = g.selectAll("line.center")
                        .data(whiskerData ? [whiskerData] : []);

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

                    center.transition()
                        .duration(duration)
                        .style("opacity", 1)
                        .attr("y1", function (d) {
                            return yScale(d[0]);
                        })
                        .attr("y2", function (d) {
                            return yScale(d[1]);
                        });

                    center.exit().transition()
                        .duration(duration)
                        .style("opacity", 1e-6)
                        .attr("y1", function (d) {
                            return yScale(d[0]);
                        })
                        .attr("y2", function (d) {
                            return yScale(d[1]);
                        })
                        .remove();

                    // Update innerquartile box.
                    var box = g.selectAll("rect.box")
                        .data([quartileData]);

                    box.enter().append("rect")
                        .attr("class", "box")
                        .attr("x", 0)
                        .attr("y", function (d) {
                            return yScaleOld(d[2]);
                        })
                        .attr("width", width)
                        .attr("height", function (d) {
                            return yScaleOld(d[0]) - yScaleOld(d[2]);
                        })
                        .transition()
                        .duration(duration)
                        .attr("y", function (d) {
                            return yScale(d[2]);
                        })
                        .attr("height", function (d) {
                            return yScale(d[0]) - yScale(d[2]);
                        });

                    box.transition()
                        .duration(duration)
                        .attr("y", function (d) {
                            return yScale(d[2]);
                        })
                        .attr("height", function (d) {
                            return yScale(d[0]) - yScale(d[2]);
                        });

                    box.exit().remove();

                    // Update median line.
                    var medianLine = g.selectAll("line.median")
                        .data([quartileData[1]]);

                    medianLine.enter().append("line")
                        .attr("class", "median")
                        .attr("x1", 0)
                        .attr("y1", yScaleOld)
                        .attr("x2", width)
                        .attr("y2", yScaleOld)
                        .transition()
                        .duration(duration)
                        .attr("y1", yScale)
                        .attr("y2", yScale);

                    medianLine.transition()
                        .duration(duration)
                        .attr("y1", yScale)
                        .attr("y2", yScale);

                    medianLine.exit().remove();

                    // Update whiskers. These are the lines outside
                    //  of the boxes, but not including text or outliers.
                    var whisker = g.selectAll("line.whisker")
                        .data(whiskerData || []);

                    whisker.enter().append("line", "circle, text")
                        .attr("class", "whisker")
                        .attr("x1", 0)
                        .attr("y1", yScaleOld)
                        .attr("x2", width)
                        .attr("y2", yScaleOld)
                        .style("opacity", 1e-6)
                        .transition()
                        .duration(duration)
                        .attr("y1", yScale)
                        .attr("y2", yScale)
                        .style("opacity", 1);

                    whisker.transition()
                        .duration(duration)
                        .attr("y1", yScale)
                        .attr("y2", yScale)
                        .style("opacity", 1);

                    whisker.exit().transition()
                        .duration(duration)
                        .attr("y1", yScale)
                        .attr("y2", yScale)
                        .style("opacity", 1e-6)
                        .remove();

                    // Update outliers.  These are the circles that Mark data outside of the whiskers.
                    var outlier = g.selectAll("circle.outlier")
                        .data(outlierIndices||[], Number);


                    outlier.enter()
                        .append("a")
                        .attr("class", "clickable")
                        .attr("gpn", function (i) {
                            return d[i].description;
                        } )
//                        .attr("xlink:href", "/examineCorrelation")
                        .on('mouseover', tip.show)
                        .on('mouseout', tip.hide)
                        .append("circle", "text")
                        .attr("class", "outlier")
                        .attr("r", outlierRadius)
                        .attr("cx", function (i) {
                            var xx= jitter.currentX(width/2,yScaleOld(d[i].value));
                            return xx;
                        })
                        .attr("cy", function (i) {
                            var yy = jitter.currentY(width/2,yScaleOld(d[i].value));
                            return yy;
                        })
                        .style("opacity", 1e-6)
                        .transition()
                        .duration(duration)
                        .attr("cx", function (i) {
                             return jitter.currentX(width/2,yScaleOld(d[i].value));
                        })
                        .attr("cy", function (i) {
                            return jitter.currentY(width/2,yScaleOld(d[i].value));
                        })
                        .style("opacity", 1)
                    ;

                    outlier.transition()
                        .duration(duration)
                        .attr("cx", function (i) {
                            return jitter.currentX(width/2,yScaleOld(d[i].value));
                        })
                        .attr("cy", function (i) {
                            return jitter.currentY(width/2,yScaleOld(d[i].value));
                        })
                        .style("opacity", 1);

                    outlier.exit()
                        .transition()
                        .duration(duration)
                        .attr("cx", function (i) {
                            return jitter.currentX(width/2,yScaleOld(d[i].value));
                        })
                        .attr("cy", function (i) {
                            return jitter.currentY(width/2,yScaleOld(d[i].value));
                        })
                        .style("opacity", 1e-6)
                        .remove();

                    // Compute the tick format.
                    var format = tickFormat || yScale.tickFormat(8);

                    // Update box ticks. These are the numbers on the
                    //     sides of the box
                    var boxTick = g.selectAll("text.box")
                        .data(quartileData);

                    boxTick.enter().append("text")
                        .attr("class", "box")
                        .attr("dy", ".3em")
                        .attr("dx", function (d, i) {
                            return i & 1 ? 6 : -6
                        })
                        .attr("x", function (d, i) {
                            return i & 1 ? width : 0
                        })
                        .attr("y", yScaleOld)
                        .attr("text-anchor", function (d, i) {
                            return i & 1 ? "start" : "end";
                        })
                        .text(format)
                        .transition()
                        .duration(duration)
                        .attr("y", yScale);

                    boxTick.transition()
                        .duration(duration)
                        .text(format)
                        .attr("y", yScale);

                    // Update whisker ticks. These are the numbers on the side of the whiskers.
                    //
                    // These are handled separately from the box
                    // ticks because they may or may not exist, and we want don't want
                    // to join box ticks pre-transition with whisker ticks post-.
                    var whiskerTick = g.selectAll("text.whisker")
                        .data(whiskerData || []);

                    whiskerTick.enter().append("text")
                        .attr("class", "whisker")
                        .attr("dy", ".3em")
                        .attr("dx", 6)
                        .attr("x", width)
                        .attr("y", yScaleOld)
                        .text(format)
                        .style("opacity", 1e-6)
                        .transition()
                        .duration(duration)
                        .attr("y", yScale)
                        .style("opacity", 1);

                    whiskerTick.transition()
                        .duration(duration)
                        .text(format)
                        .attr("y", yScale)
                        .style("opacity", 1);

                    whiskerTick.exit().transition()
                        .duration(duration)
                        .attr("y", yScale)
                        .style("opacity", 1e-6)
                        .remove();

                    // y axis
                    selection
                        .select("svg").selectAll("g.y").data([1]).enter()
                        .append("g")
                        .attr("class", "y axis")
                        .attr("transform", "translate(10,0)")
                        .call(yAxis)
                        .append("text")
                        .attr("class", "label")
                        .attr("x",  0 )
                        .attr("y", height/2  + margin.top + margin.bottom )
                        .style("text-anchor", "middle")
                        .style("font-weight", "bold")
                        .text('');

                    // x axis
                    selection
                        .select("svg").selectAll("g.x").data([1]).enter()
                        .append("g")
                        .attr("class", "x axis")
                        .attr("transform", "translate(0," + (height) +")")
                        .call(xAxis)
                        .append("text")
                        .attr("class", "label")
                        .attr("x", (width + margin.left + margin.right)/2 )
                        .attr("y",margin.bottom )
                        .style("text-anchor", "middle")
                        .style("font-weight", "bold")
                        .text(boxWhiskerName);




                });
            d3.timer.flush();
        }

        // Note:  this method will assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            selection
                .selectAll("svg")
                .data(data)
                .enter()
                .append("svg")
                .attr("class", "box")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.bottom + margin.top)
                .append("g")
                .attr("class", "boxHolder")
                .attr("transform", "translate(" + margin.left + ",0)")
                .call(tip);

            return instance;
        };

        instance.width = function (x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };


        instance.min = function (x) {
            if (!arguments.length) return min;
            min = x;
            return instance;
        };

        instance.max = function (x) {
            if (!arguments.length) return max;
            max = x;
            return instance;
        };


        instance.domain = function (x) {
            if (!arguments.length) return instance;
            domain = x == null ? x : d3.functor(x);
            return instance;
        };

        instance.height = function (x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        instance.tickFormat = function (x) {
            if (!arguments.length) return tickFormat;
            tickFormat = x;
            return instance;
        };

        instance.value = function (x) {
            if (!arguments.length) return value;
            value = x;
            return instance;
        };


        instance.whiskers = function (x) {
            if (!arguments.length) return whiskers;
            whiskers = x;
            return instance;
        };

        instance.quartiles = function (x) {
            if (!arguments.length) return quartiles;
            quartiles = x;
            return instance;
        };

        // identify the dominant element upon which we will hang this graphic
        instance.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };

        instance.boxWhiskerName = function (x) {
            if (!arguments.length) return boxWhiskerName;
            boxWhiskerName = x;
            return instance;
        };


        // Identify the compounds that will be retrieved by the scatter plot ( activated
        // through a click on the outlier points)
        instance.compoundIdentifier = function (x) {
            if (!arguments.length) return compoundIdentifier;
            compoundIdentifier = x;
            return instance;
        };

        // Methods to be activated to create the scatter plot
        instance.scatterDataCallback = function (x) {
            if (!arguments.length) return scatterDataCallback;
            scatterDataCallback = x;
            return instance;
        };



        return instance;
    };

    function boxWhiskers(d) {
        return [0, d.length - 1];
    }

    function boxQuartiles(d) {
        var accumulator = [];
        d.forEach(function (x) {
            accumulator.push(x.value)
        });
        return [
            d3.quantile(accumulator, .25),
            d3.quantile(accumulator, .5),
            d3.quantile(accumulator, .75)
        ];
    }

})();
