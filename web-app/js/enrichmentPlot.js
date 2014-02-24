(function() {

// Inspired by http://informationandvisualization.de/blog/box-plot
    d3.heatmap = function() {
        var instance={},
            width = 1,
            height = 1,
            minValue = 1,
            midValue = 1,
            maxValue = 1,
            selection = {},
            data={};

//        var svg = d3.select("body").select("#newpickme").selectAll("svg")
//            .data(enrichArray)
//            .enter().append("svg")
//            .attr("class", "enrichmentPlot")
////            .attr("width", width + margin.left + margin.right)
////            .attr("height", height + margin.bottom + margin.top)
//            .append("g")
//            .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
//            .call(enrichmentPlot.render);

        instance.assignment = function (data) {
            selection.data(data)
                .enter().append("svg");
            return instance;
        };


        // For each small multiple…
         instance.render=function (g) {
            g.each(function(d, i) {
                d = d.sort(function(a, b) { return (b.point) - (a.point)});
                var g = d3.select(this),
                    n = d.length,
                    w = width/n;
                minValue = d[0].point;
                midValue = d[Math.floor(n/2)].point;
                maxValue = d[n - 1].point;



                //define a color scale using the min and max expression values
                var colorScale = d3.scale.linear()
                    .domain([minValue, midValue, maxValue])
                    .range(["blue", "white", "red"]);

                // Update innerquartile box.
                var heatmap = g.selectAll(".heatmap")
                    .data(d)
                    .enter().append("svg:rect")
                    .attr('width', w)
                    .attr('height', 2*height/3)
                    .attr('x', function(d,i) {
                        return d.index * w;
                    } )
                    .attr('y',0)
                    .attr('fill', function(d) {
                        return colorScale(d.point);
                    });

                var featuremap = g.selectAll(".featuremap")
                    .data(d)
                    .enter().append("svg:rect")
                    .filter (
                    function(d,i) {
                        return d.feature;//2*height/3
                    }
                   )
                    .attr('width', function(d,i) {
                        return d.point * w;
                    } )
                    .attr('height',  function(d,i) {
                        return (2*height/3);//*d.feature;//2*height/3
                    } )
                    .attr('x', function(d,i) {
                        return d.index * w;
                    } )
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

        instance.minValue = function(x) {
            if (!arguments.length) return minValue;
            minValue = x;
            return instance;
        };

        instance.selection = function(x) {
            if (!arguments.length) return selection;
            selection = x;
            return instance;
        };


        return instance;
    };



})();
