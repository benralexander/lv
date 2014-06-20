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
        {geneFeatureValue:5.1,
            cellSampleID: 14,
            cpdAUC:3.5,
            cellName:'CALU3',
            sitePrimary:'colon'
        },
        {geneFeatureValue:4.9,
            cellSampleID: 14,
            cpdAUC:3.0,
            cellName:'CALU3',
            sitePrimary:'colon'
        },
        {geneFeatureValue:4.2,
            cellSampleID: 14,
            cpdAUC:3.2,
            cellName:'CALU3',
            sitePrimary:'lung'
        },
        {geneFeatureValue:4.4,
            cellSampleID: 14,
            cpdAUC:3.7,
            cellName:'CALU3',
            sitePrimary:'lung'
        },
        {geneFeatureValue:5.0,
            cellSampleID: 14,
            cpdAUC:3.6,
            cellName:'CALU3',
            sitePrimary:''
        },
        {geneFeatureValue:4.5,
            cellSampleID: 14,
            cpdAUC:3.8,
            cellName:'CALU3',
            sitePrimary:'endometrium'
        },
        {geneFeatureValue:4.4,
            cellSampleID: 14,
            cpdAUC:3.1,
            cellName:'CALU3',
            sitePrimary:'endometrium'
        },
        {geneFeatureValue:4.9,
            cellSampleID: 14,
            cpdAUC:3.3,
            cellName:'CALU3',
            sitePrimary:'endometrium'
        }
    ];


    cbbo.scatterPlot()
            .selectionIdentifier("#scatterPlot1")
            .width (width)
            .height (height)
            .margin(margin)
            .xAxisLabel ('Navitoclax AUC')
            .yAxisLabel ('BCL2 expression level')
            .assignData (data)
            .xAxisDataAccessor (function (d){return  d.cpdAUC ;})
            .yAxisDataAccessor (function (d){return  d.geneFeatureValue ;})
            .colorByDataAccessor (function (d){return  d.sitePrimary;})
            .render() ;


    cbbo.scatterPlot()
            .selectionIdentifier("#scatterPlot2")
            .width (width)
            .height (height)
            .margin(margin)
            .assignData (data)
            .xAxisDataAccessor (function (d){return  d.cpdAUC ;})
            .yAxisDataAccessor (function (d){return  d.geneFeatureValue ;})
            .colorByDataAccessor (function (d){return  d.sitePrimary;})
            .render() ;


</script>

</body>
</html>