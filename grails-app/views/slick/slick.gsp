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
    <style>
    .cell-story {
        white-space: normal !important;
        line-height: 19px !important;
    }

    .loading-indicator {
        display: inline-block;
        padding: 12px;
        background: white;
        -opacity: 0.5;
        color: black;
        font-weight: bold;
        z-index: 9999;
        border: 1px solid red;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        -moz-box-shadow: 0 0 5px red;
        -webkit-box-shadow: 0px 0px 5px red;
        -text-shadow: 1px 1px 1px white;
    }

    .loading-indicator label {
        padding-left: 20px;
        background: url('../images/ajax-loader-small.gif') no-repeat center left;
    }
    </style>
</head>
<body>

<div style="width:700px;float:left;">
    <div class="grid-header" style="width:100%">
        <label>Molecular spreadsheet</label>
        <span style="float:right;display:inline-block;">
            Search:
            <input type="text" id="txtSearch" value="github">
        </span>
    </div>
    <div id="myGrid" style="width:100%;height:600px;"></div>
    <div id="pager" style="width:100%;height:20px;"></div>
</div>
<div style="margin-left:750px;margin-top:40px;;">
</div>


<script src="../js/slick/lib/firebugx.js"></script>

<script src="../js/slick/lib/jquery-1.7.min.js"></script>
<script src="../js/slick/lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="../js/slick/lib/jquery.event.drag-2.2.js"></script>
<script src="../js/slick/lib/jquery.jsonp-2.4.min.js"></script>


<script src="../js/slick/slick.core.js"></script>
%{--<script src="../js/slick/slick.remotemodel.js"></script>--}%
<script src="../js/slick/slick.grid.js"></script>

<script>
    // describe the data model we maintain on the browser
    (function ($) {

        function RemoteModel() {
            // private
            var PAGESIZE = 50;
            var data = {length: 0};
            var searchstr = "";
            var sortcol = null;
            var sortdir = 1;
            var h_request = null;
            var req = null; // ajax request

            // events
            var onDataLoading = new Slick.Event();
            var onDataLoaded = new Slick.Event();


            function init() {
            }


            function isDataLoaded(from, to) {
                for (var i = from; i <= to; i++) {
                    if (data[i] == undefined || data[i] == null) {
                        return false;
                    }
                }

                return true;
            }


            function clear() {
                for (var key in data) {
                    delete data[key];
                }
                data.length = 0;
            }


            function ensureData(from, to) {
                if (req) {
                    req.abort();
                    // this next for loop makes no sense at all to me. I will commented out and see what happens
                    for (var i = req.fromPage; i <= req.toPage; i++)
                        data[i * PAGESIZE] = undefined;
                }

                if (from < 0) {
                    from = 0;
                }

                if (data.length > 0) {
                    to = Math.min(to, data.length - 1);
                }

                var fromPage = Math.floor(from / PAGESIZE);
                var toPage = Math.floor(to / PAGESIZE);

                while (data[fromPage * PAGESIZE] !== undefined && fromPage < toPage)
                    fromPage++;

                while (data[toPage * PAGESIZE] !== undefined && fromPage < toPage)
                    toPage--;

                console.log ('from ='+ from +', to ='+ to+', fromPage ='+ fromPage +', toPage ='+ toPage+'.');
                if (fromPage > toPage || ((fromPage == toPage) && data[fromPage * PAGESIZE] !== undefined)) {
                    // TODO:  look-ahead
                    console.log ('.');
                    onDataLoaded.notify({from: from, to: to});
                    return;
                }

                var url = "feedMeJson?sidx=1&sord=asc&page=" + (fromPage) + "&rows=" + (((toPage - fromPage) * PAGESIZE) + PAGESIZE);
                console.log ('making a round-trip to '+url+'.');


                if (sortcol != null) {
                    url += ("&sortby=" + sortcol + ((sortdir > 0) ? "+asc" : "+desc"));
                }

                if (h_request != null) {
                    clearTimeout(h_request);
                }

                h_request = setTimeout(function () {
                    for (var i = fromPage; i <= toPage; i++)
                        data[i * PAGESIZE] = null; // null indicates a 'requested but not available yet'

                    onDataLoading.notify({from: from, to: to});

                    req = $.getJSON(url,function(resp){
                                onSuccess(resp);
                            }
                    );
                    req.fromPage = fromPage;
                    req.toPage = toPage;
                }, 50);
            }


            function onError(fromPage, toPage) {
                alert("error loading pages " + fromPage + " to " + toPage);
            }

            // pull the information out of our Ajax return call and push it into 'data', which is our
            //  the externally visible variable we use for transfer.
            function onSuccess(resp) {
                var from = parseInt( resp.start);
                var to = from + parseInt( resp.length);
                // if you want to limit the number of records we handle, this is the place to do it
                // As an example:
                // data.length = Math.min(parseInt(resp.records),1000); // limitation of the API
                data.length = parseInt(resp.records);

                //  first element of array is  null . How can we fix this problem?
                for (var i = 0; i < resp.rows.length; i++) {
                    // Here are the pieces of information we will pass to the grid.
                    data[from+i] = { num:resp.rows[i].id,
                                     story:resp.rows[i].name,
                                     points:resp.rows[i].amount };
                    data[from+i].index = from+i;

                 }
                 req = null;

                onDataLoaded.notify({from: from, to: to});
            }


            function reloadData(from, to) {
                for (var i = from; i <= to; i++)
                    delete data[i];

                ensureData(from, to);
            }


            function setSort(column, dir) {
                sortcol = column;
                sortdir = dir;
                clear();
            }

            function setSearch(str) {
                searchstr = str;
                clear();
            }


            init();

            return {
                // properties
                "data": data,

                // methods
                "clear": clear,
                "isDataLoaded": isDataLoaded,
                "ensureData": ensureData,
                "reloadData": reloadData,
                "setSort": setSort,
                "setSearch": setSearch,

                // events
                "onDataLoading": onDataLoading,
                "onDataLoaded": onDataLoaded
            };
        }

        // Slick.Data.RemoteModel
        $.extend(true, window, { Slick: { Data: { RemoteModel: RemoteModel }}});
    })(jQuery);

