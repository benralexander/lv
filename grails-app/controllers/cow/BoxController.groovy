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
    def correlationInJsonForm = """
{
    "results": [
    {
        "value": 6.7829559999999995,
        "cpd_auc": 6.2818000000000005,
        "cell_sample_id": 985,
        "primary_site": ["RMUGS"]
    },
    {
        "value": 5.991586,
        "cpd_auc": 7.4305,
        "cell_sample_id": 299,
        "primary_site": ["HCC1359"]
    },
    {
        "value": 5.8883,
        "cpd_auc": 6.8716,
        "cell_sample_id": 1133,
        "primary_site": ["SNUC4"]
    },
    {
        "value": 6.118193,
        "cpd_auc": 6.983300000000001,
        "cell_sample_id": 536,
        "primary_site": ["KM12"]
    },
    {
        "value": 6.527301,
        "cpd_auc": 7.7155000000000005,
        "cell_sample_id": 759,
        "primary_site": ["NCIH1755"]
    }
]
}"""

    def retrieveBoxData(){
        render(dataInJsonForm) ;
    }
    def correlationPoints(){
        render(correlationInJsonForm) ;
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
