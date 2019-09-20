package org.eclipse.gemoc.executionframework.property.monitor.esper.properties

import java.util.List
import java.util.Map
import org.eclipse.gemoc.executionframework.property.model.property.After
import org.eclipse.gemoc.executionframework.property.model.property.Existence
import org.eclipse.gemoc.executionframework.property.monitor.esper.TruthValue
import org.eclipse.viatra.query.patternlanguage.emf.specification.SpecificationBuilder
import org.eclipse.viatra.query.runtime.api.IQuerySpecification

class ExistsPAfterQ extends AbstractTemporalProperty {
	
	val Existence exists
	val IQuerySpecification<?> p
	val IQuerySpecification<?> q
	
	new(SpecificationBuilder builder, String name, Existence exists, After after) {
		super(builder, name)
		this.exists = exists
		p = builder.getOrCreateSpecification(exists.pattern)
		q = builder.getOrCreateSpecification(after.lowerBoundPattern)
		queries.put(this.p.fullyQualifiedName, this.p)
		queries.put(this.q.fullyQualifiedName, this.q)
	}
	
	override protected String getStatementString() {
		val pFqn = p.fqn
		val qFqn = q.fqn
		val result =
			'''
				select * from «name»
				match_recognize (
					measures P as P, Q as Q
					«pattern»
					define
						P as P.«pFqn»? is not null,
						P1 as P1.«pFqn»? is not null,
						nP as nP.«pFqn»? is null,
						Q as Q.«qFqn»? is not null,
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
				pattern (EoE | Q «rec(0)»)
			'''
		return pattern
	}
	
	override protected getStatus(Map<String, List<Map<?, ?>>> events) {
		val lP = events.get("P")
		val reachedP = !(lP === null || lP.empty)
		val lQ = events.get("Q")
		val reachedQ = !(lQ === null || lQ.empty)
		if (reachedP) {
			return TruthValue.SATISFIED
		} else {
			return if (reachedQ) TruthValue.VIOLATED else TruthValue.SATISFIED
		}
	}
	
}