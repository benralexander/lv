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
    }

}
