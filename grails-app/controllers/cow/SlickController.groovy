package cow

import junit.framework.Assert

class SlickController {
    static int TOTAL_NUMBER_SIMULATED_RECORDS = 2000

    BackendSimulatorService backendSimulatorService

    String simulatedRecord(int requestedPage,
                           int numberRowsRequested){
        String returnValue = """
{
  "start": "${requestedPage*numberRowsRequested}",
  "end": "${numberRowsRequested}",
  "records": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "rows" :[
""".toString()
        returnValue +=  backendSimulatorService.simulatedRows( (requestedPage*numberRowsRequested)+1,
                numberRowsRequested,
                TOTAL_NUMBER_SIMULATED_RECORDS  )
        returnValue +=  """]
    }""".toString()
        return returnValue


    }


    def index() {
        render(view: 'slick')
    }
    def slick() { }
    def feedMeJson(){
        //  sleep(1000)
        String stringRequestedPage = params.page ?: "1" // get the requested page
        String stringRowsWeWant = params.rows ?: "1" // get how many rows we want to have in the grid
        String stringRequestedStart = params.start ?: "0" // get the requested page
        String stringRequestedEnd = params.end ?: "25" // get how many rows we want to have in the grid
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
