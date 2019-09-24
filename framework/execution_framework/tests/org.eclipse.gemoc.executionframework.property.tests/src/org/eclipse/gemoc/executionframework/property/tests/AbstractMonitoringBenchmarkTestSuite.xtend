package org.eclipse.gemoc.executionframework.property.tests

import java.io.File
import java.io.FileOutputStream
import java.io.PrintWriter
import java.text.SimpleDateFormat
import java.util.ArrayList
import java.util.Calendar
import java.util.List
import org.eclipse.gemoc.execution.sequential.javaengine.tests.wrapper.JavaEngineWrapper
import org.eclipse.gemoc.executionframework.test.lib.IEngineWrapper
import org.eclipse.gemoc.executionframework.test.lib.IExecutableModel
import org.eclipse.gemoc.executionframework.test.lib.ILanguageWrapper
import org.eclipse.gemoc.executionframework.test.lib.impl.TestHelper
import org.eclipse.gemoc.executionframework.test.lib.impl.TestModel
import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.gemoc.executionframework.property.tests.CSVLine
import org.junit.AfterClass
import org.junit.BeforeClass

import static org.eclipse.gemoc.executionframework.property.tests.Util.*
import org.eclipse.gemoc.xdsmlframework.api.engine_addon.IEngineAddon
import java.util.Set
import org.eclipse.gemoc.executionframework.property.monitor.manager.PropertyManager

abstract class AbstractMonitoringBenchmarkTestSuite extends AbstractMonitoringTestSuite {

	// Common to all tests
	static var File outputFolder
	static var File outputCSV
	static var PrintWriter outputCSVWriter
	static var FileOutputStream outputCSVStream

	abstract def String getSemanticsPlugin()

	@BeforeClass
	def static void before() {
		// Create output folder in test project
		val Calendar currentDate = Calendar::getInstance();
		val SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-YYYY_HH-mm-ss")
		val String dateNow = formatter.format(currentDate.getTime())
		outputFolder = new File("output_time" + "_" + dateNow)
		if (!outputFolder.exists)
			outputFolder.mkdir

		// Prepare CSV file in output folder
		outputCSV = new File(outputFolder, "results.csv")
		outputCSVStream = new FileOutputStream(outputCSV)
		outputCSVWriter = new PrintWriter(outputCSVStream, true)
		outputCSVWriter.println(CSVLine::columnNames)
	}

	@AfterClass
	def static void after() {
		outputCSVStream.close
		outputCSVWriter.close
	}

	new(/*int size,*/ String model, int scenarioID) {
		super(/*size,*/ model, scenarioID)
	}

	@Data
	static class BenchResult1 {
		int amountSteps
		List<Long> executionTimes
	}

	@Data
	static class BenchResult2 {
		int amountSteps
		Long executionTime
	}

	def BenchResult1 runBench(IEngineWrapper engine, ILanguageWrapper language, IExecutableModel model, String propertyFilepath) {
		val executionTimes = new ArrayList<Long>
		var boolean haveAmounts = false
		var int amountSteps
		val Set<IEngineAddon> addons = if (propertyFilepath !== null && !propertyFilepath.empty) {
			val propertyManager = new PropertyManager
			propertyManager.addProperty(propertyFilepath, true)
			#{propertyManager}
		} else {
			#{}
		}
		for (x : 1 .. 30) {
			val testResult = TestHelper::testWithJob(engine, language, #{}, addons, model, true)
			executionTimes.add(testResult.executionDuration)
			if (!haveAmounts) {
				amountSteps = testResult.amountOfStepsExecuted
				haveAmounts = true
			}
			cleanup(getSemanticsPlugin())
		}
		return new BenchResult1(amountSteps, executionTimes.subList(executionTimes.size - 11, executionTimes.size))
	}

	def BenchResult2 testGeneric(String name, IEngineWrapper engine, ILanguageWrapper language, String plugin,
		String folder, String model, int propertyID) {

		val property = findProperty(model, plugin, folder, propertyID)
		val propertyFilepath = if(property.isPresent) property.get else ""
		val result1 = runBench(engine, language, new TestModel(plugin, folder, model, "", ""), propertyFilepath)
		val numbers = result1.executionTimes

		println('''«name» - «model» - scenario «propertyID» :''')
		println("- numbers: " + numbers)
		// println("- mean: " + mean(numbers))
		println("- median: " + median(numbers))

		return new BenchResult2(result1.amountSteps, median(numbers))
	}

	abstract def ILanguageWrapper getDSL()

	def BenchResult2 testMonitoring(String plugin, String folder, String model, int propertyID) {
		val engine = new JavaEngineWrapper()
		return testGeneric("monitoring", engine, DSL, plugin, folder, model, propertyID)
	}

	override genericInternalTest(String plugin, String folder, String model, int propertyID) {
		val line = new CSVLine

		line.modelName = model
		/*line.modelSize = sizeNumber*/
		line.propertyID = propertyID

		val resultMonitoring = testMonitoring(plugin, folder, model, propertyID)

		line.executionTime = resultMonitoring.executionTime

		line.amountSteps = resultMonitoring.getAmountSteps

		outputCSVWriter.println(line.customToString)
	}
}
