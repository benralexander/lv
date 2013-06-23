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

    private final void  indexUniquenessCheck (int proposedNewIndex,List accumulatingIndex, String sectionName) {
        if  (accumulatingIndex.contains() ) {
            throw Exception (' Stopped the show. Duplicated index = ${} section ${sectionName}')
        }
    }


    public class CategorySection {
        List accumulatingIndex = []

        private final String individualCategorySection(int categoryIndex,
                                                       String categoryName,
                                                       String categoryDescription,
                                                       String categoryIdentifier) {
            indexUniquenessCheck (categoryIndex,accumulatingIndex,'Category1')
            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openObject
            stringBuilder << shortSpaceUnit << addQuotes('CatIdx') << colonUnit << categoryIndex << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('CatName') << colonUnit << addQuotes(categoryName) << comma  << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('CatDescr') << colonUnit << addQuotes(categoryDescription) << comma  << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('CatIdent') << colonUnit << addQuotes(categoryIdentifier)  << endOfLine
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

    }

     public class HierarchySection {

        private final String individualHierarchySection(int categoryReference,
                                                        String hierarchyType,
                                                        String structure) {
            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openObject
            stringBuilder << shortSpaceUnit << addQuotes('CatRef') << colonUnit << categoryReference << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('HierType') << colonUnit << addQuotes(hierarchyType) << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('Structure') << colonUnit << structure << endOfLine
            stringBuilder << closeObject
            return stringBuilder.toString()
        }




        public final String writeHierarchySection() {
            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openGroup << endOfLine
            stringBuilder << individualHierarchySection(0, 'Graph', '{}') <<
                    comma << endOfLine
            stringBuilder << individualHierarchySection(1, 'Tree', '{}') <<
                    comma << endOfLine
            stringBuilder << individualHierarchySection(2, 'Tree', '{}') <<
                    comma << endOfLine
            stringBuilder << individualHierarchySection(3, 'Tree', '{}')
            stringBuilder << closeGroup
            return stringBuilder.toString()
        }
    }



    public class AssaysSection {
        List accumulatingIndex1 = []
        List accumulatingIndex2 = []

        private final String individualAssaySection( int assayIndex,
                                                     String assayName,
                                                     int assayId ) {
            indexUniquenessCheck (assayIndex,accumulatingIndex1,'Assay index 1')
            indexUniquenessCheck (assayIndex,accumulatingIndex2,'Assay ID')

            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openObject
            stringBuilder << shortSpaceUnit << addQuotes('AssayIdx') << colonUnit << assayIndex << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('AssayName') << colonUnit << addQuotes(assayName) << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('AssayId') << colonUnit << assayId << endOfLine
            stringBuilder << closeObject
            return stringBuilder.toString()
        }




        public final String writeAssaySection() {
            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openGroup << endOfLine
            stringBuilder << individualAssaySection(0, 'Radiotracer Incision Assay (RIA) for Inhibitors of Human Apurinic/apyrimidinic Endonuclease 1 (APE1)', 1017) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(1, 'Inhibitors of Bloom\'s syndrome helicase: Efflux Ratio Profiling Assay', 1730) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(2, 'Inhibitors of Bloom\'s syndrome helicase: Aqueous Profiling Assay', 1732) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(3, 'Inhibitors of Bloom\'s syndrome helicase: Metabolic Stability Profiling', 1733) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(4, 'Inhibitors of APE1: Caco-2 Cell Permeability Profiling', 1735) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(5, 'Inhibitors of APE1: Mouse Plasma Stability Profiling', 1612) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(6, 'Inhibitors of APE1: Metabolic Stability Profiling', 1651) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(7, 'Inhibitors of APE1: Aqueous Solubility Profiling', 1604) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(8, 'qHTS Assay for Inhibitors of Bloom\'s syndrome helicase (BLM)', 2483) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(9, 'qHTS Assay for Inhibitors of the Human Apurinic/apyrimidinic Endonuclease 1 (APE1)', 2472) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(10, 'qHTS FP-Based Assay for Inhibitors of the Human Apurinic/apyrimidinic Endonuclease 1 (APE1)', 2623) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(11, 'qHTS Assay for Inhibitors of BRCT-Phosphoprotein Interaction (Green Fluorophore)', 3402) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(12, 'qHTS Assay for Inhibitors of BRCT-Phosphoprotein Interaction (Red Fluorophore)', 3418) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(13, 'Homologous recombination_Rad 51_dose response_2', 3594) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(14, 'Homologous recombination - Rad 51', 3874) <<
                    comma << endOfLine
            stringBuilder << individualAssaySection(15, 'Late stage assay provider results from the probe development effort to identify inhibitors of Wee1 degradation: luminescence-based cell-based assay to identify inhibitors of Wee1 degradation', 537)

            stringBuilder << closeGroup
            return stringBuilder.toString()
        }
    }




    public class AssayCross {

        private final String individualAssayCross(int categoryIndex,
                                                       String biologicalProcess,
                                                       String assayFormat,
                                                       String assayType,
                                                       String proteinTarget ) {

            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openObject
            stringBuilder << shortSpaceUnit << addQuotes('AssayRef') << colonUnit << categoryIndex << comma << endOfLine
            stringBuilder << mediumSpaceUnit << addQuotes('data') << colonUnit << openObject << endOfLine
            stringBuilder << longSpaceUnit << addQuotes('0') << colonUnit << addQuotes(biologicalProcess) << comma  << endOfLine
            stringBuilder << longSpaceUnit << addQuotes('1') << colonUnit << addQuotes(assayFormat) << comma  << endOfLine
            stringBuilder << longSpaceUnit << addQuotes('2') << colonUnit << addQuotes(assayType) << comma  << endOfLine
            stringBuilder << longSpaceUnit << addQuotes('3') << colonUnit << addQuotes(proteinTarget)  << endOfLine
            stringBuilder << mediumSpaceUnit << closeObject << endOfLine
            stringBuilder << closeObject
            return  stringBuilder.toString()
        }


        public final String writeAssayCrossSection() {
            StringBuilder stringBuilder = new StringBuilder()
            stringBuilder << openGroup << endOfLine
            stringBuilder <<  individualAssayCross (0,'none','cell-based format','protein-small molecule interaction assay','Ion channel NompC') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (2,'regulation of gene expression','cell-based format','protein expression assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (15,'bontoxilysin activity','single protein format','direct enzyme activity assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (1,'plectin-1','single protein format','protein-protein interaction assay','Regulator of G-protein signaling 4') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (3,'none','whole-cell lysate format','none','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (4,'regulation of gene expression','cell-based format','protein expression assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (6,'bontoxilysin activity','cell-based format','functional assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (5,'none','biochemical format','fluorescence interference assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (7,'plectin-1','biochemical format','protein-protein interaction assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (8,'plectin-1','single protein format','protein-protein interaction assay','Regulator of G-protein signaling 8') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (9,'bontoxilysin activity','biochemical format','direct enzyme activity assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (10,'kinase activity','cell-based format','protein-small molecule interaction assay','Ion channel NompC') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (11,'none','cell-based format','reporter-gene assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (12,'cell death','cell-based format','transporter assay','Multidrug resistance protein 1') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (13,'regulation of gene expression','cell-based format','protein expression assay','none') <<
                    comma << endOfLine
            stringBuilder <<  individualAssayCross (14,'immunological synapse formation','cell-based format','gene-expression assay','none')
            stringBuilder << closeGroup
            return stringBuilder.toString()
        }

    }





    public String createCategorySection(){
        CategorySection categorySection = new CategorySection()
        categorySection.writeCategorySection()
    }

    public String createHierarchySection(){
        HierarchySection hierarchySection = new HierarchySection()
        hierarchySection.writeHierarchySection()
    }


    public String createAssaysSection(){
        AssaysSection assaysSection = new AssaysSection()
        assaysSection.writeAssaySection()
    }



    public String createAssayCrossSection(){
        AssayCross assayCross = new AssayCross()
        assayCross.writeAssayCrossSection()
    }



    public final String createCombinedListing() {
        StringBuilder stringBuilder = new StringBuilder()
        stringBuilder << openObject << endOfLine
        stringBuilder << addQuotes('Category') << colonUnit << createCategorySection() << comma << endOfLine
        stringBuilder << addQuotes('Hierarchy') << colonUnit << createHierarchySection() << comma << endOfLine
        stringBuilder << addQuotes('Assays') << colonUnit << createAssaysSection() << comma << endOfLine
        stringBuilder << addQuotes('AssayCross') << colonUnit << createAssayCrossSection() << endOfLine
        stringBuilder << closeObject
        return stringBuilder.toString()
    }



    public LinkedVisHierData() {}

}
