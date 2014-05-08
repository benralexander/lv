(function() {
//
//    d3.heatmap = function() {
//
//        // the variables we intend to surface
//        var
//            width = 1,
//            height = 1,
//            selectionIdentifier = '',
//            data={},
//
//            // the variables that will never be exposed
//            instance={},
//            selection = {};
//
//
//
//
//
//
//        // assign data to the DOM
//        instance.assignData = function (x) {
//            if (!arguments.length) return data;
//            data = x;
//            selection
//                .selectAll("svg")
//                .data(data)
//                .enter()
//                .append("svg");
//            return instance;
//        };
//
//
//        // Now walk through the DOM and create the enrichment plot
//         instance.render=function (g) {
//
//             //  create the on screen display
//             selection
//                 .selectAll("svg")
//                 .attr("class", "enrichmentPlot")
//                 .attr("width", width)
//                 .attr("height", height)
//                 .append("g")
//                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");            //  create the on screen display
//
//             selection
//                 .selectAll("svg")
//            .each(function(d, i) {
//                d = d.sort(function(a, b) { return (b.point) - (a.point)});
//                var g = d3.select(this),
//                    n = d.length,
//                    w = width/ n,
//                minValue = d[0].point,
//                midValue = d[Math.floor(n/2)].point,
//                maxValue = d[n - 1].point;
//
//
//
//                //define a color scale using the min and max expression values
//                var colorScale = d3.scale.linear()
//                    .domain([minValue, midValue, maxValue])
//                    .range(["blue", "white", "red"]);
//
//                // Update innerquartile box.
//                var heatmap = g.selectAll(".heatmap")
//                    .data(d)
//                    .enter().append("svg:rect")
//                    .attr('width', w)
//                    .attr('height', 2*height/3)
//                    .attr('x', function(d,i) {
//                        return d.index * w;
//                    } )
//                    .attr('y',0)
//                    .attr('fill', function(d) {
//                        return colorScale(d.point);
//                    });
//
//                var featuremap = g.selectAll(".featuremap")
//                    .data(d)
//                    .enter().append("svg:rect")
//                    .filter (
//                    function(d,i) {
//                        return d.feature;//2*height/3
//                    }
//                   )
//                    .attr('width', function(d,i) {
//                        return d.point * w;
//                    } )
//                    .attr('height',  function(d,i) {
//                        return (2*height/3);//*d.feature;//2*height/3
//                    } )
//                    .attr('x', function(d,i) {
//                        return d.index * w;
//                    } )
//                    .attr('y',height/3)
//                    .attr('fill', "black")
//                    .attr('stroke', 'black');
//
//            });
//
//
//
//        };
//
//        instance.width = function(x) {
//            if (!arguments.length) return width;
//            width = x;
//            return instance;
//        };
//
//        instance.height = function(x) {
//            if (!arguments.length) return height;
//            height = x;
//            return instance;
//        };
//
//        instance.selectionIdentifier = function(x) {
//            if (!arguments.length) return selectionIdentifier;
//            selectionIdentifier = x;
//            selection = d3.select(selectionIdentifier);
//            return instance;
//        };
//
//
//        return instance;
//    };
//
//
//
//})();