</script>



<script>
    // control the data grid on the browser, dependent on the underlying model
    var grid;
    var loader = new Slick.Data.RemoteModel();

    var storyTitleFormatter = function (row, cell, value, columnDef, dataContext) {
//        s ="<b><a href='" + dataContext["url"] + "' target=_blank>" +
//                dataContext["title"] + "</a></b><br/>";
//        desc = dataContext["text"];
//        if (desc) { // on Hackernews many stories don't have a description
//            s += desc;
//        }
//        return s;
        return dataContext.story;
    };

    var dateFormatter = function (row, cell, value, columnDef, dataContext) {
        return (value.getMonth()+1) + "/" + value.getDate() + "/" + value.getFullYear();
    };

    // the names specified by the field named 'field'  must match  those provided in the
    //  variable 'data' in the remoteModel portion of the code (look for the onSuccess method)
    var columns = [
        {id: "num", name: "ID", field: "num", width: 40},
        {id: "story", name: "Promiscuity", width: 520, formatter: storyTitleFormatter, cssClass: "cell-story"},
//        {id: "date", name: "Date", field: "create_ts", width: 60, formatter: dateFormatter, sortable: true},
        {id: "points", name: "Points", field: "points", width: 60, sortable: true}
    ];

    var options = {
        rowHeight: 64,
        editable: false,
        enableAddRow: false,
        enableCellNavigation: false
    };

    var loadingIndicator = null;
    var data = [] ;

    $(function () {
        grid = new Slick.Grid("#myGrid", loader.data, columns, options);

        grid.onViewportChanged.subscribe(function (e, args) {
            var vp = grid.getViewport();
            loader.ensureData(vp.top, vp.bottom);
        });

        grid.onSort.subscribe(function (e, args) {
            loader.setSort(args.sortCol.field, args.sortAsc ? 1 : -1);
            var vp = grid.getViewport();
            loader.ensureData(vp.top, vp.bottom);
        });

        loader.onDataLoading.subscribe(function () {
            if (!loadingIndicator) {
                loadingIndicator = $("<span class='loading-indicator'><label>Buffering...</label></span>").appendTo(document.body);
                var $g = $("#myGrid");

                loadingIndicator
                        .css("position", "absolute")
                        .css("top", $g.position().top + $g.height() / 2 - loadingIndicator.height() / 2)
                        .css("left", $g.position().left + $g.width() / 2 - loadingIndicator.width() / 2);
            }

            loadingIndicator.show();
        });

        loader.onDataLoaded.subscribe(function (e, args) {
            for (var i = args.from; i <= args.to; i++) {
                grid.invalidateRow(i);
            }

            grid.updateRowCount();
            grid.render();

            loadingIndicator.fadeOut();
        });

        $("#txtSearch").keyup(function (e) {
            if (e.which == 13) {
                loader.setSearch($(this).val());
                var vp = grid.getViewport();
                loader.ensureData(vp.top, vp.bottom);
            }
        });

        loader.setSearch($("#txtSearch").val());
        loader.setSort("create_ts", -1);
        grid.setSortColumn("date", false);

        // load the first page
        grid.onViewportChanged.notify();
    })
</script>







%{--<script>--}%
    %{--var grid;--}%
    %{--var columns = [--}%
        %{--{id: "title", name: "Title", field: "title"},--}%
        %{--{id: "duration", name: "Duration", field: "duration"},--}%
        %{--{id: "%", name: "% Complete", field: "percentComplete"},--}%
        %{--{id: "start", name: "Start", field: "start"},--}%
        %{--{id: "finish", name: "Finish", field: "finish"},--}%
        %{--{id: "effort-driven", name: "Effort Driven", field: "effortDriven"}--}%
    %{--];--}%

    %{--var options = {--}%
        %{--enableCellNavigation: true,--}%
        %{--enableColumnReorder: false--}%
    %{--};--}%

    %{--$(function () {--}%
        %{--var data = [];--}%
        %{--for (var i = 0; i < 500; i++) {--}%
            %{--data[i] = {--}%
                %{--title: "Task " + i,--}%
                %{--duration: "5 days",--}%
                %{--percentComplete: Math.round(Math.random() * 100),--}%
                %{--start: "01/01/2009",--}%
                %{--finish: "01/05/2009",--}%
                %{--effortDriven: (i % 5 == 0)--}%
            %{--};--}%
        %{--}--}%

        %{--grid = new Slick.Grid("#myGrid", data, columns, options);--}%
    %{--})--}%
%{--</script>--}%
</body>
</html>