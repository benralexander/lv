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
    %{--<script src="../js/jquery-1.7.1.min.js"></script>--}%
    <script src="../js/jquery-2.0.3.min.js"></script>
    %{--<script src="../js/jquery-2.0.3.min.js "></script>--}%
        %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--}%
    <link media="all" rel="stylesheet" href="../css/ctrp/boxWhiskerPlot.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/clickablePopUp.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/slider.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/d3tooltip.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/scatter.css">
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
</head>
<!DOCTYPE html>
<meta charset="utf-8">

<body>
<table style='margin-top: 50px; border-top: 50px;'>

                  <tr>
                      <td style='width: 450px'>
                          <span id='plot'></span>
                      </td>
                      <td style='width: 100px;'>
                          <span style="padding-left: 25px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px">
                              Interquartile multiplier
                          </span>
                          <div id='slider'
                               style="border: 1px solid #adffff;
                               margin-top: 20px;
                               margin-left: 10px;
                               margin-right: 10px;
                               padding-left: 40px;
                               padding-bottom: 50px;
                               padding-top: 50px;
                               padding-right: 40px"
                          ></div>
                      </td>
                      <td style='margin-right: 0px;'></td>
                  </tr>





</table>

<script src="../js/ctrp/boxWhiskerPlot.js"></script>
<script src="../js/ctrp/scatter.js"></script>
<script src="../js/ctrp/slider.js"></script>
<script>

    var
      // these sizes referred to each individual bar in the bar whisker plot
      margin = {top: 50, right: 50, bottom: 20, left: 50},
            width = 420 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

    // minimum and maximum values across all bars
    var globalMinimum = Infinity,
            globalMaximum = -Infinity;

    // initial value of the interquartile multiplier. Note that this value
    //  is adjustable via a UI slider
    var defaultInterquartileMultiplier = 1.5,
            maximumInterquartileMultiplier = 3,
            minimumInterquartileMultiplier = 0,
            onScreenStart = 0,
            onScreenEnd = 100;

    // build those portions of the box whisker plot that our data independent
    var chart = d3.boxWhiskerPlot()
            .selectionIdentifier("#plot")
            .width(width)
            .height(height)
            .whiskers(iqr(defaultInterquartileMultiplier))
            .boxWhiskerName ('3,4,5-trimethoxy benzaldehyde');
    // build a slider and attach the callback methods
    var slider = d3.slider(minimumInterquartileMultiplier,
            maximumInterquartileMultiplier,
            onScreenStart,
            onScreenEnd,
            'vertical',defaultInterquartileMultiplier/2,onBrushMoveDoThis,onBrushEndDoThis) ;
    onBrushMoveDoThis(minimumInterquartileMultiplier);

    // get your data
    d3.json("http://localhost:8028/cow/box/retrieveBoxData", function (error, json) {

        var data = [];
        var stubDataGenes = [
            "MYC",
            "BRCA2",
            "STAT6",
            "PDE4DIP",
            "PDCD1",
            "LRP1"
        ];

        // loop through the data to find the global minimum/maximum
        json.forEach(function (x,i) {
                var e = Math.floor(x.Expt - 1),
                        s = x.Value,
                        e=0;
                        d = data[e];
                if (!d) d = data[e] = [{value:s,
                    description:'first value of '+s}];
                else d.push({value:s,
                             description:stubDataGenes [(i %stubDataGenes.length)]});
                if (s > globalMaximum) globalMaximum = s;
                if (s < globalMinimum) globalMinimum = s;
         });


        /***
         * Sample JSON data:
         [
             {
                value:0.8,
                description:'MYC',
             },
             {
                value:0.2,
                description:'STAT6',
             },

             {
                value:-0.3,
                description:'BRCA2',
             }
         ]
         */


        // We are finally ready to display the box whisker plot
        chart.assignData (data)
             .min(globalMinimum)
             .max(globalMaximum)
                .scatterDataCallback( respondToScatterData )
                .compoundIdentifier(375788)
             .render();

        // and now we can render the slider as well
     //   slider.render();




    });


    function respondToScatterData(data)  {
        var margin = {top: 30, right: 20, bottom: 50, left: 70},
                width = 600 - margin.left - margin.right,
                height = 400 - margin.top - margin.bottom;
        d3.scatterPlot()
                .selectionIdentifier("#scatterPlot1")
                .width (width)
                .height (height)
                .margin(margin)
                .assignData (data)
                .xAxisLabel ('Navitoclax AUC')
                .yAxisLabel ('BCL2 expression level')
                .render() ;

    }




    //  The adjustment we should make every time the slider moves a little
    function onBrushMoveDoThis (value)  {
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
<div class="messagepop pop" id="examineCorrelation">
    <form method="post" id="new_message" action="/messages">
        <h1>Correlation plot</h1>
        <div id="scatterPlot1"></div>
        <p><a class="close" href="/">Cancel</a></p>
    </form>
</div>
<div class="d" id="teste">
    <button>hi</button>
    </div>



</body>
</html>