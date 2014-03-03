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
    <link media="all" rel="stylesheet" href="../css/ctrp/boxWhiskerPlot.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/slider.css">
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
</head>
<!DOCTYPE html>
<meta charset="utf-8">

<body>
<div id='plot'></div>
<div id='slider'></div>
<script src="../js/ctrp/boxWhiskerPlot.js"></script>
<script src="../js/ctrp/slider.js"></script>
<script>

    var
      // these sizes referred to each individual bar in the bar whisker plot
      margin = {top: 50, right: 50, bottom: 20, left: 50},
            width = 120 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    // minimum and maximum values across all bars
    var globalMinimum = Infinity,
            globalMaximum = -Infinity;

    // initial value of the interquartile multiplier. Note that this value
    //  is adjustable via a UI slider
    var interquartileMultiplier = 1.5;

    // build those portions of the box whisker plot that our data independent
    var chart = d3.boxWhiskerPlot()
            .selectionIdentifier("#plot")
            .width(width)
            .height(height)
            .whiskers(iqr(interquartileMultiplier));

    var slider = d3.slider();
           // .width(500);



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

        // add in those portions of the box whisker plot that our data dependent
        chart.assignData (data)
             .min(globalMinimum)
             .max(globalMaximum)
             .render();


        // slider.render()
//        var sliderWidth = 500;
//        var x = d3.scale.linear()
//                .domain([0, 2])
//                .range([0, sliderWidth])
//                .clamp(true);
//
//        var brush = d3.svg.brush()
//                .x(x)
//                .extent([sliderWidth, sliderWidth])
//                .on("brush", brushed);
//
//        var svg = d3.select("#slider").append("svg")
//                .attr("width", margin.width)
//                .attr("height", margin.height)
//                .append("g")
//                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
//        svg.append("g")
//                .attr("class", "x axis")
//                .attr("transform", "translate(0," + height / 2 + ")")
//                .call(d3.svg.axis()
//                        .scale(x)
//                        .orient("bottom")
//                        .tickFormat(function(d) { return d + "°"; })
//                        .tickSize(0)
//                        .tickPadding(12))
//                .select(".domain")
//                .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
//                .attr("class", "halo");
//
//        var slider = svg.append("g")
//                .attr("class", "slider")
//                .call(brush);

        slider.render();

//            slider.selectAll(".extent,.resize")
//                    .remove();
//
//            slider.select(".background")
//                    .attr("height", height);
//
//            var handle = slider.append("circle")
//                    .attr("class", "handle")
//                    .attr("transform", "translate(0," + height / 2 + ")")
//                    .attr("r", 9);
//
//            slider.call(brush.event);


        function brushed() {
            var value = brush.extent()[0];

            if (d3.event.sourceEvent) { // not a programmatic event
                value = x.invert(d3.mouse(this)[0]);
                brush.extent([value, value]);
            }
            handle.attr("cx", x(value));
            if (!isNaN(value)){
                interquartileMultiplier = value;
                chart.whiskers(iqr(interquartileMultiplier)).render();
            }
        }

    });


    // Returns a function to compute the interquartile range, which is represented
    // through the whiskers attached to the quartile boxes.  Without this function the
    // whiskers will expand to cover the entire data range. With it they will
    // shrink to cover a multiple of the interquartile range.  Set the parameter
    // two zero and you'll get a box with no whiskers
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