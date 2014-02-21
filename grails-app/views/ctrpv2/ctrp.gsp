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

    <script src="../js/d3.js"></script>
    <script src="../js/enrichment.js"></script>
    <script src="../js/enrichmentPlot.js"></script>
</head>
<body>
  <h1>Enrichment plot</h1>
  <div class="heatmap"></div>
 <div class="featuremap"></div>
<div id="pickme"></div>
<h4>Now let's try again</h4>
<div id="newpickme"></div>
<script>
    console.log('hello');
    var values = [];
    for (var i = 0; i < 900; i++){
        if (i<100){
            values[i] = i/1900;
        } else {
            values[i] = i/900;
        }

    }
    var ccl = {'name':'MYC','link':'<a href=\'#\'>link</a>'}
    var features = [];

    for (var i = 0; i < 900; i++){
        features.push({'name':'MYC'+(i%100==0),'link':'<a href=\'#\'>link</a>'});
    }
    // old way
    addEnrichmentPlot('#pickme',200,200,values,features,0,0.5,1);

    // new way
    var margin = {top: 200, right: 200, bottom: 300, left: 50},
            width = 420 - margin.left - margin.right,
            height = 800 - margin.top - margin.bottom;

    var enrichmentPlot = d3.heatmap()
                  .width(width)
                  .height(height);

    var enrichData = [];
    for (var i=0;i<values.length;i++) {
        enrichData.push({point:values[i],
                        feature:features[i]?1:0});
    }
    var enrichArray = [enrichData,enrichData,enrichData];

    var svg = d3.select("body").select("#newpickme").selectAll("svg")
            .data(enrichArray)
            .enter().append("svg")
            .attr("class", "enrichmentPlot")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.bottom + margin.top)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
            .call(enrichmentPlot);



</script>
</body>
</html>