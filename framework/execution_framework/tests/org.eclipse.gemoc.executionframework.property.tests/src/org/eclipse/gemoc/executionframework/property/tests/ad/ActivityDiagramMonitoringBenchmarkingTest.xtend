package org.eclipse.gemoc.executionframework.property.tests.ad

import java.util.Collection
import org.eclipse.gemoc.executionframework.property.tests.AbstractMonitoringBenchmarkTestSuite
import org.eclipse.gemoc.executionframework.property.tests.languages.ActivityDiagram
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters

@RunWith(Parameterized)
class ActivityDiagramMonitoringBenchmarkingTest extends AbstractMonitoringBenchmarkTestSuite {
	
	new(/*int size,*/ String model, int scenarioID) {
		super(/*size,*/ model, scenarioID)
	}
	
	@Parameters(name="{1}")
	static def Collection<Object[]> data() {
		return ActivityDiagramTestData::data
	}
	
	override getSemanticsPlugin() {
		"org.eclipse.gemoc.activitydiagram.sequential.k3dsa"
	}
	
	override getDSL() {
		new ActivityDiagram
	}
	
	override getPluginName() {
		"org.eclipse.gemoc.activitydiagram.sequential.property.benchmark"
	}
}
