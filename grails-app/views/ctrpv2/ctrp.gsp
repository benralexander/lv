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

    // make up some data
    var enrichData = [];
    for (var i = 0; i < 900; i++){
        enrichData.push({ index:i,
            point:(i<200)?(i/1900): (i/900),
            name:'MYC'+(i%100==0),
            link:'<a href=\'#\'>link</a>',
            feature:(i%100==0)?1:0});
    }
    // demonstrate that we can draw multiple enrichment plots simultaneously
    var enrichArray = [enrichData,enrichData,enrichData];

    // Where do you want your plot?
    var margin = {top: 200, right: 200, bottom: 100, left: 50},
            width = 420 - margin.left - margin.right,
            height = 450 - margin.top - margin.bottom;

    // create a placeholder, but don't assign any data yet
    var enrichmentPlot = d3.heatmap()
                  .width(width)
                  .height(height)
            .selection( d3.select("body").select("#newpickme").selectAll("svg"));

    var svg = enrichmentPlot.selection();


            svg.data(enrichArray)
            .enter().append("svg")
            .attr("class", "enrichmentPlot")
//            .attr("width", width + margin.left + margin.right)
//            .attr("height", height + margin.bottom + margin.top)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
            .call(enrichmentPlot.render);



</script>
</body>
</html>