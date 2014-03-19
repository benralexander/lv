<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Line Chart</title>
    <link rel="stylesheet" type="text/css" href="../css/ctrp/doseResponse.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script src="../js/ctrp/doseResponse.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
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
        { name: 'SKOV3',
          elements:[
              {x: 1.2, y: 98.2},
              {x: 10.3, y: 80},
              {x: 20, y: 22},
              {x: 49.9, y: 4}
          ]
        },
        { name: 'NCI/ADR-RES',
            elements:[
                {x: 2.2, y: 98.2},
                {x: 12.3, y: 60},
                {x: 19, y: 5},
                {x: 49.9, y: 2}
            ]
        },
        { name: 'OVCOR8',
            elements:[
                {x: 1.5, y: 98.2},
                {x: 10.5, y: 50},
                {x: 20.9, y: 4},
                {x: 49.9, y: 1}
            ]
        }
    ];

    for (var i = 0; i < numberOfSeries; ++i)
        data.push(d3.range(numberOfDataPoint).map(function (i) {
            return {x: i, y: Math.random() * 9};
        }));

    var chart =  d3.doseResponse()
            .x(d3.scale.linear().domain([0, 60]))
            .y(d3.scale.linear().domain([0, 100]));

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