<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 7/27/13
  Time: 3:23 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<body>

</body>
</html>


<!DOCTYPE html>
<meta charset="utf-8">
<script src="../js/d3.js"></script>
<style>

path.link {
    fill: none;
    stroke: #666;
    stroke-width: 1.5px;
}

path.link.twofive {
    opacity: 0.25;
}

path.link.fivezero {
    opacity: 0.50;
}

path.link.sevenfive {
    opacity: 0.75;
}

path.link.onezerozero {
    opacity: 1.0;
}

circle {
    fill: #ccc;
    stroke: #fff;
    stroke-width: 1.5px;
}

text {
    fill: #000;
    font: 10px sans-serif;
    pointer-events: none;
}

</style>
<body>
<div id="chart"></div>
<script>

    d3.custom = {};

    d3.custom.directedGraph = function module() {
        var width = 960,
                height = 500;

        /***
         * All the work of building the node plot goes inside the 'exports' function
         * @param _selection
         */
        function exports(_selection) {
            // So it can loop through this selection with d3.each
            _selection.each(function (_data) {

                var force = d3.layout.force()
                        .size([width, height])
                        .linkDistance(60)
                        .charge(-300),

                svg = d3.select(this).append("svg")
                        .attr("width", width)
                        .attr("height", height),

                // Set the range
                v = d3.scale.linear().range([0, 100]);

                /***
                *   Call for the data, and perform all the functions that are data dependent.
                */
                d3.json("http://localhost:8028/cow/curvedForce/feedMeJson", function (error, indata) {
                    nodePlotInternals(indata);
                });



                 /***
                 * This is the meaty part of building this force layout diagram
                 * @param links
                 */
                function nodePlotInternals(links) {

                    var nodes = {};

                    // Compute the distinct nodes from the links.
//                    links.forEach(function (link) {
//                        link.source = nodes[link.source] ||
//                                (nodes[link.source] = {name: link.source});
//                        link.target = nodes[link.target] ||
//                                (nodes[link.target] = {name: link.target});
//                        link.value = +link.value;
//                    });

//                     force.nodes(d3.values(nodes))
//                             .links(links)
//                             .on("tick", tick)
//                             .start();
                     force.nodes(links.nodes)
                             .links(links.links)
                             .on("tick", tick)
                             .start();

                    // Scale the range of the data
                    v.domain([0, d3.max(links.links, function (d) {
                        return d.value;
                    })]);

                    // asign a type per value to encode opacity
                    links.links.forEach(function (link) {
                        if (v(link.value) <= 25) {
                            link.type = "twofive";
                        } else if (v(link.value) <= 50 && v(link.value) > 25) {
                            link.type = "fivezero";
                        } else if (v(link.value) <= 75 && v(link.value) > 50) {
                            link.type = "sevenfive";
                        } else if (v(link.value) <= 100 && v(link.value) > 75) {
                            link.type = "onezerozero";
                        }
                    });


                    // build the arrow.
                    svg.append("svg:defs").selectAll("marker")
                            .data(["end"])      // Different link/path types can be defined here
                            .enter().append("svg:marker")    // This section adds in the arrows
                            .attr("id", String)
                            .attr("viewBox", "0 -5 10 10")
                            .attr("refX", 15)
                            .attr("refY", -1.5)
                            .attr("markerWidth", 6)
                            .attr("markerHeight", 6)
                            .attr("orient", "auto")
                            .append("svg:path")
                            .attr("d", "M0,-5L10,0L0,5");

                    // add the links and the arrows
                    var path = svg.append("svg:g").selectAll("path")
                            .data(force.links())
                            .enter().append("svg:path")
                            .attr("class", function (d) {
                                return "link " + d.type;
                            })
                            .attr("marker-end", "url(#end)");

                    // define the nodes
                    var node = svg.selectAll(".node")
                            .data(force.nodes())
                            .enter().append("g")
                            .attr("class", "node")
                            .on("click", click)
                            .on("dblclick", dblclick)
                            .call(force.drag);

                    // add the nodes
                    node.append("circle")
                            .attr("r", 5);

                    // add the text
                    node.append("text")
                            .attr("x", 12)
                            .attr("dy", ".35em")
                            .text(function (d) {
                                return d.name;
                            });

                    // add the curvy lines
                    function tick() {
                        path.attr("d", function (d) {
                            var dx = d.target.x - d.source.x,
                                    dy = d.target.y - d.source.y,
                                    dr = Math.sqrt(dx * dx + dy * dy);
                            return "M" +
                                    d.source.x + "," +
                                    d.source.y + "A" +
                                    dr + "," + dr + " 0 0,1 " +
                                    d.target.x + "," +
                                    d.target.y;
                        });

                        node
                                .attr("transform", function (d) {
                                    return "translate(" + d.x + "," + d.y + ")";
                                });
                    }

                } // nodePlotInternals


            });

            /***
            * Callbacks go here.  They are private to the directedGraph module
            */

            // action to take on mouse click
            function click() {
                d3.select(this).select("text").transition()
                        .duration(750)
                        .attr("x", 22)
                        .style("fill", "steelblue")
                        .style("stroke", "lightsteelblue")
                        .style("stroke-width", ".5px")
                        .style("font", "20px sans-serif");
                d3.select(this).select("circle").transition()
                        .duration(750)
                        .attr("r", 16)
                        .style("fill", "lightsteelblue");
            }

            // action to take on mouse double click
            function dblclick() {
                d3.select(this).select("circle").transition()
                        .duration(750)
                        .attr("r", 6)
                        .style("fill", "#ccc");
                d3.select(this).select("text").transition()
                        .duration(750)
                        .attr("x", 12)
                        .style("stroke", "none")
                        .style("fill", "black")
                        .style("stroke", "none")
                        .style("font", "10px sans-serif");
            }


        }


        /***
         * This is the section for externally visible variables
         */

        exports.width = function(_x) {
            if (!arguments.length) return width;
            width = _x;
            return this;
        };

        exports.height = function(_x) {
            if (!arguments.length) return height;
            height = _x;
            return this;
        };


        return exports;


    };



    var directedGraph = d3.custom.directedGraph();
    directedGraph.width(400).height(400);
    directedGraph(d3.select("body>#chart"));

</script>
</body>
</html>
