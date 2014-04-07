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
    var curves = [
//        {   name: 'SKOV3_2',
//            yMinimum: 2.5,
//            yMaximum: 93.1,
//            inflection: 26.0,
//            hillslope: -1.01,
//            elements:[
//                {x: 2.2, y: 98.2},
//                {x: 12.3, y: 60},
//                {x: 19, y: 5},
//                {x: 49.9, y: 2}
//            ]
//        },
        {   name: 'NCI/ADR-RES',
            yMinimum: 0.5,
            yMaximum: 89,
            inflection: 25.0,
            hillslope: -2.0,
            elements:[
                {x: 2.2, y: 98.2},
                {x: 12.3, y: 60, dyp: 10.2, dyn: 20.2, dxp: 10.2, dxn: 12.2 },
                {x: 19, y: 5, dxp: 10.2, dxn: 12.2 },
                {x: 49.9, y: 2}
            ]
        },
        { name: 'OVCOR8',
          yMinimum: 8.5,
          yMaximum: 70.1,
          inflection: 25.0,
          hillslope: -1.0,
          elements:[
                {x: 1.5, y: 98.2},
                {x: 10.5, y: 50, dyp: 10.2, dyn: 20.2 },
                {x: 20.9, y: 4, dxp: 10.2, dxn: 12.2 },
                {x: 49.9, y: 1, dyp: 18.2, dyn: 28.2}
           ]
        }
    ];

    var chart =  d3.doseResponse()
            .displayGridLines(true)
            .xAxisLabel('Concentration')
            .yAxisLabel('Response')
            .x(d3.scale.linear().domain([0, 60]))
            .y(d3.scale.linear().domain([0, 150]));
 //   .x(d3.scale.linear().domain([0, 1500]))
 //           .y(d3.scale.linear().domain([10, 110]));

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
        chart.addSeries(series);
    });

    chart.render();
</script>

<div class="control-group">
    <button onclick="update()">Update</button>
</div>

</body>

</html>