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
</head>
<body>
  <h1>Enrichment plot</h1>
  <div class="heatmap"></div>
 <div class="featuremap"></div>
<div id="pickme"></div>
<script>
    console.log('hello');
    var values = [];
    for (var i = 0; i < 200; i++){
        if (i<100){
            values[i] = i/500;
        } else {
            values[i] = i/200;
        }

    }
    var features = [];
    for (var i = 0; i < 200; i++){
        features[i] = (i%20==0);
    }
     addEnrichmentPlot('#pickme',200,200,values,features,0,0.5,1);
 </script>
</body>
</html>