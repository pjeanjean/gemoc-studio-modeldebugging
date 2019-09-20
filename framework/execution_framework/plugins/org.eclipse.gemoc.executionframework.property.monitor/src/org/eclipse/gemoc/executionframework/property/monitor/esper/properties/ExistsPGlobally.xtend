package org.eclipse.gemoc.executionframework.property.monitor.esper.properties

import org.eclipse.gemoc.executionframework.property.model.property.Existence
import org.eclipse.viatra.query.patternlanguage.emf.specification.SpecificationBuilder
import org.eclipse.viatra.query.runtime.api.IQuerySpecification
import java.util.Map
import java.util.List
import org.eclipse.gemoc.executionframework.property.monitor.esper.TruthValue

class ExistsPGlobally extends AbstractTemporalProperty {
	
	val Existence exists
	val IQuerySpecification<?> p
	
	new(SpecificationBuilder builder, String name, Existence exists) {
		super(builder, name)
		this.exists = exists
		p = builder.getOrCreateSpecification(exists.pattern)
		queries.put(p.fullyQualifiedName, p)
	}
	
	override protected String getStatementString() {
		val pFqn = p.fqn
		val result =
			'''
				select * from «name»
				match_recognize (
					measures P as P
					«pattern»
					define
						P as P.«pFqn»? is not null,
						P1 as P1.«pFqn»? is not null,
						nP as nP.«pFqn»? is null,
						EoE as EoE.executionAboutToStop? is not null
				)
			'''
		return result
	}
	
	private def String rec(int i) {
		if (i < exists.min - 1) {
			return '''nP*? (EoE | P1 «rec(i + 1)»)'''
		}
		if (exists.max > 0) {
			if (i < exists.max) {
				return '''nP*? (EoE | P «rec(i + 1)»)'''
			} else {
				return '''nP*? (EoE | P1)'''
			}
		} else {
			return '''nP*? (EoE | P)'''
		}
	}
	
	private def getPattern() {
		val pattern =
			'''
				pattern («rec(0)»)
			'''
		return pattern
	}
	
	override protected getStatus(Map<String, List<Map<?, ?>>> events) {
		val lP = events.get("P")
		val reachedP = !(lP === null || lP.empty)
		return if (reachedP) TruthValue.SATISFIED else TruthValue.VIOLATED
	}
}