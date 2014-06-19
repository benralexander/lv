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
        {"geneFeatureValue":5.1,
            "cellSampleID": 14,
            "cpdAUC":3.5,
            "cellName":"CALU3",
            "sitePrimary":"colon"
        },
        {"geneFeatureValue":4.9,
            "cellSampleID": 14,
            "cpdAUC":3.0,
            "cellName":"CALU3",
            "sitePrimary":"colon"
        },
        {"geneFeatureValue":4.2,
            "cellSampleID": 14,
            "cpdAUC":3.2,
            "cellName":"CALU3",
            "sitePrimary":"lung"
        },
        {"geneFeatureValue":4.4,
            "cellSampleID": 14,
            "cpdAUC":3.7,
            "cellName":"CALU3",
            "sitePrimary":"lung"
        },
        {"geneFeatureValue":5.0,
            "cellSampleID": 14,
            "cpdAUC":3.6,
            "cellName":"CALU3",
            "sitePrimary":""
        },
        {"geneFeatureValue":4.5,
            "cellSampleID": 14,
            "cpdAUC":3.8,
            "cellName":"CALU3",
            "sitePrimary":"endometrium"
        },
        {"geneFeatureValue":4.4,
            "cellSampleID": 14,
            "cpdAUC":3.1,
            "cellName":"CALU3",
            "sitePrimary":"endometrium"
        },
        {"geneFeatureValue":4.9,
            "cellSampleID": 14,
            "cpdAUC":3.3,
            "cellName":"CALU3",
            "sitePrimary":"endometrium"
        }
    ]
}"""




    def doseResponseData = """
        {
            "curveInflectionPoint": 1.0914,
            "inflectionPointUpperCI": 29.035,
            "curveBaseline": 0.2156,
            "curveSlope": -0.10978,
            "maxConcAUC08": 36.8,
            "cpdAUC": 3.3268,
            "curveHeight": 0.62897,
            "pvPoint": [
                {
                    "pvError": 0.11172,
                    "pv": 0.963065667456791,
                    "cpdConc": 0.0011254
                },
                {
                    "pvError": 0.11172,
                    "pv": 1.0861674195306,
                    "cpdConc": 0.0022508
                },
                {
                    "pvError": 0.11172,
                    "pv": 1.0125526695726,
                    "cpdConc": 0.0045016
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.961082107912598,
                    "cpdConc": 0.0090032
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.778476091025291,
                    "cpdConc": 0.018005999999999998
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.948958726025352,
                    "cpdConc": 0.036012999999999996
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.745154528467278,
                    "cpdConc": 0.07202599999999999
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.574434720322612,
                    "cpdConc": 0.14404999999999998
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.604261596569457,
                    "cpdConc": 0.2881
                },
                {
                    "pvError": 0.11171,
                    "pv": 0.771532402217735,
                    "cpdConc": 0.5762
                },
                {
                    "pvError": null,
                    "pv": 0.52585186554098,
                    "cpdConc": 1.1524
                },
                {
                    "pvError": 1.1346,
                    "pv": 0.382398860349926,
                    "cpdConc": 2.3048
                },
                {
                    "pvError": 0.18215,
                    "pv": 0.176171960892228,
                    "cpdConc": 4.6096
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.243164629820139,
                    "cpdConc": 9.2193
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.168381244537229,
                    "cpdConc": 18.439
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.274036081054617,
                    "cpdConc": 36.877
                }
            ],
            "nominalEC50": 2.1308,
            "pvPredValueLast": 0.2156,
            "inflectionPointLowerCI": -26.852,
            "concUnit": "uM"
        }   """


    def retrieveBoxData(){
        render(dataInJsonForm) ;
    }
    def correlationPoints(){
        render(correlationInJsonForm.toString()) ;
    }
    def doseResponsePoints(){
        render(doseResponseData.toString()) ;
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
