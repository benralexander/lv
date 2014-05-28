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
//        {
//            curve_slope: null,
//            cell_primary_name: "HS852T",
//            inflection_point_lower_ci: null,
//            curve_height: null,
//            nominal_ec50: null,
//            points: [
//                {
//                    cpd_pv_measured_value: 0.963315618068203,
//                    cpd_pv_error: null,
//                    pert_conc: 8.333300000000001
//                },
//                {
//                    cpd_pv_measured_value: 1.02352754258068,
//                    cpd_pv_error: null,
//                    pert_conc: 0.521
//                },
//                {
//                    cpd_pv_measured_value: 0.850163121198869,
//                    cpd_pv_error: null,
//                    pert_conc: 1.0417
//                },
//                {
//                    cpd_pv_measured_value: 0.772913001782416,
//                    cpd_pv_error: null,
//                    pert_conc: 33.333
//                },
//                {
//                    cpd_pv_measured_value: 0.942188732981274,
//                    cpd_pv_error: null,
//                    pert_conc: 4.1667000000000005
//                },
//                {
//                    cpd_pv_measured_value: 0.820096102255203,
//                    cpd_pv_error: null,
//                    pert_conc: 2.0833
//                },
//                {
//                    cpd_pv_measured_value: 0.823229778154418,
//                    cpd_pv_error: null,
//                    pert_conc: 16.667
//                },
//                {
//                    cpd_pv_measured_value: 1.01048107121215,
//                    cpd_pv_error: null,
//                    pert_conc: 0.26033
//                }
//            ],
//            cell_sample_id: 428,
//            curve_baseline: null,
//            perturbagen_name: "C-75",
//            inflection_point_upper_ci: null,
//            cpd_auc_12_point: null,
//            auc_file_id: 106,
//            cpd_auc_8_point: 6.3146,
//            cpd_auc_full_range: null,
//            perturbagen: "CCCCCCCCC1OC(=O)C(=C)C1C(O)=O",
//            pv_predicted_value_last: null,
//            curve_inflection_point: null,
//            dataset_name: "Broad CTD2 (v1.3)",
//            cpd_id: 594662
//        }
//        ,
        { cell_primary_name: 'OVCOR8',
            curve_baseline: 0.1688,
            curve_height: 0.94283,
            nominal_ec50: 0.5798,
            curve_slope: -1.401,
            points:[
                {cpd_pv_error: 0.1318,
                    cpd_pv_measured_value: 0.324434474079502,
                    pert_conc: 4.6096
                },
                {
                    cpd_pv_error: 0.16274,
                    cpd_pv_measured_value: 0.545953173554408,
                    pert_conc: 0.5762
                },
                {
                    cpd_pv_error: 0.16288,
                    cpd_pv_measured_value: 1.19459763383528,
                    pert_conc: 0.14404999999999998
                }, {
                    cpd_pv_error: 0.16404,
                    cpd_pv_measured_value: 0.149170758931566,
                    pert_conc: 18.439
                }, {
                    cpd_pv_error: 0.14105,
                    cpd_pv_measured_value: 1.08706946062705,
                    pert_conc: 0.0011254
                }, {
                    cpd_pv_error: 0.19055,
                    cpd_pv_measured_value: 0.0668850140667255,
                    pert_conc: 36.877
                }, {
                    cpd_pv_error: 0.13658,
                    cpd_pv_measured_value: 1.05569766581735,
                    pert_conc: 0.0022508
                }, {
                    cpd_pv_error: 0.13569,
                    cpd_pv_measured_value: 0.290083305298151,
                    pert_conc: 9.2193
                }, {
                    cpd_pv_error: 0.1758,
                    cpd_pv_measured_value: 0.435199909443407,
                    pert_conc: 1.1524
                }, {
                    cpd_pv_error: 0.13312,
                    cpd_pv_measured_value: 1.0630196586361,
                    pert_conc: 0.07202599999999999
                }, {
                    cpd_pv_error: 0.10862,
                    cpd_pv_measured_value: 1.1742602289787,
                    pert_conc: 0.036012999999999996
                }, {
                    cpd_pv_error: 0.10774,
                    cpd_pv_measured_value: 1.00368884863886,
                    pert_conc: 0.018005999999999998
                }, {
                    cpd_pv_error: 0.11862,
                    cpd_pv_measured_value: 1.05802786878813,
                    pert_conc: 0.0090032
                }, {
                    cpd_pv_error: 0.16129,
                    cpd_pv_measured_value: 0.51925804315052,
                    pert_conc: 2.3048
                }, {
                    cpd_pv_error: 0.16677,
                    cpd_pv_measured_value: 0.577750380861931,
                    pert_conc: 0.2881
                }, {
                    cpd_pv_error: 0.12924,
                    cpd_pv_measured_value: 1.11152987671054,
                    pert_conc: 0.0045016}
            ]
        }
    ];


    var chart =  d3.doseResponse()
            .displayGridLines(false)
            .xAxisLabel('log Concentration')
            .yAxisLabel('Response')
            .selectionIdentifier('body')
            .title('this is my title')
            .width(400)
            .autoScale(false)
            .areaUnderTheCurve ([5,13]) // Shade points 5 - 13
            //.domainMultiplier(1.2)    only used if autoscale==true
            .x(d3.scale.log().base(2).domain([0.001, 40]))
            .y(d3.scale.linear().domain([0,1.5]));

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