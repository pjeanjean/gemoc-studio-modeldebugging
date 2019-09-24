package org.eclipse.gemoc.executionframework.property.tests.languages

import org.eclipse.gemoc.executionframework.test.lib.ILanguageWrapper

class MiniJava implements ILanguageWrapper {

	override getEntryPoint() {
		"public static void org.gemoc.activitydiagram.sequential.ad2petri.interpretedactivitydiagram.aspects.ActivityAspect.main(org.gemoc.activitydiagram.sequential.ad2petri.interpretedactivitydiagram.activitydiagram.Activity)"
	}

	override getLanguageName() {
		"org.gemoc.activitydiagram.sequential.ad2petri.InterpretedActivityDiagram"
	}

	override getInitializationMethod() {
		"org.gemoc.activitydiagram.sequential.ad2petri.interpretedactivitydiagram.aspects.ActivityAspect.initialize"
	}

}
