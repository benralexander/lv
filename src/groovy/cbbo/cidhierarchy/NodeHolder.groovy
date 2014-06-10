/**
 * Created with IntelliJ IDEA.
 * User: ben
 * Date: 6/10/14
 * Time: 10:22 AM
 * To change this template use File | Settings | File Templates.
 */



package cbbo.cidhierarchy

class NodeHolder {

    public  LinkedHashMap<String,Node> nodeFinder  = [:]
    public Node root = null
    public Integer globalCounter = 1

    public NodeHolder(){
        root = new Node ("/","")
        nodeFinder["1."]=root
    }



    public void    createDummyNodes(){
        Integer nullCounter = 0
        for ( Node subNode in root.children) {
            recursivelyBuildDummyChildren(subNode,nullCounter)
        }
    }

    public int recursivelyBuildDummyChildren(Node node,Integer nullCounter) {
        if (node.children.size()>0) {   // if you have no children then you don't need a dummy node
            for ( Node subNode in node.children) {
                nullCounter++
                nullCounter=recursivelyBuildDummyChildren(subNode,nullCounter)
            }
            if (node.unaccounted > 0) {
                nullCounter++
                globalCounter++
                node.children << new Node(globalCounter,node.unaccounted)
            }

        }
        return nullCounter
    }



    /***
     *   Walk the tree and add up all the values underneath each node. Create a field called 'unaccounted'
     *   to hold those values so that we can adjust them later
     */
    public void adjustArcWidthSlices (){
        for ( Node subNode in root.children) {
            addUpEverythingBeneath(subNode)
        }
    }


    public int addUpEverythingBeneath (Node node)  {
        if (node.children.size()==0) {
            return node.mySize+node.unaccounted
        } else {
            int accumulator = 0
            for ( Node subNode in node.children) {
                accumulator += addUpEverythingBeneath(subNode)
            }
            node.unaccounted = node.mySize -  accumulator
            return  node.mySize
        }

    }




    public boolean addAnotherNode ( String nodeName,String nodeDescr, String bringerOfLevels ) {
        List <String> levelBreaker = bringerOfLevels.split(/\./)
        Node currentNode = null
        int depth = 0
        String developingIdentifier = ""
        for ( String level in levelBreaker) {
            // first level gets special handling
            if ( depth == 0 ) {
                if (levelBreaker[0]=="1") {// sanity check --  should always be true
                    currentNode = this.root
                } else {
                    println("Unexpected level root identifier = ${levelBreaker[0]}")
                }
                developingIdentifier += "1."
            } else { // we aren't at the first level
                if (level=="00"){ // node should already be stored by this point
                    break;
                } else {
                    developingIdentifier += (level+".")
                }
                if (!(nodeFinder.containsKey(developingIdentifier))) {
                    nodeFinder[developingIdentifier]=new Node(nodeName,nodeDescr)
                    Node node  =  nodeFinder[developingIdentifier] as Node

                    currentNode.children.add(nodeFinder[developingIdentifier] as Node)
                } else {
                    Node node  =  nodeFinder[developingIdentifier]
                    node.bumpSize()
                    currentNode=node
                }
            }
            depth++
        } // for loop
    }// end method addAnotherNode



    public void printRecursiveDescent (){
        // we can skip the first levels
        // Node root  = /*root.children[0]*/ nodeFinder["1."]
        println "+++++++++++++++ code begins below this line++++++++++++++++++"
        println "var \$data = ["//{\"name\":\"/\", \"children\": ["
        descend(root,1,false)
        println "]"
        println "+++++++++++++++ code ends above this line++++++++++++++++++++"
    }



    public void descend (Node node, int depth,boolean commaNecessary) {
        if ( node ) {
            depth.times{print '  ' }
            print "{\"name\":\"${node.name}\", \"descr\":\"${node.description}\","
            // println node.description
            if (node.children){
                print "\"size\": ${node.retriveSize()},"
                print "\"col\": ${node.retriveColor()},"
//          print "\"unaccounted\": ${node.retriveUnaccounted()},"
                println "\"children\": ["
                int numberOfChildren =  node.children.size()
                int iterationCount = 1
                for (Node subnode in node.children) {
                    descend(subnode, depth+4, ((iterationCount++)<numberOfChildren))
                }
                (depth+2).times{print '  ' }
                print "]}"
                if (commaNecessary) {println ","} else {println()}
            } else {
                //         print "\"unaccounted\": ${node.retriveUnaccounted()},"
                print "\"col\": ${node.retriveColor()},"
                print "\"size\":${node.retriveSize()}}"
                if (commaNecessary) {println ","} else {println()}
            }
        }
    }




} // end class addAnotherNode


