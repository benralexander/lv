package cow

class VeryCrossController {

    def index() {
        render(view: 'very_cross')
    }
    def very_cross() { }
    def feedMeJson(){
render ("""[
    {
        "assayId": "25",
        "data": {
            "GO_biological_process_term": "none",
            "assay_format": "cell-free format",
            "assay_type": "fluorescence quenching assay"
        }
    },
    {
        "assayId": "26",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "27",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0015485",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "28",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0008219",
            "assay_format": "cell-based format",
            "assay_type": "toxicity assay"
        }
    },
    {
        "assayId": "29",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "30",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0004998",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "31",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "32",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "33",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "34",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "35",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "36",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "37",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "38",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0015485",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "39",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "40",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "41",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0033344",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "43",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "44",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    },
    {
        "assayId": "45",
        "data": {
            "GO_biological_process_term": "http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=0070508",
            "assay_format": "cell-based format",
            "assay_type": "transporter assay"
        }
    }
]""")
    }

}
