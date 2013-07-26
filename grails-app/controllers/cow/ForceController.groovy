package cow

class ForceController {

    def index() {
        render(view: 'force')
    }
    def force() { }
    def feedMeJson(){
        render (  """
{
 "name": "flair",
 "children": [
 {   "name": "flower1",
      "children": [{"name": "flow1"}, {"name": "flow2"}]
      },
 {   "name": "flower2"},
 {   "name": "flower3",
       "children": [{"name": "flow3"}, {"name": "flow4"},{"name": "flow6"}, {"name": "flow7"}]
},
 ]
}
"""
        )
    }
}
