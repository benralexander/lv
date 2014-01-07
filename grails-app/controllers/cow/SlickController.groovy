package cow

class SlickController {
    static int TOTAL_NUMBER_SIMULATED_RECORDS = 2000

    BackendSimulatorService backendSimulatorService

    String simulatedRecord( int requestedStart,
                            int requestedEnd
                      //      String indexName,
                      //      String direction // "asc" Or "desc"
                           ){

        String returnValue = """
{
  "start": "${requestedStart}",
  "end": "${requestedEnd}",
  "records": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "rows" :[
""".toString()
        returnValue +=  backendSimulatorService.simulatedRows( requestedStart,
                requestedEnd-requestedStart,
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
        String stringRequestedStart = params.start ?: "0" // get the requested page
        String stringRequestedEnd = params.end ?: "25" // get how many rows we want to have in the grid
        String indexRow = params.sortby ?: "id"// get index row name
        String direction = params.sord ?: "desc" // get the direction
        Integer requestedPage, rowsWeWant,requestedStart,requestedEnd
        try  {
            requestedStart = Integer.parseInt(stringRequestedStart)
            requestedEnd = Integer.parseInt(stringRequestedEnd)
        }  catch (Exception exception) {
            println "whoops – bad parameter"
        }
        String proposedJson = simulatedRecord( requestedStart,requestedEnd)
        render  proposedJson
    }
}
