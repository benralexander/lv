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
    <script src="../js/d3tooltip.js"></script>
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
    fill: #f00;
    stroke: #111;
}
.d3-tip {
    line-height: 1;
    font-weight: bold;
    padding: 12px;
    background: rgba(0, 0, 0, 0.8);
    color: #fff;
    border-radius: 2px;
}

    /* Creates a small triangle extender for the tooltip */
.d3-tip:after {
    box-sizing: border-box;
    display: inline;
    font-size: 10px;
    width: 100%;
    line-height: 1;
    color: rgba(0, 0, 0, 0.8);
    content: "\25BC";
    position: absolute;
    text-align: center;
}

    /* Style northward tooltips differently */
.d3-tip.n:after {
    margin: -1px 0 0 0;
    top: 100%;
    left: 0;
}

</style>
<body>
<script src="../js/box.js"></script>
<script>

    var margin = {top: 10, right: 50, bottom: 20, left: 50},
            width = 120 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    var globalMinimum = Infinity,
            globalMaximum = -Infinity;


    var chart = d3.box()
            .selectionIdentifier("body")
            .whiskers(iqr(1.0))
            .width(width)
            .height(height) ;



    d3.json("http://localhost:8028/cow/box/retrieveBoxData", function (error, json) {
        var data = [];
        json.forEach(function (x) {
                var e = Math.floor(x.Expt - 1),
                        r = Math.floor(x.Run - 1),
                        s = Math.floor(x.Speed),
                        d = data[e];
                if (!d) d = data[e] = [{value:s,
                    description:'first value of '+s}];
                else d.push({value:s,
                             description:'value of '+s});
                if (s > globalMaximum) globalMaximum = s;
                if (s < globalMinimum) globalMinimum = s;
         });

        chart
                .assignData (data)
                .min(globalMinimum)
                .max(globalMaximum)
                .render();

    });


    // Returns a function to compute the interquartile range.
    function iqr(k) {
        return function(d, i) {
            var q1 = d.quartiles[0],
                    q3 = d.quartiles[2],
                    iqr = (q3 - q1) * k,
                    i = -1,
                    j = d.length;
            while ((d[++i].value) < q1 - iqr);
            while ((d[--j].value) > q3 + iqr);
            return [i, j];
        };
    }

</script>
</body>
</html>