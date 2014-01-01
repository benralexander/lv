

/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 12/12/13
 * Time: 12:49 PM
 * To change this template use File | Settings | File Templates.
 */
class MoleculeHeader {
    String compoundName         // the common name for this compound. This is a short name for display, not an IUPAC specification
    String smiles               // the SMILES specification for this compound. This field may be null signifier if the molecular structure is unknown or a mixture
    Long compoundId             // the compound ID (CID) for this row
    Long substanceId            // the substance ID (SID) for this row
    Integer numberAssaysActive  // the number of assays in which at least one experiment found this compound (CID) to be active
    Integer numberAssaysTested  // the number of assays in which this experiment was tested. Note that  numberAssaysTested >= numberAssaysActive
    Integer index  // this is a number assigned to each row.  If this grid is holding multiple SIDs inside a single cell then there will be one unique index
    //  number for each CID.  If instead this group is breaking SIDs out into individual rows then there will be a unique index number for each
    // SID.   Example: if the indexes for a set of biology headers go from 0-19 and then the user wants to go
    //  to the next page of data then the indexes will start over again at zero. (That is, they are not cumulative)
}
