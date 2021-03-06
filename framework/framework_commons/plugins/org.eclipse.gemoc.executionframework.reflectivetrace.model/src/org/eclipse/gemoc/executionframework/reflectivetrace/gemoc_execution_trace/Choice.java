/*******************************************************************************
 * Copyright (c) 2016, 2017 Inria and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     Inria - initial API and implementation
 *******************************************************************************/
/**
 */
package org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.gemoc.trace.commons.model.trace.Step;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Choice</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getNextChoices <em>Next Choices</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getPossibleLogicalSteps <em>Possible Logical Steps</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getChosenLogicalStep <em>Chosen Logical Step</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getContextState <em>Context State</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getPreviousChoice <em>Previous Choice</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getSelectedNextChoice <em>Selected Next Choice</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getBranch <em>Branch</em>}</li>
 * </ul>
 *
 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice()
 * @model
 * @generated
 */
public interface Choice extends EObject {
	/**
	 * Returns the value of the '<em><b>Next Choices</b></em>' reference list.
	 * The list contents are of type {@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice}.
	 * It is bidirectional and its opposite is '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getPreviousChoice <em>Previous Choice</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Next Choices</em>' reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Next Choices</em>' reference list.
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_NextChoices()
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getPreviousChoice
	 * @model opposite="previousChoice"
	 * @generated
	 */
	EList<Choice> getNextChoices();

	/**
	 * Returns the value of the '<em><b>Possible Logical Steps</b></em>' containment reference list.
	 * The list contents are of type {@link org.eclipse.gemoc.trace.commons.model.trace.Step}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Possible Logical Steps</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Possible Logical Steps</em>' containment reference list.
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_PossibleLogicalSteps()
	 * @model containment="true"
	 * @generated
	 */
	EList<Step> getPossibleLogicalSteps();

	/**
	 * Returns the value of the '<em><b>Chosen Logical Step</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Chosen Logical Step</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Chosen Logical Step</em>' reference.
	 * @see #setChosenLogicalStep(Step)
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_ChosenLogicalStep()
	 * @model
	 * @generated
	 */
	Step getChosenLogicalStep();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getChosenLogicalStep <em>Chosen Logical Step</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Chosen Logical Step</em>' reference.
	 * @see #getChosenLogicalStep()
	 * @generated
	 */
	void setChosenLogicalStep(Step value);

	/**
	 * Returns the value of the '<em><b>Context State</b></em>' containment reference.
	 * It is bidirectional and its opposite is '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.ContextState#getChoice <em>Choice</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Context State</em>' containment reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Context State</em>' containment reference.
	 * @see #setContextState(ContextState)
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_ContextState()
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.ContextState#getChoice
	 * @model opposite="choice" containment="true"
	 * @generated
	 */
	ContextState getContextState();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getContextState <em>Context State</em>}' containment reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Context State</em>' containment reference.
	 * @see #getContextState()
	 * @generated
	 */
	void setContextState(ContextState value);

	/**
	 * Returns the value of the '<em><b>Previous Choice</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getNextChoices <em>Next Choices</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Previous Choice</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Previous Choice</em>' reference.
	 * @see #setPreviousChoice(Choice)
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_PreviousChoice()
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getNextChoices
	 * @model opposite="nextChoices"
	 * @generated
	 */
	Choice getPreviousChoice();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getPreviousChoice <em>Previous Choice</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Previous Choice</em>' reference.
	 * @see #getPreviousChoice()
	 * @generated
	 */
	void setPreviousChoice(Choice value);

	/**
	 * Returns the value of the '<em><b>Selected Next Choice</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Selected Next Choice</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Selected Next Choice</em>' reference.
	 * @see #setSelectedNextChoice(Choice)
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_SelectedNextChoice()
	 * @model
	 * @generated
	 */
	Choice getSelectedNextChoice();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getSelectedNextChoice <em>Selected Next Choice</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Selected Next Choice</em>' reference.
	 * @see #getSelectedNextChoice()
	 * @generated
	 */
	void setSelectedNextChoice(Choice value);

	/**
	 * Returns the value of the '<em><b>Branch</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Branch#getChoices <em>Choices</em>}'.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Branch</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Branch</em>' reference.
	 * @see #setBranch(Branch)
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Gemoc_execution_tracePackage#getChoice_Branch()
	 * @see org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Branch#getChoices
	 * @model opposite="choices" required="true"
	 * @generated
	 */
	Branch getBranch();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.reflectivetrace.gemoc_execution_trace.Choice#getBranch <em>Branch</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Branch</em>' reference.
	 * @see #getBranch()
	 * @generated
	 */
	void setBranch(Branch value);

} // Choice
