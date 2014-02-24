<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 2/18/14
  Time: 7:43 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>boxwhisk</title>
    <script src="../js/d3.js"></script>
</head>
<!DOCTYPE html>
<meta charset="utf-8">
<style>

body {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.box {
    font: 10px sans-serif;
}

.box line,
.box rect,
.box circle {
    fill: #fff;
    stroke: #000;
    stroke-width: 1.5px;
}

.box .center {
    stroke-dasharray: 3,3;
}

.box .outlier {
    fill: none;
    stroke: #ccc;
}

</style>
<body>
<script src="../js/box.js"></script>
<script>

    var margin = {top: 10, right: 50, bottom: 20, left: 50},
            width = 120 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    var min = Infinity,
            max = -Infinity;

    var chart = d3.box()
            .whiskers(iqr(0.1))
            .width(width)
            .height(height)
            .dataUrl ("http://localhost:8028/cow/box/retrieveBoxData")
            .render();


//
//    d3.json("http://localhost:8028/cow/box/retrieveBoxData", function(error, csv) {
//        var data = [];
//
//        csv.forEach(function(x) {
//            var e = Math.floor(x.Expt - 1),
//                    r = Math.floor(x.Run - 1),
//                    s = Math.floor(x.Speed),
//                    d = data[e];
//            if (!d) d = data[e] = [s];
//            else d.push(s);
//            if (s > max) max = s;
//            if (s < min) min = s;
//        });
//
//        chart.domain([min, max]);
//
//        var svg = d3.select("body").selectAll("svg")
//                .data(data)
//                .enter().append("svg")
//                .attr("class", "box")
//                .attr("width", width + margin.left + margin.right)
//                .attr("height", height + margin.bottom + margin.top)
//                .append("g")
//                .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
//                .call(chart.render);
//
//
//    });


    // Returns a function to compute the interquartile range.
    function iqr(k) {
        return function(d, i) {
            var q1 = d.quartiles[0],
                    q3 = d.quartiles[2],
                    iqr = (q3 - q1) * k,
                    i = -1,
                    j = d.length;
            while (d[++i] < q1 - iqr);
            while (d[--j] > q3 + iqr);
            return [i, j];
        };
    }

</script>
</body>
</html>