<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 12/6/13
  Time: 10:35 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>


    <title>jqgrid</title>
    <script src="../js/bardHomepage/jquery-1.8.3.min.js"></script>
    <script src="../js/jqgrid/jquery.jqGrid.src.js"></script>
    <script src="../js/jqgrid/grid.locale-en.js"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'ui.jqgrid.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'jquery-ui.css')}" />

    <style>
        /*this override doesn't work'*/
    /*input .ui-jqgrid {*/
        /*height: 20px;*/
    /*}*/
    </style>
    <script>
        function A(){
            $("#list2").jqGrid({
                url:'feedMeJson',
                datatype: "json",
                colNames:['ID','Date', 'Client','note', 'Amount','Tax','Total'],
                colModel:[
                    {name:'id',index:'id', width:55},
                    {name:'invdate',index:'invdate', width:130},
                    {name:'name',index:'name asc, invdate', width:100},
                    {name:'note',index:'note', width:150, sortable:false},
                    {name:'amount',index:'amount', width:80, align:"right"},
                    {name:'tax',index:'tax', width:80, align:"right"},
                    {name:'total',index:'total', width:80,align:"right"}
                ],
                rowNum:10,
//                rowTotal:10,
//                scroll: 1,
//                loadonce:true,
                rowList:[5,10],
                pager: '#pager2',
                sortname: 'id',
                width: "100%",
                height: 200,
                viewrecords: true,
                sortorder: "desc",
                caption:"JSON Example"
            });
            $("#list2").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false});
        }
    </script>
</head>

<body>
<h1> Oh boy, here is my new table!</h1>
<table id="list2"></table>
<div id="pager2"></div>
<script>
    console.log('a');
A();
    console.log('b');
</script>

<h3> There it went – I hope that you saw it</h3>



</body>
</html>