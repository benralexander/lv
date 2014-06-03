/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 6/2/14
 * Time: 6:46 AM
 * To change this template use File | Settings | File Templates.
 */

package cbbo.ctrp

import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.web.json.JSONArray

class RunDataGeneration {

    final String serverLocation = "http://chembio-lx.broadinstitute.org:3311/"
    Random random = new Random()


    private String generateFilename(String restApiCall,String directoryForFile, Date callStarted) {
        String fileName = restApiCall.replaceAll("[\\/&=]", ".");
        if (fileName.startsWith("."))
            fileName = fileName.replaceFirst(".", "");
        if (!fileName.endsWith("."))
            fileName += ".";

        // append elapsed time to end of name
        Date currentDate = new Date();
        fileName += ((currentDate.getTime() - callStarted.getTime()) + "ms" + ".");
        String filePath = System.getProperty("user.home") + System.getProperty("file.separator");
        if (directoryForFile != null) {
            filePath += (directoryForFile + System.getProperty("file.separator"));
        }
        return (filePath + fileName + "txt");
    }




    private void writeValuesToFile(String fileName,
                                   String parameterSummary,
                                   String returnFromApi) {
        try {
            File file = new File(fileName);

            // we have the file name.  now fill it up.  Headers go first, the the Json we received from the API
            file.createNewFile();
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(parameterSummary);
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write(returnFromApi);
            fileWriter.flush();
            fileWriter.close();
        } catch (Exception e) {
            System.out.print("problem writing output from " + restApiCall + ".");
            e.printStackTrace();
        }
    }





    private void writeRawJsonToFile(String directoryForFile,
                                    String restApiCall,
                                    String parameterSummary,
                                    Date callStarted,
                                    String returnFromApi) {
        String fileName = generateFilename(restApiCall, directoryForFile, callStarted)
        writeValuesToFile(fileName,
                parameterSummary,
                returnFromApi)
    }



    private void returnValuesToFile(String directoryForFile,
                                    String restApiCall,
                                    String parameterSummary,
                                    Date callStarted,
                                    JSONArray jsonArray
    ) {
        try {
            // concoct the filename out of the URL we are given.
            String fileName = restApiCall.replaceAll("[\\/&=]", ".");
            if (fileName.startsWith("."))
                fileName = fileName.replaceFirst(".", "");
            if (!fileName.endsWith("."))
                fileName += ".";

            // append elapsed time to end of name
            Date currentDate = new Date();
            fileName += ((currentDate.getTime() - callStarted.getTime()) + "ms" + ".");
            String filePath = System.getProperty("user.home") + System.getProperty("file.separator");
            if (directoryForFile != null) {
                filePath += (directoryForFile + System.getProperty("file.separator"));
            }
            File file = new File(filePath + fileName + "txt");

            // we have the file name.  now fill it up.  Headers go first, the the Json we received from the API
            file.createNewFile();
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(parameterSummary);
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write(jsonArray.toString());
            fileWriter.flush();
            fileWriter.close();
        } catch (Exception e) {
            System.out.print("problem writing output from " + restApiCall + ".");
            e.printStackTrace();
        }
    }







    static boolean executePost(String cid) {
        URL url = new URL("http://chembio-lx.broadinstitute.org:3311/cddb/ctrp2/perturbation/perCurve/correlation/")
        String header = """{"cpdID":411738,"cellSampleAnnotation":[{"sitePrimary":"biliary_tract","histSubtype":"unspecified"},{"sitePrimary":"bone","histSubtype":"unspecified"},{"sitePrimary":"bone","histSubtype":"dedifferentiated"}],"growthMode":["mixed","suspension","adherent"],"dataset":["Onco","COSMIC","TES"],"geneFeatureDataset":"GEX"}}
"""
        boolean retval = false
        try {
            def connection = url.openConnection()
            connection.setRequestMethod("POST")
            connection.doOutput = true
            def writer = new OutputStreamWriter(connection.outputStream)
            writer.write(header.toString())
            writer.flush()
            writer.close()
            connection.connect()

            InputStream inStream = url.openStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
            def slurper = new JsonSlurper()
            println "completed post"
        } catch (e) {
            e.printStackTrace()
            println "error"
        }
        return retval
    }




     boolean executePost3(String urlString, String parameters) {
        HttpURLConnection connection = null;
        URL url = new URL(serverLocation+urlString)
         boolean retval = false
        try {
            connection = url.openConnection()
            connection.setRequestMethod("POST")
            connection.setRequestProperty("Content-Type",
                    "application/json");
            connection.setRequestProperty("user", "ctrp")
            connection.doOutput = true
            connection.setRequestProperty("Content-Length", "" +
                    Integer.toString(parameters.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");

            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setDoOutput(true);
            Date callStarted = new Date ()

            def writer = new OutputStreamWriter(connection.outputStream)
            writer.write(parameters.toString())
            writer.flush()
            writer.close()
            connection.connect()

            def apiResponse = connection.content.text

            writeRawJsonToFile( null,
                    urlString,
                    parameters,
                    callStarted,
                    apiResponse)


            //println(recaptchaResponse)


            println "completed post"
        } catch (e) {
            e.printStackTrace()
            println "error"
        }
        return retval
    }




 List <String> randomStringSelector ( List <String> universe, int maximumElementsToReturn, boolean lessThanMaximumNumberAllowed )  {
     List <String> returnValue = []
     int elementsToReturn  =   maximumElementsToReturn
    int sizeOfTheUniverse =   universe.size()
    if (lessThanMaximumNumberAllowed)  {    // we might select a number of elements to return less than the maximum
        elementsToReturn = 1 +random.nextInt(maximumElementsToReturn)
    }
    if((elementsToReturn > 0) && (sizeOfTheUniverse > 0)) {
        def counter = 0
        while(counter>elementsToReturn) {
            returnValue.add(universe.minus(returnValue).getAt(random.nextInt(sizeOfTheUniverse)))
            counter++
        }
    }
    return  returnValue
}




String generateParametersForCorrelationPointCall ()   {
    String returnValue = ""
    return  returnValue
}







    public testCallCorrelationPoint() {
        executePost3("cddb/ctrp2/mutation/perGene/cellCount/byFacet",
"""{
    "dataset":["Onco"],
    "growthMode":["adherent"],
    "cellSampleAnnotation":[
        {"sitePrimary": "lung", "histSubtype": "adenocarcinoma"},
        {"sitePrimary": "bone", "histSubtype": "unspecified"}
    ]
}
""".toString())
        executePost3("cddb/ctrp2/perturbation/perCurve/correlation/",
"""{"cpdID":411738,
    "cellSampleAnnotation":[
             {"sitePrimary":"biliary_tract","histSubtype":"unspecified"},
             {"sitePrimary":"bone","histSubtype":"unspecified"},
             {"sitePrimary":"bone","histSubtype":"dedifferentiated"}
             ],
      "growthMode":["mixed","suspension","adherent"],
      "dataset":["Onco","COSMIC","TES"],
      "geneFeatureDataset":"GEX"
}
""".toString())
     }



    public RunDataGeneration() {
        println('launching RunDataGeneration')
        testCallCorrelationPoint()
       // executePost3("123")
    }

}
