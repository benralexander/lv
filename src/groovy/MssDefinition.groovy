

/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 12/12/13
 * Time: 12:50 PM
 *
 * The idea is that the information contained in a single mssDefinition  will be sufficient to create one page of the molecular spreadsheet.
 *
 * Note regarding transposition: by default, the molecular spreadsheet associates columns with experiments (listed along the top of the MSS)
 * and associates columns with rows ( listed along the left side of the MSS).  The molecular spreadsheet needs to retain the ability to
 * transpose results, however, so that experiments are listed on different rows, and molecules are presented in different columns. This
 * act of transposing, however, should be handled entirely at the client, and therefore should be a variation in the presentation layer that
 * we can ignore for the purposes of data structures and method signatures.
 */
class MssDefinition {
    List<BiologyHeader> biologyHeaders = []  // specific headers along the top of each column in a molecular spreadsheet
    AvailablePages availableBiologyPages     // existence of other biology headers not currently displayed
    List<MoleculeHeader>  moleculeHeader = []// specific headers along the left side of each row in a molecular spreadsheet
    AvailablePages availableMoleculePages    // existence of other biology headers not currently displayed
    List<MssData> mssData = []               // dated to fill a molecular spreadsheet
    Integer errorCode                        // various things can go wrong with the request. An error code allows the server
    //  provide data along with an indication about any possible problems
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

The  challenge across all three scenarios is that the caller wishes to retrieve one page of data at a time, potentially moving back and forth across different pages.
Precisely specifying which data elements the caller wants to see next (ie experiment IDs/assay IDs/etc) is impossible, however, because the calling routine
doesn't have that information.  Here is the solution I propose, which would allow the client to page freely and without requiring state dependence on the part of the server:
1) the caller makes their request, specifying IDs as necessary for their scenario of interest. As well, they specify the page number they want along the biological access,
and the page number may want along the molecule axis, with the default being page 0 along both axes.
2) The server receives the request, determines all of the biological columns that need to be returned (according to the specification below in "How to sort the columns"), and then
determines the maximum possible number of pages on both the biological and the molecule axis. The server then then returns that portion of the available data as requested
by the client.
3) If the user wishes to page ( up/down, or left/right) then the caller will request a different portion of the available data.
4) If the user wishes to sort any row or column extending beyond the data currently held by the molecular spreadsheet ( presumably by
clicking on a header) then the server needs to be able to sort across all of the data that could constitute a complete spreadsheet
and then needs to return the corresponding information.

In order to maintain statelessness for the backend, the server needs to be able to sort both columns and rows in a deterministic way.  We need to consider both the case
where the server is directed to use a particular call him for sorting, as well as the case where the user specifies no sorting criteria:

Caller-specified sorting criteria:
          The server is still responsible for selecting all of the columns that will be sorted along with the column(s) that the user has specifically
          requested. Therefore the server should begin with the basic criteria of the molecular spreadsheet (using scenarios 1, or 2, or 3) to generate
          the data (described below in "How to sort the columns"), then the server should consider the page number that the user is requesting, and then
          should determine that the specific column(s) the user has specified as the basis for the sort exist on the page in question. If all specified
          columns ( along with ascending/descending specification) exist within the specified page then the server should perform the sort, and return
          the requested data.  If the server determines that the column requested for sorting is not present on the page the caller is requesting then
          the server should issue an error code and return data sorted by the default criteria.


Sorting order not specified by the caller:
          The server begins with the sorting criteria provided by the caller (using scenarios 1, or 2, or 3) to generate the data, which are then sorted
          as described below.  The server then uses the page number and the extent of rows provided to provide the desired portion of the total possible
          molecular spreadsheet (as defined by the query) to the client.  Note that the data within any page other than the default page may not appear
          to be sorted by any visible criteria.  The sorting criteria for rows are dependent on the columns selected for the default page -- if the user
          has moved to the left by one page (that is, is considering a different set of experiments) then the molecules are still sorted by the experiment(s)
          present on the default page. This maintenance of the original sort order is essential so that the molecules a user is considering doesn't change
          every time the user pages to consider a different set of experiments.


How to sort the columns:  in order to maintain statelessness we need first to agree upon a method for sorting the biology columns. At the highest level
the goal of this sorting operation is to place the most relevant data at the top and to the left of every molecular spreadsheet we calculate for the user.
Given that we support paging across multiple experiments we are not attempting to enforce this condition on every screen the user sees, but instead we want
to make sure that default page (which by definition is the top left corner of the molecular spreadsheet defined by the user's query) should generally be
well-populated, but as the user pages around they may find pages that have much less usable data. The specific algorithm we can use should be as follows:
 1) Employ the user's chosen scenario (1, 2, or 3) to retrieve a set compounds (call this set C), along with a set of experiments (call this set E) in
 which those compounds were tested.
 2) Sort experiments E such that the experiment that has the greatest number of results over C is first, the second greatest number of results over C, is
 second, etc.  The results of this sorting operation is a sorted vector of experiments ( call this vector_E ).
 3) Given that the biology elements are sorted we can now proceed to sort the compounds.  Use experimental results from the first experiment in vector_E to
 sort the compounds in C.  Any ties can be broken by resorting to the second experiment in vector_E, and so on
 until the ordering of elements in C is unambiguous. The result of this operation should be vector_C.
