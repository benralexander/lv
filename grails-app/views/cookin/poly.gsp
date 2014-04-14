<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 4/12/14
  Time: 5:44 PM
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<meta charset="utf-8">
<style>

.circle {
    fill: red;
    fill-opacity: .3;
}

.circle.intersects {
    fill: green;
}

.polygon path {
    fill: #000;
    fill-opacity: .3;
}

.polygon circle {
    fill: #000;
    stroke: #fff;
    cursor: move;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

    var width = 1160,
            height = 500;

    var svg = d3.select("body").append("svg")
            .attr("width", width)
            .attr("height", height);

    var circle = svg.append("circle")
            .attr("class", "circle intersects")
            .datum([width / 2, height / 2, 120])
            .call(positionCircle)
            .attr("r", function(d) { return d[2]; });

    var polygon = svg.append("g")
            .attr("class", "polygon")
            .datum([[10, 10], [260, 443], [460, 10] ]);

    polygon.append("path")
            .call(positionPath);

    polygon.selectAll("circle")
            .data(function(d) { return d; })
            .enter().append("circle")
            .call(positionCircle)
            .attr("r", 4.5)
            .call(d3.behavior.drag()
                    .origin(function(d) { return {x: d[0], y: d[1]}; })
                    .on("drag", function(d) {
                        d[0] = d3.event.x, d[1] = d3.event.y;
                        d3.select(this).call(positionCircle);
                        polygon.select("path").call(positionPath);
                        circle.classed("intersects", intersects(circle.datum(), polygon.datum()));
                    }));

    function positionCircle(circle) {
        circle
                .attr("cx", function(d) { return d[0]; })
                .attr("cy", function(d) { return d[1]; });
    }

    function positionPath(path) {
        path
                .attr("d", function(d) { return "M" + d.join("L") + "Z"; });
    }

    function intersects(circle, polygon) {
        return pointInPolygon(circle, polygon)
                || polygonEdges(polygon).some(function(line) { return pointLineSegmentDistance(circle, line) < circle[2]; });
    }

    function polygonEdges(polygon) {
        return polygon.map(function(p, i) {
            return i ? [polygon[i - 1], p] : [polygon[polygon.length - 1], p];
        });
    }

    function pointInPolygon(point, polygon) {
        for (var n = polygon.length, i = 0, j = n - 1, x = point[0], y = point[1], inside = false; i < n; j = i++) {
            var xi = polygon[i][0], yi = polygon[i][1],
                    xj = polygon[j][0], yj = polygon[j][1];
            if ((yi > y ^ yj > y) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) inside = !inside;
        }
        return inside;
    }

    function pointLineSegmentDistance(point, line) {
        var v = line[0], w = line[1], d, t;
        return Math.sqrt(pointPointSquaredDistance(point, (d = pointPointSquaredDistance(v, w))
                ? ((t = ((point[0] - v[0]) * (w[0] - v[0]) + (point[1] - v[1]) * (w[1] - v[1])) / d) < 0 ? v
                : t > 1 ? w
                : [v[0] + t * (w[0] - v[0]), v[1] + t * (w[1] - v[1])])
                : v));
    }

    function pointPointSquaredDistance(v, w) {
        var dx = v[0] - w[0], dy = v[1] - w[1];
        return dx * dx + dy * dy;
    }

</script>