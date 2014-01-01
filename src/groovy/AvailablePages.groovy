

/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 12/12/13
 * Time: 12:48 PM
 * To change this template use File | Settings | File Templates.
 */
class AvailablePages {

    Integer recordsAvailable
    // The total number of biology records we can draw upon.  This record is essential for handling paging at the
    // client, since we can say "if records are available that we haven't brought down already then enable paging".  For the biology header
    // this class describes experiments, while for the molecule header this class describes compounds/substances.

    Integer startingCountOfRecords
    // This variable answers the question "where are we among all of the possible records (for example distinct experiments)?".  This
    // index allows the molecular spreadsheet enable/disable paging options (forward, or backward, or both) for users. Note that in
    // principle the client could maintain its own count of it's location among the total count, but I think it makes more sense to
    // have this number returned dynamically with each call in order to make sure the two counts to get out of sync for whatever reason
    // ( changes in the quantity of data available in a given molecular spreadsheet could in theory change over the course of that
    // spreadsheet's display, as one example of how the count between client and server could diverge )

}
