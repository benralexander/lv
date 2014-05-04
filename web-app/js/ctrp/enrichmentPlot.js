// One dimensional heatmap.
//     original: pgm
//     modified: ba
//     17-03-2014    ba   fix feature map cell width bug

(function() {

    d3.heatmap = function() {

        // the variables we intend to surface
        var
            width = 1,
            height = 1,
            selectionIdentifier = '',
            data={},
            featureName = '',
            compoundName = '',


        // the variables that will never be exposed
            xAxis = {},
            instance={},
            selection = {},
            svg = {},
            heatmap = {},
            featuremap = {},
            formatTooltipNumericValue = d3.format(".3g");



        var firstInstance = true;

        /***
         *  This module adds a handler for clicks on the outlier elements in the
         *  box whisker plot, and then retrieves the data necessary to insert
         *  a scatter plot into a common div.  We use prototype definition tricks
         *  JQuery here, so make sure those libraries are available.
         */
        var clickHandling = (function () {


                var tooltip = d3.select("body")
                    .append("div")
                    .style("opacity", "0")
                    .style("position", "absolute")
                    .style("z-index", "100")
                    .attr("class", "toolTextAppearance"),

                appear = function(d) {
                    if (d.name != '/') {
                        tooltip.html('dd')
                            .transition()
                            .duration(200)
                            .style("opacity", "1")
                            .style("width", "400px")
                            .style("height", "400px")
                            .style("top", (d3.event.pageY - 30) + "px")
                            .style("left", (d3.event.pageX + 30) + "px");
                        return;
                    }
                    else {
                        return tooltip.html(null).style("opacity", "0");
                    }

                } ,
                mouseMove = function (d) {
                    if (d.name === '/')  {
                        return tooltip.html(null).style("opacity", "0");
                    }  else {
                        return tooltip .style("top", (d3.event.pageY - 10) + "px")
                            .style("left", (d3.event.pageX + 10) + "px");
                    }

                },
                disappear =  function () {
                    return tooltip.style("opacity", "0");
                };
               return {
                   appear:appear,
                   disappear:disappear

               }

        }());






        // Where do you want your plot?
        var margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom;


        //  private variable
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function (d) {
                var textToPresent = "";
                var textColor = '#000000';
                if (d){
                    if(d.featureExists){
                        textColor = '#00ffff';
                        textToPresent = "CCL: " +
                            d.name+
                            "<br/>Lineage: " +
                            d.line+
                            "<br/>Compound: " +
                            compoundName+
                            "<br/>Feature: " +
                            featureName +
                            "<br/>AUC: " +
                            formatTooltipNumericValue (d.value)   ;
                    }  else {
                        textColor = '#00ff00';
                        textToPresent = "CCL: "+
                            d.name+
                            "<br/>Lineage: " +
                            d.line +
                            "<br/>Compound: " +
                            compoundName  +
                            "<br/>AUC: " +
                            formatTooltipNumericValue (d.value)   ;
                    }

                }
                return "<strong></strong><span style='color:" +textColor +"'>" +textToPresent+ "</span> ";
            });




        // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            if (typeof data.featureName !== undefined) {
                featureName =  data.featureName;
            }
            if (typeof data.compoundName !== undefined) {
                compoundName =  data.compoundName;
            }
            selection
                .selectAll("svg")
                .data(data.enrichmentData)
                .enter()
                .append("svg")
                .call(tip);
            return instance;
        };


        // Now walk through the DOM and create the enrichment plot
        instance.render=function (g) {

            //  create the on screen display
            selection
                .selectAll("svg")
                .attr("width", width*1.2)
                .attr("height", height)
                .append("g");            //  create the on screen display



            selection
                .selectAll("svg")
                .each(function(d, i) {
                    d = d.sort(function(a, b) { return  (a.value)-(b.value)});
                    var g = d3.select(this),
                        dataLength = d.length,
                        minValue = d[0].value,
                        midValue = d[Math.floor(dataLength/2)].value,
                        maxValue  = d[dataLength - 1].value,
                        averageWidth = (maxValue-minValue)/( dataLength-1); // Average width


                    //define a color scale using the min and max expression values
                    var colorScale = d3.scale.linear()
                        .domain([minValue, midValue, maxValue])
                        .range(["red", "white", "blue"]);

                    var xScale = d3.scale.linear()
                        .domain([minValue, maxValue])
                        .range([0,width]);

                    xAxis = d3.svg.axis()
                        .scale(xScale)
                        .orient("bottom");

                    var zoom = d3.behavior.zoom()
                        .x(xScale)
                        //.y(yScale)
                        .scaleExtent([1, 100])
                        .on("zoom", zoomed);

                    selection.call(zoom);


                    // Here is the colorful part of the heat map
                    var dVector = d;
                    var heatmap = g.selectAll(".heatmap")
                        .data(d)
                        .enter().append("svg:rect")
                        .on('mouseover', tip.show)
                        .on('mouseout', tip.hide)
                        .attr('width', function(d,i) {
                            return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                        })
                        .attr('height', 2*height/3)
                        .attr('x', function(d,i) {
                           // return xScale(dVector[dVector[i].index].value);
                            return xScale(dVector[d.index].value);
                        } )
                        .attr('y',0)
                        .attr('fill', function(d) {
                            return colorScale(d.value);
                        })
                        .on("click", function click(d)
                        {
                            clickHandling.appear(d);
                        });

                    // Here is the indicator that the feature under consideration
                    //   is present in this cell line
                    dVector = d;
                    var featuremap = g.selectAll(".featuremap")
                        .data(d)
                        .enter().append("svg:rect")
                        .filter ( function(d,i) {
                        return d.featureExists;
                    })
                        .attr('width',function(d,i) {
                            return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                        })
                        .attr('height',  function(d,i) {
                            return (height/2);
                        })
                        .attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                        .on('mouseover', tip.show)
                        .on('mouseout', tip.hide)
                        .attr('y',height/3)
                        .attr('fill', "black")
                        .attr('stroke', 'black')
                        .on("click", function click(d)
                        {
                            clickHandling.appear(d);
                        });


                    // create an X axis
//                   g
//                       .append("g")
//                       .attr("class", "x axis")
//                       .attr("transform", "translate(0," + (height-margin.top-margin.bottom) +")")
//                       .attr("width", 140)
//                       .attr("height", 30)
//                       .call(xAxis)
//                       .append("text")
//                       .attr("class", "label")
//                       .attr("x",  0  )
//                       .attr("y",margin.bottom  )
//                       .style("text-anchor", "middle")
//                       .style("font-weight", "bold")
//                       .text('');


                    function zoomed() {
                        selection.select(".x.axis").call(xAxis);
                        heatmap.attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                            .attr('width', function(d,i) {
                                return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                            }) ;
                        featuremap.attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                            .attr('width', function(d,i) {
                                return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                            });
                    }


                    function calculateWidth(dataVector,currentElement,currentPosition,scale,aveWidth) {
                        var rectangleWidth;
                        var curPos = currentElement.index;
                        if ((curPos>=0)&&
                            (curPos < (dataLength-1))){
                            var f = scale(dataVector[curPos].value-dataVector[curPos+1].value);
                            rectangleWidth =  (scale(dataVector[curPos+1].value)-scale(dataVector[curPos].value));
                        } else {
                            rectangleWidth = (scale(aveWidth)-scale(0));
                        }
                        return rectangleWidth;


//                        var rectangleWidth;
//                        var curPos = dataVector[currentPosition].index-1;
//                        if ((curPos>=0)&&
//                            (curPos < (dataLength-1))){
//                            var f = scale(dataVector[curPos].value-dataVector[curPos+1].value);
//                            rectangleWidth =  (scale(dataVector[curPos].value)-scale(dataVector[curPos+1].value));
//                        } else {
//                            rectangleWidth = (scale(aveWidth)-scale(0));
//                        }
//                        return rectangleWidth;





                    }




                });


        };

        instance.width = function(x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function(x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        // May alternatively be passed in through initial Json data assignment
        instance.featureName = function(x) {
            if (!arguments.length) return featureName;
            featureName = x;
            return instance;
        };

        // May alternatively be passed in through initial Json data assignment
        instance.compoundName = function(x) {
            if (!arguments.length) return compoundName;
            compoundName = x;
            return instance;
        };

        instance.selectionIdentifier = function(x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };


        return instance;
    };



})();
