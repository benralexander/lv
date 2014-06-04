<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Line Chart</title>
    <link rel="stylesheet" type="text/css" href="../css/ctrp/doseResponse.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script src="../js/ctrp/doseResponse.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
    <style>
        .errorbar {
            fill: #379;
            stroke: #0099ff;
            stroke-width: 1.1px;
        }
    </style>
</head>

<body>

<script type="text/javascript">


    function update() {

        for (var i = 0; i < data.length; ++i) {
            var series = data[i];
            series.length = 0;
            for (var j = 0; j < numberOfDataPoint; ++j)
                series.push({x: j, y:  Math.random() * 9});
        }

        chart.render();
    }

    var numberOfSeries = 2,
            numberOfDataPoint = 11,
            data = [];
    var curves =  [
        {
            "curveInflectionPoint": -114.4,
            "inflectionPointUpperCI": 143020000000,
            "curveBaseline": 1.151,
            "curveSlope": 9.1461,
            "maxConcAUC08": 498.3,
            "cpdAUC": 6.8761,
            "curveHeight": -0.16868,
            "pvPoint": [
                {
                    "pvError": 0.33817,
                    "pv": 1.01187575991386,
                    "cpdConc": 0.015208
                },
                {
                    "pvError": 0.30108,
                    "pv": 0.973134525228617,
                    "cpdConc": 0.030416
                },
                {
                    "pvError": 0.26798,
                    "pv": 1.07411145842929,
                    "cpdConc": 0.060832
                },
                {
                    "pvError": 0.2386,
                    "pv": 1.20346710033447,
                    "cpdConc": 0.12165999999999999
                },
                {
                    "pvError": 0.21245,
                    "pv": 0.907895292568535,
                    "cpdConc": 0.24333
                },
                {
                    "pvError": 0.1892,
                    "pv": 1.0371045605161,
                    "cpdConc": 0.48666
                },
                {
                    "pvError": 0.16847,
                    "pv": 1.23423509941709,
                    "cpdConc": 0.97332
                },
                {
                    "pvError": null,
                    "pv": 1.03398548274094,
                    "cpdConc": 1.9466
                },
                {
                    "pvError": 0.13365,
                    "pv": 0.913347672574305,
                    "cpdConc": 3.8933
                },
                {
                    "pvError": 0.11906,
                    "pv": 0.88818915987826,
                    "cpdConc": 7.7865
                },
                {
                    "pvError": 0.10604,
                    "pv": 0.967871300572043,
                    "cpdConc": 15.573
                },
                {
                    "pvError": 0.94456,
                    "pv": 0.853815061119003,
                    "cpdConc": 31.146
                },
                {
                    "pvError": 0.84155,
                    "pv": 0.690549755436603,
                    "cpdConc": 62.292
                },
                {
                    "pvError": 0.7501,
                    "pv": 0.77014971340433,
                    "cpdConc": 124.58
                },
                {
                    "pvError": 0.66781,
                    "pv": 0.604333068293458,
                    "cpdConc": 249.17000000000002
                },
                {
                    "pvError": 0.59595,
                    "pv": 0.90459192190164,
                    "cpdConc": 498.34000000000003
                }
            ],
            "nominalEC50": 3.6364e-35,
            "pvPredValueLast": 0.9823,
            "inflectionPointLowerCI": -143020000000,
            "concUnit": "uM"
        }
    ];


    var viabilityChart =  d3.doseResponse();
    var calculatedAucIndexRange = viabilityChart.calculateBoundsForShading (curves[0].pvPoint,
                    data.maxConcAUC08, 8),
            boundsForXAxis = viabilityChart.calculateBoundsForXAxis(curves[0].pvPoint);
    viabilityChart.displayGridLines(false)
            .xAxisLabel('log Concentration')
            .yAxisLabel('Viability')
            .selectionIdentifier('body')
            .title('this is my title')
            .width(400)
            .autoScale(false)
            .areaUnderTheCurve ([5,13]) // Shade points 5 - 13
            //.domainMultiplier(1.2)    only used if autoscale==true
            .areaUnderTheCurve([calculatedAucIndexRange.minIndex,calculatedAucIndexRange.maxIndex ])
            .x(d3.scale.log().domain([boundsForXAxis.min, boundsForXAxis.max]))
            .y(d3.scale.linear().domain([0, 1.5]));

//    var c = chart.generateSigmoidPoints(10,  //  yMin
//                                        100, //  yMax
//                                        -5,  // hillSlope
//                                        900,  // Ec50
//                                        100,  //  numberOfPoints
//                                        200,  //   xStart
//                                        1400 //   xEnd
//    );
//    var d = chart.generateSigmoidPoints( 50,  //  yMin
//            90, //  yMax
//            -6,  // hillSlope
//            900,  // Ec50
//            1000,  //  numberOfPoints
//            400,  //   xStart
//            1600 //   xEnd
//    );

 //   curves[1].elements =  c;
 //   curves[2].elements =  d;

    curves.forEach(function (series) {
        viabilityChart.addSeries(series);
    });

    viabilityChart.render();
</script>

<div class="control-group">
    <button onclick="update()">Update</button>
</div>

</body>

</html>