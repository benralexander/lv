<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <title>Sunburst</title>
    <title>BARD : Compound Bio-Activity Summary</title>

    <script src="/bardwebclient/static/plugins/jquery-1.7.1/js/jquery/jquery-1.7.1.min.js" type="text/javascript" ></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/bardwebclient/static/images/favicon.ico" type="image/x-icon">
    <script src="http://d3js.org/d3.v3.min.js"></script>
<script>
    function createALegend(legendWidth, legendHeight, minimumValue,maximumValue,numberOfDivisions, colorScale, domSelector) {
        var numberOfTics = 10;
        var arr = Array.apply(null, {length:numberOfDivisions + 1}).map(Number.call, Number);
        var intervals = (legendHeight) / numberOfDivisions;
        var legendHolder = d3.select(domSelector).append("svg")
                .attr("width", legendWidth)
                .attr("height", legendHeight + 10)
                .attr("transform", "translate(" + legendWidth / 2 + "," + (legendHeight * 0.5 + 5) + ")");

        var theLegend = legendHolder.selectAll('g')
                .data(arr)
                .enter()
                .append('g')
                .attr('class', 'legend');


        theLegend.append('rect')
                .attr('x', legendWidth - 80)
                .attr('y', function (d, i) {
                    return (i * intervals) + 6;
                })
                .attr('width', 10)
                .attr('height', intervals)
                .style('fill', function (d, i) {
                    return colorScale(i / numberOfDivisions);//color(d.name);
                });

        var textSpacing = (legendHeight) / (numberOfTics * 2);
        theLegend.append('text')
                .attr('x', legendWidth - 60)
                .attr('y', function (d, i) {
                    return (i * 2) + 11;
                })
                .text(function (d, i) {
                    if ((i % textSpacing) == 0) {
                        var valToWrite = (i / numberOfDivisions);
                        return valToWrite.toString();
                    }
                    else
                        return '';
                });

    }

