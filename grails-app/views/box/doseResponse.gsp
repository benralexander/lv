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
<div id="cdtCmpTabs-3" class="cTab" style="padding-left: 00px;">
    <h3>Correlation plot</h3>

    <div id="cdtGeneCorrelationAnalysis">
        <table style='margin-top: 50px; border-top: 50px;'>
            <tr>
                <td id='correlationPlotLayout'>
                    <span id='plot'></span>
                </td>
                <td id='correlationPlotControllers'>
                    <div class='iqmLabel'>
                        "Interquartile multiplier"
                    </div>

                    <div id='slider'>
                    </div>

                    <div id='outlierRadiusDiv'>
                        <div class='outlierRadiusLabel'>Outlier radius:</div>

                        <form id='outlierRadius'>
                            <table class='options'>
                                <tr>
                                    <td>
                                        <input type='radio' name='outlierRadius' value='1'>tiny</input>
                                    </td>
                                    <td>
                                        <input type='radio' name='outlierRadius' value='2' checked>small</input>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type='radio' name='outlierRadius' value='4'>medium</input>
                                    </td>
                                    <td>
                                        <input type='radio' name='outlierRadius' value='6'>large</input>
                                    </td>
                                </tr>
                            </table>

                        </form>
                    </div>
                </td>
                <td style='margin-right: 0px;'>
                </td>
            </tr>
        </table>

        <div class='messagepop pop' id='examineCorrelation'>
            <table class='graphTable'>
                <tr>
                    <td>
                        <form method='post' id='new_message' action='/messages'>
                            <h1>Correlation plot</h1>

                            <div id='scatterPlot1'></div>

                            <p><a class='close' href='/'>Cancel</a></p>
                        </form>
                    </td>
                    <td>
                        <div id='doseResponseCurve'></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

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
        {
            curve_slope: null,
            cell_primary_name: "HS852T",
            inflection_point_lower_ci: null,
            curve_height: null,
            nominal_ec50: null,
            points: [
                {
                    cpd_pv_measured_value: 0.963315618068203,
                    cpd_pv_error: null,
                    pert_conc: 8.333300000000001
                },
                {
                    cpd_pv_measured_value: 1.02352754258068,
                    cpd_pv_error: null,
                    pert_conc: 0.521
                },
                {
                    cpd_pv_measured_value: 0.850163121198869,
                    cpd_pv_error: null,
                    pert_conc: 1.0417
                },
                {
                    cpd_pv_measured_value: 0.772913001782416,
                    cpd_pv_error: null,
                    pert_conc: 33.333
                },
                {
                    cpd_pv_measured_value: 0.942188732981274,
                    cpd_pv_error: null,
                    pert_conc: 4.1667000000000005
                },
                {
                    cpd_pv_measured_value: 0.820096102255203,
                    cpd_pv_error: null,
                    pert_conc: 2.0833
                },
                {
                    cpd_pv_measured_value: 0.823229778154418,
                    cpd_pv_error: null,
                    pert_conc: 16.667
                },
                {
                    cpd_pv_measured_value: 1.01048107121215,
                    cpd_pv_error: null,
                    pert_conc: 0.26033
                }
            ],
            cell_sample_id: 428,
            curve_baseline: null,
            perturbagen_name: "C-75",
            inflection_point_upper_ci: null,
            cpd_auc_12_point: null,
            auc_file_id: 106,
            cpd_auc_8_point: 6.3146,
            cpd_auc_full_range: null,
            perturbagen: "CCCCCCCCC1OC(=O)C(=C)C1C(O)=O",
            pv_predicted_value_last: null,
            curve_inflection_point: null,
            dataset_name: "Broad CTD2 (v1.3)",
            cpd_id: 594662
        }
        ,
        { cell_primary_name: 'OVCOR8',
            curve_baseline: 2.5,
            curve_height: 93.1,
            nominal_ec50: 26.0,
            curve_slope: -1.01,
          points:[
              {pert_conc: 1.5, cpd_pv_measured_value: 98.2, cpd_pv_error: 8},
              {pert_conc: 10.5, cpd_pv_measured_value: 50, cpd_pv_error: 4 },
              {pert_conc: 20.9, cpd_pv_measured_value: 4, cpd_pv_error: 2 },
              {pert_conc: 49.9, cpd_pv_measured_value: 1, cpd_pv_error: null}
           ]

           /*
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
                    yMinimum: null,
                    yMaximum: null,
                    inflection: null,
                    hillslope: null,
//            yMinimum: 0.5,
//            yMaximum: 89,
//            inflection: 25.0,
//            hillslope: -2.0,
                    elements:[
                        {x: 2.2, y: 98.2},
                        {x: 12.3, y: 60, dyp: 10.2, dyn: 20.2, dxp: 10.2, dxn: 12.2 },
                        {x: 19, y: 5, dxp: 10.2, dxn: 12.2 },
                        {x: 49.9, y: 2}
                    ]
                },
                { name: 'OVCOR8',
                    yMinimum: null,
                    yMaximum: null,
                    inflection: null,
                    hillslope: null,
//            yMinimum: 8.5,
//            yMaximum: 70.1,
//            inflection: 25.0,
//            hillslope: -1.0,
                    elements:[
                        {x: 1.5, y: 98.2},
                        {x: 10.5, y: 50 },
                        {x: 20.9, y: 4 },
                        {x: 49.9, y: 1}
//              {x: 1.5, y: 98.2},
//              {x: 10.5, y: 50, dyp: 10.2, dyn: 20.2 },
//              {x: 20.9, y: 4, dxp: 10.2, dxn: 12.2 },
//              {x: 49.9, y: 1, dyp: 18.2, dyn: 28.2}
                    ]
             */

        }
    ];

    var chart =  d3.doseResponse()
            .displayGridLines(false)
            .xAxisLabel('Concentration')
            .yAxisLabel('Response')
            .selectionIdentifier('body')
//            .x([0, 60])
//            .y([0, 150])
            .domainMultiplier(1.2);
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