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

                 <span id='plot'></span>

                 <span id='slider'></span>



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
    // build a slider and attach the callback methods
    var slider = d3.slider(0,4,0,100,'vertical',interquartileMultiplier,onBrushMoveDoThis,onBrushEndDoThis) ;

    // get your data
    d3.json("http://localhost:8028/cow/box/retrieveBoxData", function (error, json) {

        var data = [];

        // loop through the data to find the global minimum/maximum
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

        // We are finally ready to display the box whisker plot
        chart.assignData (data)
             .min(globalMinimum)
             .max(globalMaximum)
             .render();

        // and now we can render the slider as well
     //   slider.render();




    });


    //  The adjustment we should make every time the slider moves a little
    function onBrushMoveDoThis (value)  {
        console.log('onBrushMoveDoThis ='+ value) ;
        chart.whiskers(iqr(value));
    }

    //  What to do when the slider has stopped moving
    function onBrushEndDoThis () {
       chart.render();
    }

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