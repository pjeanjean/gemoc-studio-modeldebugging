package org.eclipse.gemoc.executionframework.property.monitor.esper.properties

import java.util.List
import java.util.Map
import org.eclipse.gemoc.executionframework.property.model.property.Absence
import org.eclipse.gemoc.executionframework.property.model.property.Between
import org.eclipse.gemoc.executionframework.property.monitor.esper.TruthValue
import org.eclipse.viatra.query.patternlanguage.emf.specification.SpecificationBuilder
import org.eclipse.viatra.query.runtime.api.IQuerySpecification

class NeverPBetweenQAndR extends AbstractTemporalProperty {
	
	val IQuerySpecification<?> p
	val IQuerySpecification<?> q
	val IQuerySpecification<?> r
	
	new(SpecificationBuilder builder, String name, Absence never, Between between) {
		super(builder, name)
		p = builder.getOrCreateSpecification(never.pattern)
		q = builder.getOrCreateSpecification(between.lowerBoundPattern)
		r = builder.getOrCreateSpecification(between.upperBoundPattern)
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
					measures P as P, R as R
					pattern (EoE | Q nP*? (P nP*?)? (R | EoE))
					define
						P as P.«pFqn»? is not null,
						Q as Q.«qFqn»? is not null,
						R as R.«rFqn»? is not null,
						nP as nP.«pFqn»? is null,
						EoE as EoE.executionAboutToStop? is not null
				)
			'''
		return result
	}
	
	override protected getStatus(Map<String, List<Map<?, ?>>> events) {
		val lP = events.get("P")
		val reachedP = !(lP === null || lP.empty)
		val lR = events.get("R")
		val reachedR = !(lR === null || lR.empty)
		if (reachedR) {
			if (reachedP) {
				return TruthValue.VIOLATED
			} else {
				return TruthValue.UNKNOWN
			}
		} else {
			return TruthValue.SATISFIED
		}
	}
}