The server can now use vector_E and vector_C to organize information it will return to the client:  Based on the experiment page number and the
number of columns requested, along with the compound page number and the number of rows requested the server can assemble a block of data to return to the
molecular spreadsheet.

Additional considerations:

Result types: [which result type will we use to sort the experiment?  ** This question is still to be answered ** ]

Assay ID versus Project ID grouping:  The user may be primarily interested in grouping experiments based on their membership in assays ( we will assume
this preference if the search is made on the basis of assay IDs). In this case step 2 in the above algorithm would be broken into the following two steps:
2 ( revised for assay-based grouping preference):
2a. Take experiments E and group them by every assay protocol they instantiate (call this set A). Sort A based on the number of combined results across
every experiment within each assay=n ( call this An).  As an example, all of the experiments instantiating assay protocol
1 would be grouped together into A1, while experiments instantiating assay protocol 2 would be grouped into A2).  Then (provided there is more than one
An), order the different An's by aggregating all experimental results across each assay, so that the assay with the greatest number of experimental results
over C is first, the assay with the second greatest number of experimental results is second, etc. Call this ordering vector_A.
2b. For each experiment in each An order the experiments based on the number of experimental results over C.  This will give you a series of vectors for
each element in vector_A, which we could call vector_An_vector_E.  By then looping through all elements in vector_A and, for each reading through its
vector_An_vector_E we could create a combined ordered list of every experiment.  The result of this operation is a new vector_E that is now grouped by
assay.

Users may instead be interested primarily in grouping their experiments on the basis of their membership in projects. We could undertake an operation
analogous to the one described above for assays, but there is an additional complication because assays may belong to multiple projects. Does this mean
that we should attempt to group by project and be willing to list assays multiple times? Or does an assay listed once not get listed again in a
subsequent project grouping? Or should we avoid project grouping altogether and group only on the basis of assays? [** This question is still to be answered **]

Granting substances individual rows:
Users may request that substances (SIDs) be listed on separate rows within the molecular spreadsheet (though the default will be to collect SID's within
cells of the molecular spreadsheet and to allow users to distinguish visually between those records based on information in mouse over pop ups).  If users
request a spreadsheet broken into substance rows then the initial sorting of experiments ( generating vector_E) proceeds identically as above. As well,
the sorting of compounds to create vector_C also perceives as above. The only difference in this case will be that the molecule headers in the returned
data structure provide an element for each SID, and that the data for this spreadsheet should be split up accordingly so that each cell points to the
correct header. It will be up to the client to provide some visual grouping so that users can see the association between different SIDs that belong to
the same CID.



PROPOSED SIGNATURE


MssDefinition retrieveMolecularSpreadsheet( List<String> cidList,  // all compounds upon which the search will be conducted.  May be null, as in scenario 2
                                            List<String> aidList,  // all assays upon which the search will be conducted. May be null, as in scenario 1
                                            List<String> pidList,  // all assays upon which the search will be conducted. May be null, as in scenario 1
                                            Integer biologyPageNumber,  // natural number describing which page of biology column data we should retrieve. 0 provides the default page.
                                            Integer biologyPageWidth,   // how many columns exist in a page? Note that this parameter determines not only the maximum number
                                            //  of columns that can be returned by the query, but (in the case that biologyPageNumber>0) determines
                                            //  the account of the column for which the server will begin to return data
                                            List<Integer> columnsForSorting,       // Provides the index of the row that we will use for sorting (note there is also a dependence on
                                            // the previous two parameters, biologyPageNumber and  biologyPageWidth).  This parameter accepts a list
                                            // so that users can specify more than one column in case they want to make conditional sorts across multiple
                                            // columns in order to break ties.
                                            List <Boolean> ascendingForEachColumn, // For each column listed in the preceding parameter (columnsForSorting) we need to know whether
                                            // this sort is ascending or descending.  I use a Boolean data type in order to emphasize that
                                            // the distinction is binary, but we could make the list contain integers if that's more convenient.
                                            Integer moleculePageNumber, // natural number describing which page of biology column data we should retrieve. 0 provides the default page.
                                            Integer moleculePageWidth,  // how many columns exist in a page? Note that this parameter determines not only the maximum number
                                            //  of columns that can be returned by the query, but (in the case that biologyPageNumber>0) determines
                                            //  the account of the column for which the server will begin to return data
                                            Integer outcome,       // Are we restricting the data retrieved to only active results?  Active + inactive? only inactive?  We might
                                            //  want to bitmap this parameter so that we can allow any combination of possibilities.
                                            Integer groupByPreferences );  // Do we group preferentially by assay, or do we group preferentially by project?

  */