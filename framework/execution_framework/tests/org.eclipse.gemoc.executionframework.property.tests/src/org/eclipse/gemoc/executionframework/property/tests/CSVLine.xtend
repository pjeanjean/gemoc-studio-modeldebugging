package org.eclipse.gemoc.executionframework.property.tests

//model_size,nbMut,timeStep,traceSize,traceMemoryFootprint,meanJumpTime,allJumpTimes
class CSVLine {

	public String modelName = ""
	public int propertyID = -1
	public int modelSize = -1
	public int amountSteps = -1
	public Long executionTime = 0l
	

	static val separator = ";";

	private static def getAllFields() {
		CSVLine.declaredFields.filter[f|!f.name.contentEquals("separator")]
	}

	def static String getColumnNames() {
		val allNames = getAllFields.map[f|f.name]
		return allNames.join(separator)
	}

	def String customToString() {
		return getAllFields.map[f|f.get(this)].join(separator)
	}

}
