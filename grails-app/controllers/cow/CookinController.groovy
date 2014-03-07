package cow

class CookinController {

    def index() {
        render (view: 'cookin')
    }
    def nick() {
        render (view: 'nick')
    }
    def multi() {
        render (view: 'multi')
    }
    def arrayData() {
        render (view: 'arrayData')
    }

    def arrayNest() {
        render (view: 'arrayNest')
    }
    def arrayFilter() {
        render (view: 'arrayFilter')
    }
    def colorinterp() {
        render (view: 'colorinterp')
    }
    def cookin(){}
}
