
package cow

import cbbo.ctrp.RunDataGeneration
import cbbo.cidhierarchy.GenerateHierarchicalData
import cbbo.cidhierarchy.Node
import cbbo.cidhierarchy.NodeHolder


class GroovyLauncherController {

    def index() {
        render(view: 'cddbApiTester')
    }
    def cddbApiTester() {
        RunDataGeneration runDataGeneration = new RunDataGeneration()
        render(view:'cddbApiTester')
    }
    def GenerateHierarchicalData() {
        // First we need to read in the data file
        String inputFile = "d:/dev/bootstrapCow/teststub.csv"
        GenerateHierarchicalData prober = new GenerateHierarchicalData()
        TreeSet<Integer> treeSet = prober.convertCidsToProteinTargets(inputFile)
        prober.display(treeSet)
        //TreeSet<String> uniprotIds = prober.readFromBioIDFile()
        TreeSet<String> uniprotSet = prober.convertBiologyIdsToUniprotIds(treeSet)
        TreeSet<String> filteredUniprotSet = prober.record (uniprotSet)
        NodeHolder nodeHolder =  prober.convertUniprotIdsToNodes(filteredUniprotSet)
        println "total number nodes = ${nodeHolder.nodeFinder.size()}"
        nodeHolder.adjustArcWidthSlices()
        nodeHolder.createDummyNodes()
        nodeHolder.printRecursiveDescent ()

        render(view:'cddbApiTester')
    }

}
