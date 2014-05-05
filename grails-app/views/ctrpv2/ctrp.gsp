<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 2/13/14
  Time: 12:26 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>ctrp test</title>
    <link media="all" rel="stylesheet" href="../css/ctrp/enrichmentPlot.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/d3tooltip.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/doseResponse.css">
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/ctrp/enrichmentPlot.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
    <script src="../js/ctrp/doseResponse.js"></script>
    <script src="../js/ctrp/jquery-1.9.1.js"></script>
    <style>
    .toolTextAppearance {
        font: 20px serif;
        font-weight: bold;
        margin: 5px;
        padding: 10px;
        background: #eeeeee;
        border: 1px solid blue;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }

    </style>
</head>
<body>
<h1>Enrichment plot</h1>
<h1>Enrichment plot</h1>
  <div class="heatmap"></div>
  <div class="featuremap"></div>
<table border="1" style="margin:10px;">
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot1"></div>
        </td>
    </tr>
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot2"></div>
        </td>
    </tr>
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot3"></div>
        </td>
    </tr>
</table>
<script>

    // make up some data
    var enrichData = [];
    var fakeData = [
        {ccl:'1321N1',lineage:'central nervous system'},
        {ccl:'22Rv1',lineage:'prostate'},
        {ccl:'23132/87',lineage:'stomach'},
        {ccl:'253J',lineage:'urinary tract'},
        {ccl:'1321N1',lineage:'urinary tract'},
        {ccl:'143B',lineage:'bone'}
    ];



    ///    Each data array described the data associated with a single feature/compound combination. We should
    //      probably have the feature in combination available for display as needed.
    var numberOfBars = 9;
   for (var i = 0; i < numberOfBars; i++) {
        ///  Each data element needs to hold:
        ///    Cancer cell line name
        ///    AUC value
        ///    + A way to get to the underlying growth curve.  URL? Parameters?
        enrichData.push({ index: i,
            value:  (((i / numberOfBars)-0.5)), // AUC value
            name: fakeData [(i % fakeData.length)].ccl,  //   CCL name
            line: fakeData [(i % fakeData.length)].lineage, // Name of lineage
            link: '<a href=\'#\'>Parameter number ' +i +'</a>', // Parameter (?) get the data for this growth curve
            featureExists: (i % 3 == 0) ? 1 : 0});
    }
    // demonstrate that we can draw multiple enrichment plots simultaneously
    //var enrichArray = [enrichData, enrichData];
  //  var enrichArray = [enrichData];
    var dataForEnrichmentHeatMap1 = {
        featureName:'PDE4DIP',
        compoundName:'parbendazole',
        enrichmentData:[enrichData]
    }

    var dataForEnrichmentHeatMap2 = {
        featureName:'IGFBP5',
        compoundName:'4-methylfasudil',
        enrichmentData:[enrichData]
    }


    /***
     * Sample JSON data:
     {
     featureName:'PDE4DIP',
     compoundName:'parbendazole',
     enrichmentData:[
     {
        value:0.11,
        name:'1321N1',
        line:'central nervous system',
        link: ----not sure about this yet---,
        featureExists:1
     },
     {
        value:0.13,
        name:'22Rv1',
        line:'prostate',
        link: ----not sure about this yet---,
        featureExists:0
     }
     ]
     */


    /***
     * Realistic data: */

var realdata= {
     featureName:'STK11',
     compoundName:'10-DEBChe',
     enrichmentData:[[
     {
        featureExists:0,
        index: 0,
        line: 'lung',
        link: '#no-link',
        name:'T3M10',
        value:5.6399
     },
         {
             featureExists:0,
             index: 1,
             line: 'lung',
             link: '#no-link',
             name:'HCC2935',
             value:5.8119000000000005
         },
         {
             featureExists:1,
             index: 2,
             line: 'lung',
             link: '#no-link',
             name:'HCC4006',
             value:5.8377
         },
         {
             featureExists:0,
             index: 3,
             line: 'lung',
             link: '#no-link',
             name:'SKLU1',
             value:6.0929

         },
         {
             featureExists:true,
             index: 4,
             line: 'lung',
             link: '#no-link',
             name:'CAL12T',
             value:6.1115
         },
         {
             featureExists:0,
             index: 5,
             line: 'lung',
             link: '#no-link',
             name:'T3M10',
             value:6.2096
         },
         {
             featureExists:0,
             index: 6,
             line: 'endometrium',
             link: '#no-link',
             name:'JHUEM2',
             value:6.28780000000000
         },
         {
             featureExists:1,
             index: 7,
             line: 'lung',
             link: '#no-link',
             name:'HCC2108',
             value:6.365
         },
         {
             featureExists:0,
             index: 8,
             line: 'lung',
             link: '#no-link',
             name:'HCC1833',
             value:6.365200000000001
         },
         {
             featureExists:0,
             index: 9,
             line: 'lung',
             link: '#no-link',
             name:'HCC827',
             value:6.423
         },
         {
             featureExists:0,
             index: 10,
             line: 'lung',
             link: '#no-link',
             name:'SQ1',
             value:6.4381
         },
         {
             featureExists:0,
             index: 11,
             line: 'lung',
             link: '#no-link',
             name:'HCC1195',
             value:6.500500000000001
         },
         {
             featureExists:0,
             index: 12,
             line: 'lung',
             link: '#no-link',
             name:'HCC1359',
             value:6.6662
         },
         {
             featureExists:0,
             index: 13,
             line: 'lung',
             link: '#no-link',
             name:'CORL23',
             value:7.216200000000001
         }
     ]]
    };







    // Where do you want your plot?
    var margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom,

    // create a  heatmap and populate it with data
    heatMap = d3.heatmap()
            .selectionIdentifier("#eplot1")
            .width(width + margin.left + margin.right)
            .height(height + margin.bottom + margin.top)
            .assignData(realdata);
    heatMap.render();
//
//    // create a  heatmap and populate it with data
//    d3.heatmap()
//            .selectionIdentifier("#eplot2")
//            .width(width + margin.left + margin.right)
//            .height(height + margin.bottom + margin.top)
//            .assignData(dataForEnrichmentHeatMap2)
//            .render();
//
//
//    // create a  heatmap and populate it with data.
//    d3.heatmap()
//            .selectionIdentifier("#eplot3")
//            .width(width + margin.left + margin.right)
//            .height(height + margin.bottom + margin.top)
//            .assignData(dataForEnrichmentHeatMap1)
//            .render();
//


</script>
</body>
</html>