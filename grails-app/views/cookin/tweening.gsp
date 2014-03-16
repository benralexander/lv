<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Tweening</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<script type="text/javascript">
    var body = d3.select("body"), duration = 5000;
    
    body.append("div").append("input")
        .attr("type", "button")
        .attr("class", "countdown")
        .attr("value", "0")
        .style("width", "150px")
        .transition().duration(duration)//.ease("cubic-in-out")
            .style("width", "400px")
            .attr("value", "9");
            
    body.append("div").append("input")
        .attr("type", "button")
        .attr("class", "countdown")
        .attr("value", "0")
        .transition().duration(duration).ease("cubic-in-out")
            .styleTween("width", widthTween) // <- A
            .attrTween("value", valueTween); // <- B
            
            
    function widthTween(a){
        var interpolate = d3.scale.quantize()
            .domain([0, 1])
            .range([150, 200, 250, 1000, 400]);
        
        return function(t){
            return interpolate(t) + "px";
        };
    }
            
    function valueTween(){
        var interpolate = d3.scale.quantize() // <-C
            .domain([0, 1])
            .range([1, 2, 3, 4, 5, 6, 7, 'dd', 9]);
        
        return function(t){ // <-D
            return interpolate(t);
        };
    }        
</script>

</body>

</html>