</script>
    <script>
        function createASunburst(width, height, padding, duration, colorScale, domSelector) {

            var radius = Math.min(width, height) / 2;

            color = d3.scale.category10().domain(["/",
                "cytoskeletal protein",
                "ligase"
            ]);


            function colorArcFill(d) {
//                return colorByRandomMap(d)
                return colorByActivity(d)
            }


            function colorByRandomMap(d) {
                var returnValue = d3.scale.category10().domain(["nucleic acid binding", "ligase", "nuclear hormone receptor"]);
                return returnValue(d.name);
            }


            function colorByActivity(d) {
                var returnValue = new String();
                if (d.ac != undefined) {
                    if (d.name=="/")   { // root is special cased
                       return "#fff";
                    }
                    var actives = parseInt(d.ac);
                    var inactives = parseInt(d.inac);
                    if ((actives + inactives)==0) // this should never happen, but safety first!
                        return "#fff";
                    var prop = actives / (actives + inactives);
                     returnValue = colorScale(prop);


                } else {    // should never happen
                    returnValue = "#FF00FF";
                }
                return returnValue;
            }
            function colorFill(d) {
                return colorByRandomMap(d);
            }
            function colorText(d) {
                return '#000';
            }
            var svg = d3.select(domSelector).append("svg")
                    .attr("width", width)
                    .attr("height", height + 10)
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + (height * .5 + 5) + ")");

            var x = d3.scale.linear()
                    .range([0, 2 * Math.PI]);

            var y = d3.scale.sqrt()
                    .range([0, radius]);


            var partition = d3.layout.partition()
                    .sort(function (d) {
                        return d.size;
                    })
                    .value(function (d) {
                        return d.size;
                    });

            var arc = d3.svg.arc()
                    .startAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
                    })
                    .endAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
                    })
                    .innerRadius(function (d) {
                        return Math.max(0, y(d.y));
                    })
                    .outerRadius(function (d) {
                        return Math.max(0, y(d.y + d.dy));
                    });

            var tooltip = d3.select("body")
                    .append("div")
                    .style("opacity", "0")
                    .style("position", "absolute")
                    .style("z-index", "10")
                    .style("visibility", "visible")
                    .attr("class", "toolTextAppearance");

            function tooltipContent(d) {
                if (d.name != '/') {
                    tooltip.style("visibility", "visible").style("opacity", "0").transition()
                            .duration(200).style("opacity", "1")
                }
                if (d.children == undefined)
                    return tooltip.html(d.name + '<br/>' + 'active in ' + d.ac + '<br/>' + 'inactive in ' + d.inac);
                else
                    return tooltip.html(d.name);
            }

            var path = svg.datum($data[0]).selectAll("path")
                    .data(partition.nodes)
                    .enter().append("path")
                // .attr("display", function(d) { return (d.depth || d.name!='/') ? null : "none"; }) // hide inner ring
                    .attr("d", arc)
                    .style("stroke", "#fff")
                    .style("fill", function (d) {
                        return colorArcFill(d);
                    })
                    .on("click", click)
                    .on("mouseover", tooltipContent)
                    .on("mousemove", function () {
                        return tooltip.style("top", (event.pageY - 10) + "px").style("left", (event.pageX + 10) + "px");
                    })
                    .on("mouseout", function () {
                        return tooltip.style("visibility", "hidden");
                    });

            var text = svg.datum($data[0]).selectAll("text").data(partition.nodes);

            function brightness(rgb) {
                return rgb.r * .299 + rgb.g * .587 + rgb.b * .114;
            }
            // Interpolate the scales!
            function arcTween(d) {
                var my = maxY(d),
                        xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                        yd = d3.interpolate(y.domain(), [d.y, my]),
                        yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
                return function (d) {
                    return function (t) {
                        x.domain(xd(t));
                        y.domain(yd(t)).range(yr(t));
                        return arc(d);
                    };
                };
            }

            function maxY(d) {
                return d.children ? Math.max.apply(Math, d.children.map(maxY)) : d.y + d.dy;
            }

            function isParentOf(p, c) {
                if (p === c) return true;
                if (p.children) {
                    return p.children.some(function (d) {
                        return isParentOf(d, c);
                    });
                }
                return false;
            }
            function mouseover(d) {
                return d.name;
            }

            function click(d) {
                path.transition()
                        .duration(duration)
                        .attrTween("d", arcTween(d));

                // Somewhat of a hack as we rely on arcTween updating the scales.
                text.style("visibility", function (e) {
                    return isParentOf(d, e) ? null : d3.select(this).style("visibility");
                })
                        .transition()
                        .duration(duration)
                        .attrTween("text-anchor", function (d) {
                            return function () {
                                return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                            };
                        })
                        .attrTween("transform", function (d) {
                            var multiline = (d.name || "").split(" ").length > 1;
                            return function () {
                                var angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                        rotate = angle + (multiline ? -.5 : 0);
                                return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                            };
                        })
                        .style("fill-opacity", function (e) {
                            return isParentOf(d, e) ? 1 : 1e-6;
                        })
                        .each("end", function (e) {
                            d3.select(this).style("visibility", isParentOf(d, e) ? null : "hidden");
                        });
            }


            var textEnter = text.enter().append("svg:text")
                    .style("fill-opacity", 1)
                    .style("fill", function (d) {
                        return  colorText(d);
                    })
                    .attr("text-anchor", function (d) {
                        return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                    })
                    .attr("dy", ".2em")
                    .attr("transform", function (d) {
                        var multiline = (d.name || "").split(" ").length > 1,
                                angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                rotate = angle + (multiline ? -.5 : 0);
                        return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                    })
                    .on("click", click)
                    .on("mouseover", tooltipContent)
                    .on("mousemove", function () {
                        return tooltip.style("top", (event.pageY - 10) + "px").style("left", (event.pageX + 10) + "px");
                    })
                    .on("mouseout", function () {
                        return tooltip.style("visibility", "hidden");
                    });

            textEnter.append("tspan")
                    .attr("x", 0)
                    .text(function (d) {
                        if (d.name=='/')
                          return 'Panther class hierarchy root';
                        else
                          return d.depth ? d.name.split(" ")[0] : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[1] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[2] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[3] || "" : "";
                    });


            d3.select(self.frameElement).style("height", height + "px");
        }

    </script>
    <style>
    #sunburstdiv {
        font-family: sans-serif;
        font-size: 12px;
        position: relative;
    }

    .toolTextAppearance {
        font: 20px serif;
        font-weight: bold;
        margin: 5px;
        padding: 10px;
        background: #eeeeee;
        border: 1px solid blue;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }

    .legend {
        font: 14px sans-serif;
        font-weight: bold;
    }

    .legendHolder {
        border: 2px solid black;
        padding-right: -50px;
        font: 12px sans-serif;
        font-weight: bold;
        text-align: center;
        background: #eeeeee;
        width: 160px;
    }

    </style>

    <script>
        window.onload = function () {
            $('#activity').change(function () {
                if (this.value == "1") {
                    location.href = "./bigSunburst?actives=t&inactives=f";
                }
                if (this.value == "2") {
                    location.href = "./bigSunburst?actives=f&inactives=t";
                }
                if (this.value == "3") {
                    location.href = "./bigSunburst?actives=t&inactives=t";
                }

            });
            $('#coloringOptions').change(function () {
                if (this.value == "1") {
                    location.href = "./bigSunburst?colorOption=1";
                }
                if (this.value == "2") {
                    location.href = "./bigSunburst?colorOption=2";
                }
                if (this.value == "3") {
                    location.href = "./bigSunburst?colorOption=3";
                }
            });
        }
    </script>

