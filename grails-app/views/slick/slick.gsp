<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 12/31/13
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>SlickGrid example 1: Basic grid</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick', file: 'slick.grid.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick/smoothness', file: 'jquery-ui-1.8.16.custom.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick', file: 'examples.css')}" />

</head>
<body>
<table width="100%">
    <tr>
        <td valign="top" width="50%">
            <div id="myGrid" style="width:600px;height:500px;"></div>
        </td>
        <td valign="top">
            <h2>Demonstrates:</h2>
            <ul>
                <li>basic grid with minimal configuration</li>
            </ul>
            <h2>View Source:</h2>
            <ul>
                <li><A href="https://github.com/mleibman/SlickGrid/blob/gh-pages/examples/example1-simple.html" target="_sourcewindow"> View the source for this example on Github</a></li>
            </ul>
        </td>
    </tr>
</table>
<script src="../js/slick/lib/jquery-1.7.min.js"></script>
<script src="../js/slick/lib/jquery.event.drag-2.2.js"></script>
<script src="../js/slick/slick.core.js"></script>
<script src="../js/slick/slick.grid.js"></script>
<script>
    var grid;
    var columns = [
        {id: "title", name: "Title", field: "title"},
        {id: "duration", name: "Duration", field: "duration"},
        {id: "%", name: "% Complete", field: "percentComplete"},
        {id: "start", name: "Start", field: "start"},
        {id: "finish", name: "Finish", field: "finish"},
        {id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
    ];

    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false
    };

    $(function () {
        var data = [];
        for (var i = 0; i < 500; i++) {
            data[i] = {
                title: "Task " + i,
                duration: "5 days",
                percentComplete: Math.round(Math.random() * 100),
                start: "01/01/2009",
                finish: "01/05/2009",
                effortDriven: (i % 5 == 0)
            };
        }

        grid = new Slick.Grid("#myGrid", data, columns, options);
    })
</script>
</body>
</html>