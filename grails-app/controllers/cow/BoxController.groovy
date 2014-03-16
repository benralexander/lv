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
\t"Value": 1.070
},
{
\t"Expt":1,
\t"Value": 0.930
},
{
\t"Expt":1,
\t"Value": 0.850
},
{
\t"Expt":1,
\t"Value": 0.950
},
{
\t"Expt":1,
\t"Value": 0.980
},
{
\t"Expt":1,
\t"Value": 0.980
},
{
\t"Expt":1,
\t"Value": 0.880
},
{
\t"Expt":1,
\t"Value": 1.000
},
{
\t"Expt":1,
\t"Value": 0.980
},
{
\t"Expt":1,
\t"Value": 0.930
},
{
\t"Expt":1,
\t"Value": 0.650
},
{
\t"Expt":1,
\t"Value": 0.760
},
{
\t"Expt":1,
\t"Value": 0.810
},
{
\t"Expt":1,
\t"Value": 1.000
},
{
\t"Expt":1,
\t"Value": 1.000
},
{
\t"Expt":1,
\t"Value": 0.960
},
{
\t"Expt":1,
\t"Value": 0.960
},
{
\t"Expt":2,
\t"Value": 0.960
},
{
\t"Expt":2,
\t"Value": 0.940
},
{
\t"Expt":2,
\t"Value": 0.960
},
{
\t"Expt":2,
\t"Value": 0.940
},
{
\t"Expt":2,
\t"Value": 0.880
},
{
\t"Expt":2,
\t"Value": 0.800
},
{
\t"Expt":2,
\t"Value": 0.850
},
{
\t"Expt":2,
\t"Value": 0.880
},
{
\t"Expt":2,
\t"Value": 0.900
},
{
\t"Expt":2,
\t"Value": 0.840
},
{
\t"Expt":2,
\t"Value": 0.830
},
{
\t"Expt":2,
\t"Value": 0.790
},
{
\t"Expt":2,
\t"Value": 0.810
},
{
\t"Expt":2,
\t"Value": 0.880
},
{
\t"Expt":2,
\t"Value": 0.880
},
{
\t"Expt":2,
\t"Value": 0.830
},
{
\t"Expt":2,
\t"Value": 0.800
},
{
"Expt":2,
"Value": 0.790
},
{
"Expt":2,
"Value": 0.760
},
{
"Expt":2,
"Value": 0.800
},
{
"Expt":3,
"Value": 0.880
},
{
"Expt":3,
"Value": 0.880
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
    def doseResponse() {
        render(view:'doseResponse')
    }

}
