package cow

class CurvedForceController {

    def index() {
        render(view: 'curvedForce')
    }
    def  curvedForce ()  {}
    def feedMeJson(){
        render (  """
[{
"source":"Harry",
"target":"Sally",
"value":1.2
},
{
"source":"Harry",
"target":"Mario",
"value":1.3
},
{
"source":"Peter",
"target":"Johan",
"value":0.7
}]""")  }


//    Sarah,Alice,0.2
//    Eveie,Alice,0.5
//    Peter,Alice,1.6
//    Mario,Alice,0.4
//    James,Alice,0.6
//    Harry,Carol,0.7
//    Harry,Nicky,0.8
//    Bobby,Frank,0.8
//    Alice,Mario,0.7
//    Harry,Lynne,0.5
//    Sarah,James,1.9
//    Roger,James,1.1
//    Maddy,James,0.3
//    Sonny,Roger,0.5
//    James,Roger,1.5
//    Alice,Peter,1.1
//    Johan,Peter,1.6
//    Alice,Eveie,0.5
//    Harry,Eveie,0.1
//    Eveie,Harry,2.0
//    Henry,Mikey,0.4
//    Elric,Mikey,0.6
//    James,Sarah,1.5
//    Alice,Sarah,0.6
//    James,Maddy,0.5
}
