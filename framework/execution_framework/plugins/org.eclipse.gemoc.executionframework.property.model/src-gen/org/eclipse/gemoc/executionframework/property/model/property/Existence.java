/**
 */
package org.eclipse.gemoc.executionframework.property.model.property;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Existence</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link org.eclipse.gemoc.executionframework.property.model.property.Existence#getMin <em>Min</em>}</li>
 *   <li>{@link org.eclipse.gemoc.executionframework.property.model.property.Existence#getMax <em>Max</em>}</li>
 * </ul>
 *
 * @see org.eclipse.gemoc.executionframework.property.model.property.PropertyPackage#getExistence()
 * @model
 * @generated
 */
public interface Existence extends TemporalProperty {
	/**
	 * Returns the value of the '<em><b>Min</b></em>' attribute.
	 * The default value is <code>"1"</code>.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Min</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Min</em>' attribute.
	 * @see #setMin(int)
	 * @see org.eclipse.gemoc.executionframework.property.model.property.PropertyPackage#getExistence_Min()
	 * @model default="1" required="true"
	 * @generated
	 */
	int getMin();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.property.model.property.Existence#getMin <em>Min</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Min</em>' attribute.
	 * @see #getMin()
	 * @generated
	 */
	void setMin(int value);

	/**
	 * Returns the value of the '<em><b>Max</b></em>' attribute.
	 * The default value is <code>"1"</code>.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Max</em>' attribute isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Max</em>' attribute.
	 * @see #setMax(int)
	 * @see org.eclipse.gemoc.executionframework.property.model.property.PropertyPackage#getExistence_Max()
	 * @model default="1" required="true"
	 * @generated
	 */
	int getMax();

	/**
	 * Sets the value of the '{@link org.eclipse.gemoc.executionframework.property.model.property.Existence#getMax <em>Max</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Max</em>' attribute.
	 * @see #getMax()
	 * @generated
	 */
	void setMax(int value);

} // Existence
