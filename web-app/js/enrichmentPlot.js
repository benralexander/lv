(function() {

// Inspired by http://informationandvisualization.de/blog/box-plot
    d3.heatmap = function() {
        var width = 1,
            height = 1,
            values = [],
            hasFeature = [],
            minValue = 1,
            midValue = 1,
            maxValue = 1,
            duration = 0,
            domain = null,
            value = Number;

        // For each small multiple…
        function heatmap(g) {
            g.each(function(d, i) {
//                d = d.map(value).sort(d3.ascending);
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
                        return i * w;
                    } )
                    .attr('y',0)
                    .attr('fill', function(d) {
                        return colorScale(d.point);
                    });

                var featuremap = g.selectAll(".featuremap")
                    .data(d)
                    .enter().append("svg:rect")
                    .attr('width', function(d,i) {
                        return d.point * w;
                    } )
                    .attr('height', 2*height/3)
                    .attr('x', function(d,i) {
                        return i * w;
                    } )
                    .attr('y',height/3)
                    .attr('fill', "black")
                    .attr('stroke', 'white');

            });

        }
        heatmap.width = function(x) {
            if (!arguments.length) return width;
            width = x;
            return heatmap;
        };

        heatmap.height = function(x) {
            if (!arguments.length) return height;
            height = x;
            return heatmap;
        };

        heatmap.minValue = function(x) {
            if (!arguments.length) return minValue;
            minValue = x;
            return heatmap;
        };

         return heatmap;
    };

//    function boxWhiskers(d) {
//        return [0, d.length - 1];
//    }


})();
