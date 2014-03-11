package cow

class BoxController {
    def dataInJsonForm = """
[
{
\t"Expt":1,
\t"Value": 0.850
},
{
\t"Expt":1,
\t"Value": 0.740
},
{
\t"Expt":1,
\t"Value": 0.900
},
{
\t"Expt":1,
\t"Value": 0.070
},
{
\t"Expt":1,
\t"Value": 0.30
},
{
\t"Expt":1,
\t"Value": 0.50
},
{
\t"Expt":1,
\t"Value": 0.50
},
{
\t"Expt":1,
\t"Value": 0.80
},
{
\t"Expt":1,
\t"Value": 0.80
},
{
\t"Expt":1,
\t"Value": 0.80
},
{
\t"Expt":1,
\t"Value": 1.000
},
{
\t"Expt":1,
\t"Value": 0.80
},
{
\t"Expt":1,
\t"Value": 0.30
},
{
\t"Expt":1,
\t"Value": -0.50
},
{
\t"Expt":1,
\t"Value": -0.60
},
{
\t"Expt":1,
\t"Value": -0.10
},
{
\t"Expt":1,
\t"Value": -0.30
},
{
\t"Expt":1,
\t"Value": -1.000
},
{
\t"Expt":1,
\t"Value": -0.960
},
{
\t"Expt":1,
\t"Value": -0.660
},
{
\t"Expt":2,
\t"Value": 0.960
},
{
\t"Expt":2,
\t"Value": -0.540
},
{
\t"Expt":2,
\t"Value": -0.260
},
{
\t"Expt":2,
\t"Value": -0.140
},
{
\t"Expt":2,
\t"Value": 0.80
},
{
\t"Expt":2,
\t"Value": 0.00
},
{
\t"Expt":2,
\t"Value": -0.50
},
{
\t"Expt":2,
\t"Value": 0.80
},
{
\t"Expt":2,
\t"Value": 0.200
},
{
\t"Expt":2,
\t"Value": 0.40
},
{
\t"Expt":2,
\t"Value": -0.30
},
{
\t"Expt":2,
\t"Value": 0.70
},
{
\t"Expt":2,
\t"Value": 0.30
},
{
\t"Expt":2,
\t"Value": 0.20
},
{
\t"Expt":2,
\t"Value": -0.30
},
{
\t"Expt":2,
\t"Value": -0.20
},
{
\t"Expt":2,
\t"Value": 0.00
},
{
"Expt":2,
"Value": 0.70
},
{
"Expt":2,
"Value": -0.60
},
{
"Expt":2,
"Value": 0.0800
},
{
"Expt":3,
"Value": -0.10
},
{
"Expt":3,
"Value": 0.10
},
{
"Expt":3,
"Value": 0.880
},
{
"Expt":3,
"Value": 0.860
},
{
"Expt":3,
"Value": 0.720
},
{
"Expt":3,
"Value": 0.720
},
{
"Expt":3,
"Value": 0.620
},
{
"Expt":3,
"Value": 0.860
},
{
"Expt":3,
"Value": 0.970
},
{
"Expt":3,
"Value": 0.950
},
{
"Expt":3,
"Value": 0.880
},
{
"Expt":3,
"Value": 0.910
},
{
"Expt":3,
"Value": 0.850
},
{
"Expt":3,
"Value": 0.870
},
{
"Expt":3,
"Value": 0.840
},
{
"Expt":3,
"Value": 0.840
},
{
"Expt":3,
"Value": 0.850
},
{
"Expt":3,
"Value": 0.840
},
{
"Expt":3,
"Value": 0.840
},
{
"Expt":3,
"Value": 0.840
}
]
"""

    def retrieveBoxData(){
        render(dataInJsonForm) ;
    }
    def retrieveData(){
        render('Hi') ;
    }

    def index() {
        render(view: 'boxwhisk')
    }
    def boxwhisker() {
        render(view:'boxwhisk')
    }
    def scatter() {
        render(view:'scatter')
    }

}
