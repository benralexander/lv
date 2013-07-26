
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
    var width = 960,
            height = 500;

    var svg = d3.select("body").append("svg")
            .attr("width", width)
            .attr("height", height);

    var force = d3.layout.force()
            .gravity(.05)
            .distance(100)
            .charge(-100)
            .size([width, height]);

    d3.json("http://localhost:8028/cow/force/feedMeJson", function (error, json) {
        update(json);
    });

    function update(json) {

        force
                .nodes(json.nodes)
                .links(json.links)
                .start();

        var link = svg.selectAll(".link")
                .data(json.links)
                .enter().append("line")
                .attr("class", "link");

        var node = svg.selectAll(".node")
                .data(json.nodes)
                .enter().append("g")
                .attr("class", "node")
                .call(force.drag);

        node.append("svg:circle")
                .attr("cx", 0)
                .attr("cy", 0)
                .attr("r", 8)
                .style("fill", function (d, i) {
                    return '#ff00cc';
                })
                .style("stroke", function (d, i) {
                    return '#00ffcc';
                })
        ;


        // Color leaf nodes orange, and packages white or blue.
        function color(d) {
            return d._children ? "#3182bd" : d.children ? "#c6dbef" : "#fd8d3c";
        }

        // Toggle children on click.
        function click(d) {
            if (d.children) {
                d._children = d.children;
                d.children = null;
            } else {
                d.children = d._children;
                d._children = null;
            }
            update();
        }


        node.append("text")
                .attr("dx", 12)
                .attr("dy", ".35em")
                .text(function (d) {
                    return d.name
                });

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
        force.on("tick", tick);
    }
    ;
</script>
</body>
</html>
