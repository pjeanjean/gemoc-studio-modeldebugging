/*
 * generated by Xtext
 */
package org.eclipse.gemoc.gexpressions.xtext.scoping

import java.util.ArrayList
import java.util.Collection
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EDataType
import org.eclipse.emf.ecore.EEnumLiteral
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.ETypedElement
import org.eclipse.xtext.resource.EObjectDescription
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider
import org.eclipse.xtext.scoping.impl.SimpleScope
import org.eclipse.gemoc.gexpressions.GEnumLiteralExpression
import org.eclipse.gemoc.gexpressions.GExpression
import org.eclipse.gemoc.gexpressions.GNavigationExpression
import org.eclipse.gemoc.gexpressions.GReferenceExpression

/**
 * This class contains custom scoping description.
 * 
 * see : http://www.eclipse.org/Xtext/documentation.html#scoping
 * on how and when to use it 
 *
 */
class GExpressionsScopeProvider extends AbstractDeclarativeScopeProvider {

	def IScope scope_GNavigationExpression_referencedEObject(GNavigationExpression exp, EReference ref) {

		// Scoping for navigation depends on the body (expression before the dot)
		val IScope scope = scopeForNavigation(exp.body, delegateGetScope(exp, ref))
		return filterScopeForNavigation(scope, exp.body)
	}

	// OVERRIDE ME: if you need to filter out some elements in the scope just before returning.
	// e.g. if you don't want to show all the EOperations/EStructuralFeatures available for the expression.
	def protected IScope filterScopeForNavigation(IScope scope, GExpression exp) {
		return scope
	}

	def protected dispatch IScope scopeForNavigation(GNavigationExpression exp, IScope outerScope) {

		// If it is a navigation expression, then the type of the whole expression is determined by the referencedEObject.
		return getNavigationScopeForEObject(exp.referencedEObject, outerScope)
	}

	// Determines which objects are allowed to start expressions.
	def protected dispatch IScope scopeForNavigation(GReferenceExpression source, IScope outerScope) {
		return getNavigationScopeForEObject(source.referencedEObject, outerScope)
	}

	// How to navigate on an EObject:
	// * Either it's a typed element (EParameter, EStructuralFeature, EOperation): we can navigate on the type
	// * Or an EClassifier: we can navigate on it
	// * Or an EPackage: we navigate on its subpackages and its classifiers
	// * Or an EObject: we navigate on its EClass
	def protected dispatch IScope getNavigationScopeForEObject(EObject eo, IScope outerScope) {
		return getScopeOfNavigableElementsForType(eo.eClass, outerScope)
	}

	def protected dispatch IScope getNavigationScopeForEObject(ETypedElement eo, IScope outerScope) {
		return getScopeOfNavigableElementsForType(eo.EType, outerScope)
	}

	def protected dispatch IScope getNavigationScopeForEObject(EClassifier eo, IScope outerScope) {
		return getScopeOfNavigableElementsForType(eo, outerScope)
	}

	def protected dispatch IScope getNavigationScopeForEObject(EPackage eo, IScope outerScope) {
		return getScopeOfNavigableElementsForType(eo, outerScope)
	}

	// How to navigate on an EClassifier:
	// * Either it's an EClass, in which case propose all the EOperations and EStructuralFeatures.
	// * Or it's an EDataType, in which case there is nothing to navigate onto.
	// OVERRIDE ME if you need to add stuff defined in "aspects" outside the metamodel (e.g. ECL/OCL, K3?)
	def protected dispatch IScope getScopeOfNavigableElementsForType(EClass type, IScope outerScope) {
		return Scopes.scopeFor(getAllNavigableElementsOfType(type))
	}

	/**
	 * Returns all the navigable elements of an EClass, a.k.a. the EOperations, EAttributes and EReferences.
	 */
	final def protected Collection<ETypedElement> getAllNavigableElementsOfType(EClass type) {
		val allStructuralFeatures = type.EAllStructuralFeatures
		val allOperations = type.EAllOperations
		val allNavigableElements = new ArrayList<ETypedElement>()
		allNavigableElements.addAll(allStructuralFeatures)
		allNavigableElements.addAll(allOperations)
		return allNavigableElements
	}

	def protected dispatch IScope getScopeOfNavigableElementsForType(EDataType type, IScope outerScope) {
		return IScope.NULLSCOPE
	}

	// How to navigate on a package:
	// * Either on one of its subpackages
	// * Or on one of its classifiers
	def protected dispatch IScope getScopeOfNavigableElementsForType(EPackage ePackage, IScope outerScope) {
		val allSubPackages = ePackage.ESubpackages
		val allClassifiers = ePackage.EClassifiers
		val allNavigableElements = new ArrayList<EObject>()
		allNavigableElements.addAll(allSubPackages)
		allNavigableElements.addAll(allClassifiers)
		return Scopes.scopeFor(allNavigableElements)
	}

	// Getting all the EnumLiterals.
	// TODO: could use some improvements.
	def IScope scope_GEnumLiteralExpression_value(GEnumLiteralExpression exp, EReference ref) {
		val list = new ArrayList<EEnumLiteral>
		val resourceSet = exp.eResource.resourceSet
		for (resource : resourceSet.resources) {
			val iterator = resource.allContents
			while (iterator.hasNext) {
				var eo = iterator.next()
				if (eo instanceof EEnumLiteral) {
					list.add(eo as EEnumLiteral)
				}
			}
		}

		return new SimpleScope(IScope.NULLSCOPE,
			list.map [ enumLiteral |
				return EObjectDescription.create(enumLiteral.name, enumLiteral)
			])
	}
}