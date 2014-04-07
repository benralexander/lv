<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Array as Data</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>
<body>
<link media="all" rel="stylesheet" href="../css/ctrp/scatter.css">
<script src="../js/d3.js"></script>
<script src="../js/ctrp/scatter.js"></script>
<script src="../js/ctrp/d3tooltip.js"></script>
<div id="scatterPlot1"></div>
<div id="scatterPlot2"></div>
<script>

    var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 600 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

    data = [
        {mrna_expression:5.1,
            cpd_auc:3.5,
            primary_site:['colon']
//             lineage:'colon'
        },
        {mrna_expression:4.9,
            cpd_auc:3.0,
            primary_site:['colon']
//             lineage:'colon'
        },
        {mrna_expression:4.2,
            cpd_auc:3.2,
            primary_site:['lung']
//             lineage:'lung'
        },
        {mrna_expression:4.4,
            cpd_auc:3.7,
            primary_site:['lung']
//             lineage:'lung'
        },
        {mrna_expression:5.0,
            cpd_auc:3.6,
            primary_site:[]
//             lineage:'endometrium'
        },
        {mrna_expression:4.5,
            cpd_auc:3.8,
            primary_site:['endometrium']
 //            lineage:'endometrium'
        },
        {mrna_expression:4.4,
            cpd_auc:3.1,
            primary_site:['endometrium']
 //            lineage:'endometrium'
        },
        {mrna_expression:4.9,
            cpd_auc:3.3,
            primary_site:['endometrium']
//            lineage:'endometrium'
        }
    ];


    ScatterPlotHolder().scatterPlot()
            .selectionIdentifier("#scatterPlot1")
            .width (width)
            .height (height)
            .margin(margin)
            .xAxisLabel ('Navitoclax AUC')
            .yAxisLabel ('BCL2 expression level')
            .assignData (data)
            .render() ;


    ScatterPlotHolder().scatterPlot()
            .selectionIdentifier("#scatterPlot2")
            .width (width)
            .height (height)
            .margin(margin)
            .assignData (data)
            .render() ;


</script>

</body>
</html>