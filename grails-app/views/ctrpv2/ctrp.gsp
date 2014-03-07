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
    <script src="../js/d3.js"></script>
    <script src="../js/ctrp/enrichmentPlot.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
    <style>
        .tooltip{

        }
    </style>
</head>
<body>
  <h1>Enrichment plot</h1>
  <div class="heatmap"></div>
 <div class="featuremap"></div>
<div id="pickme"></div>
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
   for (var i = 0; i < 900; i++) {
        ///  Each data element needs to hold:
        ///    Cancer cell line name
        ///    AUC value
        ///    + A way to get to the underlying growth curve.  URL? Parameters?
        enrichData.push({ index: i,
            value: (i < 200) ? (i / 1900) : (i / 900), // AUC value
            name: fakeData [(i % fakeData.length)].ccl,  //   CCL name
            line: fakeData [(i % fakeData.length)].lineage, // Name of lineage
            link: '<a href=\'#\'>Parameter number ' +i +'</a>', // Parameter (?) get the data for this growth curve
            featureExists: (i % 100 == 0) ? 1 : 0});
    }
    // demonstrate that we can draw multiple enrichment plots simultaneously
    //var enrichArray = [enrichData, enrichData];
  //  var enrichArray = [enrichData];
    var dataForEnrichmentHeatMap = {
        featureName:'PDE4DIP',
        compoundName:'parbendazole',
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

    // Where do you want your plot?
    var margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom;

    // create a placeholder, but don't assign any data yet
    var enrichmentPlot = d3.heatmap()
            .selectionIdentifier("#pickme")
            .width(width + margin.left + margin.right)
            .height(height + margin.bottom + margin.top)
            .assignData(dataForEnrichmentHeatMap)
            .render();


</script>
</body>
</html>