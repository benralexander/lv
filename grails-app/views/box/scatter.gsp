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
        {yValue:5.1,
            xValue:3.5,
            lineage:'colon'
        },
        {yValue:4.9,
            xValue:3.0,
            lineage:'colon'
        },
        {yValue:4.7,
            xValue:3.2,
            lineage:'lung'
        },
        {yValue:4.4,
            xValue:3.7,
            lineage:'lung'
        },
        {yValue:5.0,
            xValue:3.6,
            lineage:'endometrium'
        },
        {yValue:4.5,
            xValue:3.8,
            lineage:'endometrium'
        },
        {yValue:4.4,
            xValue:3.1,
            lineage:'endometrium'
        },
        {yValue:4.9,
            xValue:3.3,
            lineage:'endometrium'
        }
    ];


    d3.scatterPlot()
            .selectionIdentifier("#scatterPlot1")
            .width (width)
            .height (height)
            .margin(margin)
            .xAxisLabel ('Navitoclax AUC')
            .yAxisLabel ('BCL2 expression level')
            .assignData (data)
            .render() ;


    d3.scatterPlot()
            .selectionIdentifier("#scatterPlot2")
            .width (width)
            .height (height)
            .margin(margin)
            .assignData (data)
            .render() ;


</script>

</body>
</html>