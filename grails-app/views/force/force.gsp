
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>Force-Directed Graph</title>
    <script src="../js/d3.js"></script>
    %{--<script type="text/javascript" src="http://mbostock.github.com/d3/d3.js?1.25.0"></script>--}%
    %{--<script type="text/javascript" src="http://mbostock.github.com/d3/d3.geom.js?1.25.0"></script>--}%
    %{--<script type="text/javascript" src="http://mbostock.github.com/d3/d3.layout.js?1.25.0"></script>--}%
    <style>

.link {
    stroke: #ccc;
}

.node text {
    pointer-events: none;
    font: 10px sans-serif;
}
circle.node {
    cursor: pointer;
    stroke: #3182bd;
    stroke-width: 1.5px;
}

</style>
</head>
<body>
<div id="chart"></div>
<script type="text/javascript">
    d3.custom = {};
    d3.custom.nodePlot = function module() {
        // adjustable parameters
         var width = 960,
             height = 500;

        /***
         * All the work of building the node plot goes inside the 'exports' function
         * @param _selection
         */
        function exports(_selection) {
            // So it can loop through this selection with d3.each
            _selection.each(function (_data) {

                var svg = d3.select(this).append("svg")
                        .attr("width", width)
                        .attr("height", height);

                var force = d3.layout.force()
                        .gravity(.05)
                        .distance(100)
                        .charge(-100)
                        .size([width, height]);

                d3.json("http://localhost:8028/cow/force/feedMeJson", function (error, json) {
                    nodePlotInternals(json);
                });


                /***
                 * This is the meaty part of building a force layout diagram
                 * @param json
                 */
                function nodePlotInternals(json) {

                    // define the nodes in the links and start the actual plot.  The 'start' causes the indexes in the link
                    // to be substituted with real pointers to the nodes, so this is not a shareable data structure
                    force.nodes(json.nodes)
                            .links(json.links)
                            .start();

                    // so the links have been updated by the 'start' command. Well we better update them in the plot.
                    var link = svg.selectAll(".link")
                            .data(json.links)
                            .enter().append("line")
                            .attr("class", "link");

                    // Now that the links of been added to the plot let's add the notes to the plot
                    var node = svg.selectAll(".node")
                            .data(json.nodes)
                            .enter().append("g")
                            .attr("class", "node")
                            .call(force.drag);

                    // Having built the nodes must decide what they should look like
                    node.append("svg:circle")
                            .attr("cx", 0)
                            .attr("cy", 0)
                            .attr("r", 8)
                            .style("fill", function (d, i) {
                                return '#ff00cc';
                            })
                            .style("stroke", function (d, i) {
                                return '#00ffcc';
                            });

                    //
                    node.append("text")
                            .attr("dx", 12)
                            .attr("dy", ".35em")
                            .text(function (d) {
                                return d.name
                            });



                    function tick() {
                        path.attr("d", function(d) {
                            var dx = d.target.x – d.source.x,
                                    dy = d.target.y – d.source.y,
                                    dr = Math.sqrt(dx * dx + dy * dy);
                            return "M" +
                                    d.source.x + "," +
                                    d.source.y + "A" +
                                    dr + "," + dr + " 0 0,1 " +
                                    d.target.x + "," +
                                    d.target.y;
                        });
                        node
                                .attr("transform", function(d) {
                                    return "translate(" + d.x + "," + d.y + ")"; });
                    }



                    // finally attach a tick function to allow the nodes to move around
                    var tick = function () {
                        link.attr("x1", function (d) {
                            return d.source.x;
                        })
                                .attr("y1", function (d) {
                                    return d.source.y;
                                })
                                .attr("x2", function (d) {
                                    return d.target.x;
                                })
                                .attr("y2", function (d) {
                                    return d.target.y;
                                });

                        node.attr("transform", function (d) {
                            return "translate(" + d.x + "," + d.y + ")";
                        });
                    }

                    // Having built the tech function, attach it to the force diagram
                    force.on("tick", tick);

                } // nodePlotInternals


            });
        }

        /***
         * This is the section for externally getting/setting variables
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

    }
    var nodePlot = d3.custom.nodePlot().width(400).height(400);
    nodePlot(d3.select("body>#chart"));
</script>
</body>
</html>
