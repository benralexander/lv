(function () {
    d3.slider = function () {
        var instance = {},
            sliderWidth = 500,
            responseToSliderEvent = defaultSliderEvent;

        instance.render = function () {

            var x = d3.scale.linear()
                .domain([0, 2])
                .range([0, sliderWidth])
                .clamp(true);

            var brush = d3.svg.brush()
                .x(x)
                .extent([sliderWidth, sliderWidth])
                .on("brush", brushed);

            var svg = d3.select("#slider").append("svg")
                .attr("width", margin.width)
                .attr("height", margin.height)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height / 2 + ")")
                .call(d3.svg.axis()
                    .scale(x)
                    .orient("bottom")
                    .tickFormat(function (d) {
                        return d + "°";
                    })
                    .tickSize(0)
                    .tickPadding(12))
                .select(".domain")
                .select(function () {
                    return this.parentNode.appendChild(this.cloneNode(true));
                })
                .attr("class", "halo");

            var slider = svg.append("g")
                .attr("class", "slider")
                .call(brush);

            slider.selectAll(".extent,.resize")
                .remove();

            slider.select(".background")
                .attr("height", height);

            var handle = slider.append("circle")
                .attr("class", "handle")
                .attr("transform", "translate(0," + height / 2 + ")")
                .attr("r", 9);

            slider.call(brush.event);
        }


        instance.responseToSliderEvent = function (x) {
            if (!arguments.length) return responseToSliderEvent;
            responseToSliderEvent = x;
            return instance;
        };


        instance.width = function (x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };


    };

    function defaultSliderEvent(value) {
        return;
    }


    function brushed() {
        var value = brush.extent()[0];

        if (d3.event.sourceEvent) { // not a programmatic event
            value = x.invert(d3.mouse(this)[0]);
            brush.extent([value, value]);
        }
        handle.attr("cx", x(value));
        if (!isNaN(value)) {
            interquartileMultiplier = value;
            chart.whiskers(iqr(interquartileMultiplier)).render();
        }
    }

})();

