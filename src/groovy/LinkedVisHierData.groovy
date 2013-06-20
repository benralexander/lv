package cow;

public class LinkedVisHierData {
    private final String comma = ','
    private final String openGroup = '['
    private final String closeGroup = ']'
    private final String openObject = '{'
    private final String closeObject = '}'
    private final String colonUnit = ' : '
    private final String endOfLine = '\n'
    private final String tinySpaceUnit = ' '
    private final String shortSpaceUnit = '     '
    private final String mediumSpaceUnit = '      '
    private final String longSpaceUnit = '       '

    private final String addQuotes( String incomingString )  {
        return  "\"${incomingString}\""
    }

    private final String individualCategorySection(int categoryIndex,
                                                   String categoryName,
                                                   String categoryDescription,
                                                   String categoryIdentifier) {
        StringBuilder stringBuilder = new StringBuilder()
        stringBuilder << openObject
        stringBuilder << shortSpaceUnit << addQuotes('CatIdx') << colonUnit << addQuotes('categoryIndex') << comma << endOfLine
        stringBuilder << mediumSpaceUnit << addQuotes('CatName') << colonUnit << addQuotes('categoryName') << comma  << endOfLine
        stringBuilder << mediumSpaceUnit << addQuotes('CatDescr') << colonUnit << addQuotes('categoryDescription') << comma  << endOfLine
        stringBuilder << mediumSpaceUnit << addQuotes('CatIdent') << colonUnit << addQuotes('categoryIdentifier') << comma  << endOfLine
        stringBuilder << closeObject
        return  stringBuilder.toString()
    }

    public final String writeCategorySection() {
        StringBuilder stringBuilder = new StringBuilder()
        stringBuilder << openGroup << endOfLine
                stringBuilder <<  individualCategorySection (0,'Biological process','GO Biological process','GO_biological_process_term') <<
                comma << endOfLine
        stringBuilder <<  individualCategorySection (1,'Assay format','Bard assay format','assay_format') <<
                comma << endOfLine
        stringBuilder <<  individualCategorySection (2,'Protein target','Panther protein target','assay_type')  <<
                comma <<  endOfLine
        stringBuilder <<  individualCategorySection (3,'Assay type','Bard assay format','protein_target')
        stringBuilder << closeGroup
        return stringBuilder.toString()
    }

    public LinkedVisHierData() {}

}
