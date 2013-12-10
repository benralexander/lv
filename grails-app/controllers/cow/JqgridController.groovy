package cow

import junit.framework.Assert

class JqgridController {
    Random random = new Random()
    static int TOTAL_NUMBER_SIMULATED_RECORDS = 2000


    String rn (int smallest,int biggest) {
        int rawRandom = random.nextInt(biggest-smallest)
        if (smallest > biggest) {
            println "smallest > biggest.  What were you thinking?"
            Assert  (smallest <= biggest)
        }
        int rawWithRangeRestriction =  (rawRandom%(biggest-smallest)) +  smallest
        return  rawWithRangeRestriction.toString()
    }


    String simulatedRows(int firstIndex,
                         int requestedPage,
                         int numberRowsRequested) {
        StringBuilder stringBuilder = new StringBuilder();
        int indexCounter = firstIndex
        for (int i = 0; i < numberRowsRequested; i++) {
            if ((firstIndex+i) < TOTAL_NUMBER_SIMULATED_RECORDS) {
                String temporaryDate = "${rn(2000, 2012)}-${rn(1, 12)}-${rn(1, 12)}"
                stringBuilder << "{\"id\":\"${indexCounter++}\",\"invdate\":\"${temporaryDate}\",\"name\":\"test${rn(0, 9)}\",\"note\":\"note${rn(0, 3)}\",\"amount\":\"${rn(1, 400)}.${rn(0, 99)}\",\"tax\":\"${rn(1, 10)}.00\",\"total\":\"210.00\"}"
                if (((i + 1) < numberRowsRequested)&&
                        ((firstIndex+i+1) < TOTAL_NUMBER_SIMULATED_RECORDS)){
                    stringBuilder << ","
                }
            }
        }
        return stringBuilder.toString()
    }

    String simulatedRecord(int requestedPage,
                           int numberRowsRequested){
        //// "${TOTAL_NUMBER_SIMULATED_RECORDS/numberRowsRequested}"
       // "total":        //  total pages for the query
       // "page":   // current page of the query
       // "records":    // total number of records for the query
       // "rows" :[   // an array that contains the actual data

        String returnValue = """
{
  "total": "66",
  "page": "${requestedPage}",
  "records": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "rows" :[
""".toString()
        returnValue +=  simulatedRows( ((requestedPage*numberRowsRequested)-numberRowsRequested)+1,
                 requestedPage,
                 numberRowsRequested )
        returnValue +=  """]
    }""".toString()
        return returnValue
    }



    def index() {
        render(view: 'jqgrid')
    }
    def jqgrid() { }
    def feedMeJson(){
      //  sleep(1000)
        String stringRequestedPage = params.page ?: "1" // get the requested page
        String stringRowsWeWant = params.rows ?: "1" // get how many rows we want to have in the grid
        String indexRow = params.sidx ?: "id"// get index row name
        String direction = params.sord ?: "desc" // get the direction
        Integer requestedPage, rowsWeWant
        try  {
            requestedPage = Integer.parseInt(stringRequestedPage)
            rowsWeWant = Integer.parseInt(stringRowsWeWant)
        }  catch (Exception exception) {
            println "whoops – bad parameter"
        }
        String proposedJson = simulatedRecord( requestedPage,rowsWeWant)
        render  proposedJson
//        if (requestedPage==1){
//            render("""
//{
//  "total": "20",
//  "page": "1",
//  "records": "10",
//  "rows" :[
//{"id":"1","invdate":"2007-10-01","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"2","invdate":"2007-10-02","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"3","invdate":"2007-09-01","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
//{"id":"4","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"5","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"6","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
//{"id":"7","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"8","invdate":"2007-10-03","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"9","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"10","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"}]
//}""".toString())
//
//        } else {
//        render("""
//{
//  "total": "20",
//  "page": "2",
//  "records": "10",
//  "rows" :[
//{"id":"11","invdate":"2007-10-01","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"12","invdate":"2007-10-02","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"13","invdate":"2007-09-01","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
//{"id":"14","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"15","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"16","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"},
//{"id":"17","invdate":"2007-10-04","name":"test","note":"note","amount":"200.00","tax":"10.00","total":"210.00"},
//{"id":"18","invdate":"2007-10-03","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"19","invdate":"2007-10-05","name":"test2","note":"note2","amount":"300.00","tax":"20.00","total":"320.00"},
//{"id":"20","invdate":"2007-09-06","name":"test3","note":"note3","amount":"400.00","tax":"30.00","total":"430.00"}
//]
//}""".toString())
//    }
    }

}
