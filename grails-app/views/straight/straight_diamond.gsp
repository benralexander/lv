
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ui tests</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'cow.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'styles.css')}" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="http://d3js.org/d3.v3.min.js"></script>
    <script src="../js/d3.min.js"></script>
    <script src="../js/dc.js"></script>
    <script src="../js/crossfilter.min.js"></script>
</head>
<body>

<div id="chart"></div>

<script type="text/javascript">
    var data = [ // <-A
        {expense: 10, category: "Retail"},
        {expense: 15, category: "Gas"},
        {expense: 30, category: "Retail"},
        {expense: 50, category: "Dining"},
        {expense: 80, category: "Gas"},
        {expense: 65, category: "Retail"},
        {expense: 55, category: "Gas"},
        {expense: 30, category: "Dining"},
        {expense: 20, category: "Retail"},
        {expense: 10, category: "Dining"},
        {expense: 8, category: "Gas"}
    ];

    function render(data) {
        d3.select("#chart").selectAll("div.h-bar") // <-B
                .data(data)
                .enter().append("div")
                .attr("class", "h-bar")
                .append("span");

        d3.select("#chart").selectAll("div.h-bar") // <-C
                .data(data)
                .exit().remove();

        d3.select("#chart").selectAll("div.h-bar") // <-D
                .data(data)
                .attr("class", "h-bar")
                .style("width", function (d) {
                    return (d.expense * 5) + "px";
                })
                .select("span")
                .text(function (d) {
                    return d.category;
                });
    }

    render(data);

    function load(){ // <-E
        d3.json("http://localhost:8028/cow/straight/feedMeJson", function(error, json){ // <-F
            data = data.concat(json);
            render(data);
        });
    }
</script>

<div class="control-group">
    <button onclick="load()">Load Data from JSON feed</button>
</div>

</body>
</html>