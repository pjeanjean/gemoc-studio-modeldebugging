package org.eclipse.gemoc.executionframework.property.tests.ad

import java.util.ArrayList
import java.util.Collection

class ActivityDiagramTestData {
	
	def static Collection<Object[]> getData() {
		val nbProperties = 25
		val result = new ArrayList<Object[]>

		val name = "benchmarking_model_x1_t100.ad"

		for (scenarioID : -1 .. nbProperties - 1) {
			// TODO we might need to put the first one twice,
			// since it may give terrible results the first time
			result.add(#[name, scenarioID])
		}
		
		return result
	}
}