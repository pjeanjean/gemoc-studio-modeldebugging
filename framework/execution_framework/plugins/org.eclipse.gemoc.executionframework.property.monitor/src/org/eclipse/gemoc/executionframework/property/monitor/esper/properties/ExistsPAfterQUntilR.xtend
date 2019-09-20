package org.eclipse.gemoc.executionframework.property.monitor.esper.properties

import java.util.List
import java.util.Map
import org.eclipse.gemoc.executionframework.property.model.property.AfterUntil
import org.eclipse.gemoc.executionframework.property.model.property.Existence
import org.eclipse.gemoc.executionframework.property.monitor.esper.TruthValue
import org.eclipse.viatra.query.patternlanguage.emf.specification.SpecificationBuilder
import org.eclipse.viatra.query.runtime.api.IQuerySpecification

class ExistsPAfterQUntilR extends AbstractTemporalProperty {
	
	val Existence exists
	val IQuerySpecification<?> p
	val IQuerySpecification<?> q
	val IQuerySpecification<?> r
	
	new(SpecificationBuilder builder, String name, Existence exists, AfterUntil afterUntil) {
		super(builder, name)
		this.exists = exists
		p = builder.getOrCreateSpecification(exists.pattern)
		q = builder.getOrCreateSpecification(afterUntil.lowerBoundPattern)
		r = builder.getOrCreateSpecification(afterUntil.upperBoundPattern)
		queries.put(p.fullyQualifiedName, p)
		queries.put(q.fullyQualifiedName, q)
		queries.put(r.fullyQualifiedName, r)
	}
	
	override protected String getStatementString() {
		val pFqn = p.fqn
		val qFqn = q.fqn
		val rFqn = r.fqn
		val result =
			'''
				select * from «name»
				match_recognize (
					measures P as P, Q as Q, EoE as EoE
					«pattern»
					define
						P as P.«pFqn»? is not null,
						P1 as P1.«pFqn»? is not null,
						nP as nP.«pFqn»? is null,
						Q as Q.«qFqn»? is not null,
						R as R.«rFqn»? is not null,
						EoE as EoE.executionAboutToStop? is not null
				)
			'''
		return result
	}
	
	private def String rec(int i) {
		if (i < exists.min - 1) {
			return '''nP*? (EoE | R | P1 «rec(i + 1)»)'''
		}
		if (exists.max > 0) {
			if (i < exists.max) {
				return '''nP*? (EoE | R | P «rec(i + 1)»)'''
			} else {
				return '''nP*? (EoE | R | P1)'''
			}
		} else {
			return '''nP*? (EoE | R | P)'''
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
		val lQ = events.get("Q")
		val reachedQ = !(lQ === null || lQ.empty)
		if (reachedQ) {
			val lP = events.get("P")
			val reachedP = !(lP === null || lP.empty)
			val execEnd = events.get("EoE")
			val reachedEoE = !(execEnd === null || execEnd.empty)
			if (reachedP) {
				if (reachedEoE) {
					return TruthValue.SATISFIED
				} else {
					return TruthValue.UNKNOWN
				}
			} else {
				return TruthValue.VIOLATED
			}
		} else {
			return TruthValue.SATISFIED
		}
	}
}