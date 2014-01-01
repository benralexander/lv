

/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 12/12/13
 * Time: 12:49 PM
 * To change this template use File | Settings | File Templates.
 */
class BiologyHeader {
    String experimentName  // name of an individual experiment
    Long experimentId      // experiment ID (EID)
    String assayName       // the name of the assay protocol to which this experiment belongs. Note that multiple experiments may reference the same assay name.
    Long assayId           // assay ID (ADID). Note that multiple experiments may reference the same assay ID.
    String projectName     // name of the project to which this experiment belongs.   Note that an experiment might not belong to a project, so this field is nullable
    Long projectId         //  project ID (PID).  This field will be null if the experiment does not belong to a project
    Map mapOfResultTypes  // This map will contain one element for each result type that belongs to this experiment. The contents of the map are as follows:
    //  key (Long), is the dictionary ID describing this result type
    //  value (String), is the name of the result type as it should be printed in the molecular spreadsheet
    Integer  index // this is a number assigned to each column. When reading through the mssData two-dimensional array we can use the first dimension
    //  of the array to get back to the correct BiologyHeader by using this index value.  Note that these index numbers are relative to a single
    //  page of the molecular spreadsheet.  Example: if the indexes for a set of biology headers go from 0-19 and then the user wants to go
    //  to the next page of data then the indexes will start over again at zero. (That is, they are not cumulative)

}
