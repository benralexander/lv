<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 1/17/14
  Time: 11:05 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">

    <title>Functional Javascript</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<script type="text/javascript">
    function SimpleWidget(spec) {
        var instance = {}; // <-- A

        var headline, description; // <-- B

        instance.render = function () {
            var div = d3.select('body').append("div");

            div.append("h3").text(headline); // <-- C

            div.attr("class", "box")
                    .attr("style", "color:" + spec.color) // <-- D
                    .append("p")
                    .text(description); // <-- E

            return instance; // <-- F
        };

        instance.headline = function (h) {
            if (!arguments.length) return headline; // <-- G
            headline = h;
            return instance; // <-- H
        };

        instance.description = function (d) {
            if (!arguments.length)  description;
            description = d;
            return instance;
        };

        return instance; // <-- I
    }

    var widget = SimpleWidget({color: "#6495ed"})
            .headline("Simple Widget")
            .description("This is a simple widget demonstrating functional javascript.");
    widget.render();
</script>

</body>
</html>
