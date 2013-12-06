package cow

class JqgridController {

    def index() {
//        String stringRequestedPage = params.page ?: "1" // get the requested page
//        String stringRowsWeWant = params.rows ?: "1" // get how many rows we want to have into the grid
//        String stringIndexRow = params.sidx ?: "1"// get index row - i.e. user click to sort
//        String stringDirection = params.sord ?: "1" // get the direction
//        Integer requestedPage, rowsWeWant, indexRow, direction
//        try  {
//            requestedPage = Integer.parseInt(stringRequestedPage)
//            rowsWeWant = Integer.parseInt(stringRowsWeWant)
//            indexRow = Integer.parseInt(stringIndexRow)
//            direction = Integer.parseInt(stringDirection)
//        }  catch (Exception exception) {
//            println "whoops – bad parameter"
//        }
        render(view: 'jqgrid')
    }
    def jqgrid() { }
    def feedMeJson(){
        String stringRequestedPage = params.page ?: "1" // get the requested page
        String stringRowsWeWant = params.rows ?: "1" // get how many rows we want to have into the grid
        String indexRow = params.sidx ?: "id"// get index row name
        String direction = params.sord ?: "desc" // get the direction
        Integer requestedPage, rowsWeWant
        try  {
            requestedPage = Integer.parseInt(stringRequestedPage)
            rowsWeWant = Integer.parseInt(stringRowsWeWant)
        }  catch (Exception exception) {
            println "whoops – bad parameter"
        }
        if (requestedPage==1){
            render("""
{
  "total": "20",
  "page": "1",
  "records": "10",
  "rows" :[
{"id":"1","invdate":"2007-10-01","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"2","invdate":"2007-10-02","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"3","invdate":"2007-09-01","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
{"id":"4","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"5","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"6","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
{"id":"7","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"8","invdate":"2007-10-03","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"9","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"10","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"}]
}""".toString())

        } else {
        render("""
{
  "total": "20",
  "page": "2",
  "records": "10",
  "rows" :[
{"id":"11","invdate":"2007-10-01","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"12","invdate":"2007-10-02","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"13","invdate":"2007-09-01","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
{"id":"14","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"15","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"16","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
{"id":"17","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
{"id":"18","invdate":"2007-10-03","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"19","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
{"id":"20","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"}
]
}""".toString())
    }
    }

}
