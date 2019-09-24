package org.eclipse.gemoc.executionframework.property.tests.languages

import org.eclipse.gemoc.executionframework.test.lib.ILanguageWrapper

class ActivityDiagram implements ILanguageWrapper {

	override getEntryPoint() {
		"public static void org.eclipse.gemoc.activitydiagram.sequential.k3dsa.ActivityAspect.main(org.eclipse.gemoc.activitydiagram.sequential.activitydiagram.Activity)"
	}

	override getLanguageName() {
		"org.eclipse.gemoc.activitydiagram.sequential.ActivityDiagram"
	}

	override getInitializationMethod() {
		"org.eclipse.gemoc.activitydiagram.sequential.k3dsa.ActivityAspect.initializeModel"
	}

}
