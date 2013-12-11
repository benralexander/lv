/**
 * The highest level class here is the MssDefinition. The idea is that the information contained in a single mssDefinition  will be sufficient
 * to create one page of the molecular spreadsheet. As such the MssDefinition class has three parts: 1) a list of biology headers (which corresponds
 * to the headers along the top of the molecular spreadsheet); 2) a list
 * of molecule headers; and
 */
class MssDefinition {
    List<BiologyHeader> biologyHeaders = []
    List<MoleculeHeader>  moleculeHeader = []
    List<MssData> mssData = []
}


class BiologyHeader{
    String experimentName  // name of an individual experiment
    Long experimentId // experiment ID (EID)
    String assayName // the name of the assay protocol to which this experiment belongs. Note that multiple experiments may reference the same assay name.
    Long assayId // assay ID (ADID). Note that multiple experiments may reference the same assay ID.
    String projectName // name of the project to which this experiment belongs.   Note that an experiment might not belong to a project, so this field is nullable
    Long projectId //  project ID (PID).  This field will be null if the experiment does not belong to a project
    Map mapOfResultTypes  // This map will contain one element for each result type that belongs to this experiment. The contents of the map are as follows:
                          //  key (Long), is the dictionary ID describing this result type
                          //  value (String), is the name of the result type as it should be printed in the molecular spreadsheet
    Integer  index // this is a number assigned to each column. When reading through the mssData two-dimensional array we can use the first dimension
                   //  of the array to get back to the correct BiologyHeader by using this index value.  Note that these index numbers are relative to a single
                   //  screenful of the molecular spreadsheet.  Example: if the indexes for a set of biology headers go from 0-19 and then the user wants to go
                   //  to the next page of data then the indexes will start over again at zero. (That is, they are not cumulative)/
}


class MoleculeHeader {
    String compoundName // the common name for this compound. This is a short name for display, not an IUPAC specification
    String smiles // the SMILES specification for this compound. This field may be null signifier if the molecular structure is unknown or a mixture
    Long compoundId // the compound ID (CID) for this row
    Long substanceId // the substance ID (SID) for this row
    Integer numberAssaysActive // the number of assays in which at least one experiment found this compound (CID) to be active
    Integer numberAssaysTested // the number of assays in which this experiment was tested. Note that  numberAssaysTested >= numberAssaysActive
    Integer index  // this is a number assigned to each row.  If this grid is holding multiple SIDs inside a single cell then there will be one unique index
                   //  number for each CID.  If instead this group is breaking SIDs out into individual rows then there will be a unique index number for each
                   // SID.   Example: if the indexes for a set of biology headers go from 0-19 and then the user wants to go
                   //  to the next page of data then the indexes will start over again at zero. (That is, they are not cumulative)
}



class  MssData {
    List<MssDataElement> cellContents // This list holds all of the elements that should appear in a single cell  of the molecular spreadsheet. This field is
                                      // a list because there may be multiple distinct lines within each cell of the MSS, and each of those lines may have
                                      // its own mouse over text and/or callback URL
    Integer biologyHeaderIndex  // this index references the biology header ID for this cell
    Integer moleculeHeaderIndex  // this index references the molecule header ID for this cell
}


class  MssDataElement {
    String staticDisplay // This are the strings that will be statically presented to users when they see the molecular spreadsheet ( that is, without requiring a mouse over ).
                         //  This text will presumably correspond to one of the priority elements.
    List<String> mouseOverDisplay  //  This is the text which will be presented to users upon mouse over of the static display. This text will presumably correspond to the
                         // child elements associated with each priority element. This element is a list, not a string, because there may be multiple elements that correspond
                         // to each static display.  The idea is that each string will hold all of the text that should appear on a single line.
    URL callbackDisplay  // This element is a URL that the MSS will used to retrieve data when a user clicks on a static element.
}



/*
Proposed method signature:

As discussed in our  functional requirements document (https://confluence.broadinstitute.org/display/cbip/Functional+Requirements+Documents), there are three different
scenarios that we need to support.  These may be summarized as:

scenario 1: user requests all results for one or more CIDs.  The database must make experimental results available across all experiments, even though the caller
may not know how many experiments with data are available for examination.

scenario 2: User requests all results for one or more assay IDs and/or one or more project IDs.  The database must make experimental results available across all
tested compounds, even though user may not know how many compounds are available.

scenario 3: User requests all results for one or more CIDs, as tested in one or more assay IDs and/or one or more project IDs. In this case the number of CIDs is
fixed by the query, but the number of experiments that may be associated with a specified assay IDs and/or project IDs may be unknown to the caller.

The  challenge across all three scenarios is that the caller wishes to retrieve one page of data at a time, potentially moving back and forth across different pages,
but without knowing the contents of those pages the caller can't ask for specific experiment IDs/assay IDs/etc.  One possible solution is as follows:
1) the caller makes their request, specifying IDs as necessary for their scenario of interest. As well, they specify the page number they want along the biological access,
and the page number may want along the molecule axis. The server receives the request, determines all of the biological columns that need to be returned ( all sorted by a
previously agreed-upon specification), and then counts over the correct number of pages on both the biological and the molecule axis and then returns that portion of
the larger 'virtual' molecular spreadsheet.  The server then sends that page down to the caller, and the caller can decide what page to request next.
                                                                                                                                                     */




 MssDefinition retrieveMolecularSpreadsheet( List<String> cidList,