</head>

<body>


<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6">

            <a href="/bardwebclient/bardWebInterface/index">
                <img src="/bardwebclient/static/images/bard_logo_med.png" alt="BioAssay Research Database"/>
            </a>

        </div>

        <div class="span6" style="text-align: center; vertical-align: bottom;">
            <br/>
            <h2>Panther class hierarchy</h2>
        </div>

    </div>


    <script>var $data = [{"name":"/", "ac":"0", "inac":"0", "children": [
        {"name":"receptor", "ac":"8", "inac":"8", "children": [
            {"name":"G-protein coupled receptor", "ac":"3", "inac":"3", "size":3}
        ]},
        {"name":"transcription factor", "ac":"8", "inac":"5", "children": [
            {"name":"nuclear hormone receptor", "ac":"1", "inac":"1", "size":1},
            {"name":"zinc finger transcription factor", "ac":"1", "inac":"0", "size":1}
        ]},
        {"name":"nucleic acid binding", "ac":"4", "inac":"3", "size":4},
        {"name":"cytoskeletal protein", "ac":"3", "inac":"3", "children": [
            {"name":"microtubule family cytoskeletal protein", "ac":"2", "inac":"2", "children": [
                {"name":"non-motor microtubule binding protein", "ac":"1", "inac":"1", "size":1}
            ]}
        ]},
        {"name":"ligase", "ac":"4", "inac":"4", "children": [
            {"name":"ubiquitin-protein ligase", "ac":"2", "inac":"2", "size":2}
        ]}
    ]}]
    var minimumValue=0.0;
    var maximumValue=1.0;
    var continuousColorScale = d3.scale.linear()
            .domain([0, 1])
            .interpolate(d3.interpolateRgb)
            .range(["#ff0000", "#00ff00"]);

    </script>


    <div class="row-fluid">
        <div class="span9 pull-left">

            <div id="sunburstdiv">

                <div id="sunburstdiv">
                    <script>
                        createASunburst( 800, 800,5,1000,continuousColorScale,'div#sunburstdiv');
                    </script>

                </div>
            </div>

        </div>

        <div class="span3" style="padding-top: 50px;  height: 600px;">
            <div style="float:right;">

                <div id="sunburstlegend" class="legendHolder">
                    Color assignment:<br />
                    x = active / <br />
                    (active + inactive)
                    <hr width=100% color=black style="color: #000; height:1px;">

                    <script>
                        createALegend(120, 200,100,continuousColorScale,'div#sunburstlegend');
                    </script>

                    <div  style="padding-top: 5px;"></div>

                </div>

            </div>

            <div style="text-align: center; vertical-align: bottom;">

                <select id="coloringOptions" style="visibility: hidden">
                    <option value="1"
                    >Color by activity</option>
                    <option value="2"
                    >Split classes by activity</option>
                    <option value="3" >Color by class</option>
                </select>
                <div  style="padding-top: 320px;"></div>
                <select id="activity">
                    <option value="1" selected>Active only</option>
                    <option value="2" >Inactive only</option>
                    <option value="3"
                    >Active and Inactive</option>
                </select>

            </div>

        </div>
    </div>
</div>

</body>
</html>