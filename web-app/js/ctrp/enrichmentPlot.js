(function() {

    d3.heatmap = function() {

        // the variables we intend to surface
        var
            width = 1,
            height = 1,
            selectionIdentifier = '',
            data={},

            // the variables that will never be exposed
            instance={},
            selection = {};

        //  private variable
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function (d) {
             //   var nodeData = d3.select(this.parentNode).datum()[d];
                return "<strong><div style='color:black'>CCL: " + d.name+ "<br/>Lineage: " + d.line+ "</div></strong> ";
//                return "<strong></strong> <span style='color:red'>" + nodeData.description + "</span>";
            });




        // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            selection
                .selectAll("svg")
                .data(data)
                .enter()
                .append("svg")
                .call(tip);
            return instance;
        };


        // Now walk through the DOM and create the enrichment plot
         instance.render=function (g) {

             //  create the on screen display
             selection
                 .selectAll("svg")
                 .attr("class", "enrichmentPlot")
                 .attr("width", width)
                 .attr("height", height)
                 .append("g")
                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");            //  create the on screen display

             selection
                 .selectAll("svg")
            .each(function(d, i) {
                d = d.sort(function(a, b) { return (b.value) - (a.value)});
                var g = d3.select(this),
                    n = d.length,
                    w = width/ n,
                minValue = d[0].value,
                midValue = d[Math.floor(n/2)].value,
                maxValue = d[n - 1].value;



                //define a color scale using the min and max expression values
                var colorScale = d3.scale.linear()
                    .domain([minValue, midValue, maxValue])
                    .range(["blue", "white", "red"]);

                // Here is the colorful part of the heat map
                var heatmap = g.selectAll(".heatmap")
                    .data(d)
                    .enter().append("svg:rect")
                    .on('mouseover', tip.show)
                    .on('mouseout', tip.hide)
                    .attr('width', w)
                    .attr('height', 2*height/3)
                    .attr('x', function(d,i) {
                        return d.index * w;
                    } )
                    .attr('y',0)
                    .attr('fill', function(d) {
                        return colorScale(d.value);
                    });

                // Here is the indicator that the feature under consideration
                //   is present in this cell line
                var featuremap = g.selectAll(".featuremap")
                    .data(d)
                    .enter().append("svg:rect")
                    .filter (
                    function(d,i) {
                        return d.featureExists;
                    }
                   )
                    .attr('width', function(d,i) {
                        return d.value * w;
                    } )
                    .attr('height',  function(d,i) {
                        return (height/2);
                    } )
                    .attr('x', function(d,i) {
                        return d.index * w;
                    } )
                    .on('mouseover', tip.show)
                    .on('mouseout', tip.hide)
                    .attr('y',height/3)
                    .attr('fill', "black")
                    .attr('stroke', 'black');

            });



        };

        instance.width = function(x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function(x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        instance.selectionIdentifier = function(x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };


        return instance;
    };



})();
