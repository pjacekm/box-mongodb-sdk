/**
* The update description for changed fields in a $changeStream operation.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="UpdateDescription" type="any" default="";

	public function init(){
		return this;
	}




	/**
	 * Returns the removedFields
	 */
	public array function getRemovedFields() {
		return getUtil().toCF(
			getUpdateDescription().getRemovedFields()
		);
	}




	/**
	 * Returns the updatedFields
	 */
	public struct function getUpdatedFields() {
		return getUtil().toCF(
			getUpdateDescription().getUpdatedFields()
		);
	}
}
