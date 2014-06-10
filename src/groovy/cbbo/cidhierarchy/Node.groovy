package cbbo.cidhierarchy

/**
 * Created with IntelliJ IDEA.
 * User: ben
 * Date: 6/10/14
 * Time: 10:21 AM
 * To change this template use File | Settings | File Templates.
 */
class Node {
    public String name
    public String description
    public  List<Node> children = new ArrayList()
    public Integer mySize  = 1
    public Integer unaccounted = 0
    public Integer color = 1
// constructor
    public Node (  String name, String description ) {
        this.name = name
        this.description = description
    }
    public Node (  Integer nullName, Integer size ) {
        this.name =  "zzull"+nullName.toString()
        this.description = "invisible"
        this.mySize = size
        this.color = 0
    }

    public int bumpSize () {
        mySize++
    }

    public int retriveSize(){
        return mySize
    }

    public int retriveUnaccounted(){
        return unaccounted
    }


    public int retriveColor(){
        return color
    }


} // end class Node


