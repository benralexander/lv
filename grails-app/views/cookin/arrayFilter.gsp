<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Data Filter</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

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

    function render(data, category) {
        d3.select("body").selectAll("div.h-bar") // <-B
                .data(data)
                .enter()
                .append("div")
                .attr("class", "h-bar")
                .append("span");

        d3.select("body").selectAll("div.h-bar") // <-C
                .data(data)
                .exit().remove();

        d3.select("body").selectAll("div.h-bar") // <-D
                .data(data)
                .attr("class", "h-bar")
                .style("width", function (d) {
                    return (d.expense * 5) + "px";}
        )
                .select("span")
                .text(function (d) {
                    return d.category;
                });

        d3.select("body").selectAll("div.h-bar")
                .filter(function (d, i) { // <-E
                    return d.category == category;
                })
                .classed("selected", true);
    }

    render(data);

    function select(category) {
        render(data, category);
    }
</script>

<div class="control-group">
    <button onclick="select('Retail')">
        Retail
    </button>
    <button onclick="select('Gas')">
        Gas
    </button>
    <button onclick="select('Dining')">
        Dining
    </button>
    <button onclick="select()">
        Clear
    </button>
</div>

</body>

</html>