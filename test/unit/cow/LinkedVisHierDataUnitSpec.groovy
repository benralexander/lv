package cow

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import groovy.json.JsonSlurper
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
        println  linkedVisHierData.writeCategorySection ()

        then:
        i == 1
        def userJson = new JsonSlurper().parseText(linkedVisHierData.writeCategorySection () )
        assert  userJson.getClass().name == 'java.util.ArrayList'
    }




}
