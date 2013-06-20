package cow

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification
import spock.lang.Unroll

@TestMixin(GrailsUnitTestMixin)
@Unroll
class LinkedVisHierDataUnitSpec  extends Specification {

    void setup() {
    }

    void tearDown() {
        // Tear down logic here
    }


    void "bloog"() {
        when:
        int i = 1
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()

        then:
        i == 1
        assert (linkedVisHierData.writeCategorySection ()  == "Category" )
    }




}
