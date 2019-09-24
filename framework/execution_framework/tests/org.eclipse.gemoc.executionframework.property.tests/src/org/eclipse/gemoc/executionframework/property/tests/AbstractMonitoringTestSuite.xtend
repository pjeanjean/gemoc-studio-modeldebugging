package org.eclipse.gemoc.executionframework.property.tests

import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.HashSet
import java.util.List
import java.util.Optional
import java.util.stream.Collectors
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.gemoc.executionframework.engine.Activator
import org.eclipse.gemoc.xdsmlframework.api.core.EngineStatus
import org.junit.AfterClass
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.eclipse.gemoc.executionframework.test.lib.impl.TestUtil

@RunWith(Parameterized)
abstract class AbstractMonitoringTestSuite {

//	protected int sizeNumber;
//	protected String size;
	protected String modelFileName;
	protected int propertyID = -1;

	abstract def void genericInternalTest(String plugin, String folder, String model, int scenarioID)

	abstract def String getPluginName()

	new(/*int size,*/ String modelFileName, int propertyID) {
//		this.size = format(size, 3)
//		this.sizeNumber = size
		this.modelFileName = modelFileName
		this.propertyID = propertyID
	}

	protected static def Optional<String> findProperty(String model, String plugin, String folder, int propertyID) {
		if (propertyID != -1) {
			val fileExtension = model.substring(model.lastIndexOf("."))
			val path = model.replace(fileExtension, "_properties.txt")
			val propertiesStream = Util::openFileFromPlugin(plugin, folder + "/" + path)

			val List<String> allProperties = new BufferedReader(new InputStreamReader(propertiesStream)).lines().collect(
				Collectors.toList())
			propertiesStream.close
			val String property = plugin + "/" + allProperties.get(propertyID)
			Optional::of(property)
		} else {
			return Optional::empty
		}
	}

	@Test
	def void test() {
		genericInternalTest(getPluginName, "/models"/*'''/models/«size»'''*/, modelFileName, propertyID)
	}

	static def void gemocCleanUp() {
		val stoppedEnginesEntries = Activator.getDefault().gemocRunningEngineRegistry.getRunningEngines().entrySet().
			filter[it.value.getRunningStatus == EngineStatus.RunStatus.Stopped]
		val resourceSets = new HashSet<ResourceSet>
		for (stopped : stoppedEnginesEntries) {
			val resourceSet = stopped.getValue().executionContext.resourceModel.resourceSet
			resourceSets.add(resourceSet)
			for (resource : resourceSet.resources) {
				resource.eAdapters.clear()
				resource.unload()
			}
			stopped.getValue().dispose();
			Activator.getDefault().gemocRunningEngineRegistry.unregisterEngine(stopped.getKey())
		}
		for (resourceSet : resourceSets) {
			resourceSet.resources.clear
		}
	}

	@AfterClass
	static def void pause() {
		TestUtil::waitForJobsThenWindowClosed
	}
}
