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
    <script src="../js/jqgrid/jquery-ui-1.10.3.custom.min.js"></script>
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

        function AA(){
            $("#list2").jqGrid({
                url:'feedMeJson',
                datatype: "json",
                height: 255,
                width: 600,
                colNames:['ID','Date', 'Client','note', 'Amount','Tax','Total'],
                colModel:[
                    {name:'id',index:'id', width:55, sorttype:"int"},
                    {name:'invdate',index:'invdate', width:130, sorttype:"date"},
                    {name:'name',index:'name asc', width:100, sorttype:"string"},
                    {name:'note',index:'note', width:150, sortable:false},
                    {name:'amount',index:'amount', width:80, align:"right", sorttype:"float"},
                    {name:'tax',index:'tax', width:80, align:"right", sorttype:"float"},
                    {name:'total',index:'total', width:80,align:"right", sorttype:"float"}
                ],
                rowNum: 21,
                scroll:1,
                //rowTotal:2000,
                jsonReader: {
                    repeatitems : true,
                    cell:"",
                    id: "0"
                },
                scroll: 1,
                loadonce:true,
                mtype: "GET",
                rownumbers: true,
                rownumWidth: 40,
                 pager: '#pager2',
                sortname: 'id',
                viewrecords: true,
                sortorder: "asc",
                virtualscroll:"true",
                caption:""
            });
            //$("#list2").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false},{},{},{},{multipleSearch:true});
            $("#list2").jqGrid('navGrid','#pager2',  // Turn on the icons
                    {edit:true,
                        add:true,
                        del:true,
                        search:true,
                        refresh:true,
                        refreshstate:'current',
                        view:true
                    },
                    // Edit dialog parameters
                    {reloadAfterSubmit: false,
                        closeAfterEdit: true
                    },
                    // Add dialog parameters
                    {reloadAfterSubmit: true,
                        closeAfterAdd: true
                    },
                    // Delete dialog parameters
                    {reloadAfterSubmit: false},
                    // Search dialog parameters
                    {},
                    // View dialog parameters
                    {});
        }


                function AAA(){
                    $("#list2").jqGrid({
                        width: 600,
                        hoverrows: false,
                        viewrecords: true,
                        "jsonReader":{
                            "repeatitems":false,
                            "subgrid":
                            {"repeatitems":false}
                        },
                        "xmlReader":{"repeatitems":false,"subgrid":{"repeatitems":false}},
                        gridview: true,
                        url:'feedMeJson',
                        datatype: "json",
                        scroll: 1,
                        rowNum:50,
                        sortname: 'id',
                        height: 255,
                        colNames:['id','Date', 'Client','note', 'Amount','Tax','Total'],
                        colModel:[
                            {name:'id',index:'id', width:55},
                            {name:'invdate',index:'invdate', width:130},
                            {name:'name',index:'name asc, invdate', width:100},
                            {name:'note',index:'note', width:150, sortable:false},
                            {name:'amount',index:'amount', width:80, align:"right"},
                            {name:'tax',index:'tax', width:80, align:"right"},
                            {name:'total',index:'total', width:80,align:"right"}
                        ],
                        "postData":{"oper":"grid"},
                        "prmNames":{"page":"page","rows":"rows","sort":"sidx","order":"sord","search":"_search","nd":"nd","id":"id","filter":"filters","searchField":"searchField","searchOper":"searchOper","searchString":"searchString","oper":"oper","query":"grid","addoper":"add","editoper":"edit","deloper":"del","excel":"excel","subgrid":"subgrid","totalrows":"totalrows","autocomplete":"autocmpl"},
                        "loadError":function(xhr,status, err){
                            try {jQuery.jgrid.info_dialog(
                                     jQuery.jgrid.errors.errcap,'<div class="ui-state-error">'+ xhr.responseText +'</div>',
                                     jQuery.jgrid.edit.bClose,{buttonalign:'right'}
                            );}
                            catch(e) { alert(xhr.responseText);}
                        },
                        "pager":"#pager2",
                        caption:"s"
                    });
                    $("#list2").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false},{},{},{},{multipleSearch:true});
                }


    </script>
</head>

<body>
<h1> Oh boy, here is my new table!</h1>
<table id="list2"></table>
<div id="pager2"></div>
<script>
    $(document).ready(function() {
AAA();
    });
</script>

<h3> There it went – I hope that you saw it</h3>



</body>
</html>