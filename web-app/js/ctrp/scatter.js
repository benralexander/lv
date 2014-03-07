(function() {

    d3.scatter = function() {

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
                var textToPresent = "";
                var textColor = '#000000';
                if (d){
                        textToPresent = "Howdy ";
                     }
                return "<strong><span style='color:'#ccc'>" +textToPresent+ "</span></strong> ";
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

            x.domain(d3.extent(data, function(d) { return d.xValue; })).nice();
            y.domain(d3.extent(data, function(d) { return d.yValue; })).nice();

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis)
                .append("text")
                .attr("class", "label")
                .attr("x", width)
                .attr("y", -6)
                .style("text-anchor", "end")
                .text("Navitoclax AUC");

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("class", "label")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("BCL2 expression level")

            svg.selectAll(".dot")
                .data(data)
                .enter().append("circle")
                .attr("class", "dot")
                .attr("r", 3.5)
                .attr("cx", function(d) { return x(d.xValue); })
                .attr("cy", function(d) { return y(d.yValue); })
                .style("fill", function(d) { return color(d.lineage); });

            var legend = svg.selectAll(".legend")
                .data(color.domain())
                .enter().append("g")
                .attr("class", "legend")
                .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

            legend.append("rect")
                .attr("x", width - 18)
                .attr("width", 18)
                .attr("height", 18)
                .style("fill", color);

            legend.append("text")
                .attr("x", width - 24)
                .attr("y", 9)
                .attr("dy", ".35em")
                .style("text-anchor", "end")
                .text(function(d) { return d; });

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

//        // May alternatively be passed in through initial Json data assignment
//        instance.featureName = function(x) {
//            if (!arguments.length) return featureName;
//            featureName = x;
//            return instance;
//        };
//
//        // May alternatively be passed in through initial Json data assignment
//        instance.compoundName = function(x) {
//            if (!arguments.length) return compoundName;
//            compoundName = x;
//            return instance;
//        };

        instance.selectionIdentifier = function(x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };


        return instance;
    };



})();