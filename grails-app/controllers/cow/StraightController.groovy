package cow

class StraightController {

    def index()  {
        render(view: 'straight_diamond')
    }
    def straight_diamond() { }
    def feedMeJson(){
        render("""[
{
"expense": 15,
"category": "Retail"
},
{
"expense": 18,
"category": "Gas"
},
{
"expense": 10,
"category": "Retail"
},
{
"expense": 25,
"category": "Gas"
},
{
"expense": 66,
"category": "Retail"
},
{
"expense": 70,
"category": "Gas"
},
{
"expense": 44,
"category": "Dining"
},
{
"expense": 13,
"category": "Dining"
},
{
"expense": 20,
"category": "Dining"
},
{
"expense": 12,
"category": "Retail"
},
{
"expense": 15,
"category": "Gas"
}
]""".toString())
    }
}
