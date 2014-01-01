

/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 12/12/13
 * Time: 12:43 PM
 * To change this template use File | Settings | File Templates.
 */
class  MssDataElement {
    String staticDisplay // This are the strings that will be statically presented to users when they see the molecular spreadsheet ( that is, without requiring a mouse over ).
    //  This text will presumably correspond to one of the priority elements.

    List<String> mouseOverDisplay  //  This is the text which will be presented to users upon mouse over of the static display. This text will presumably correspond to the
    // child elements associated with each priority element. This element is a list, not a string, because there may be multiple elements that correspond
    // to each static display.  The idea is that each string will hold all of the text that should appear on a single line.

    //bardpremium.ExperimentResult experimentResult
    // this element will contain everything else that the molecular spreadsheet might wish to display as a pop-up when the user clicks on an element
    // These data should include dose response curves, points, and in general anything that is displayed by the showExperiment page.
    // My presumption is that I can take whatever data structure is used for that page and use those data for the molecular spreadsheet.
    // The client will then construct a URL and serve this data to the spreadsheets of particular users upon request.  I know that we
    // had discussed serving these data directly from the backend at one point, but I now think it might make more sense to serve it
    // from the Bard Web server

}
