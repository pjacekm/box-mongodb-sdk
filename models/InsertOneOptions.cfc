/**
* Wrapper for com.mongodb.client.model.InsertOneOptions.
* Carries the options for a InsertOne operation.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="InsertOneOptions" type="any";

	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setInsertOneOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.InsertOneOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getInsertOneOptions();
	}




	/**
	 * Sets the bypass document level validation flag.
	 *
	 * @bypassDocumentValidation If true, allows the write to opt-out of document level validation.
	 */
	function bypassDocumentValidation(required boolean bypassDocumentValidation){
		getInsertOneOptions().bypassDocumentValidation(
			javaCast("boolean", arguments.bypassDocumentValidation)
		);

		return this;
	}




	/**
	 * Gets the the bypass document level validation flag
	 */
	boolean function getBypassDocumentValidation(){
		return getInsertOneOptions().getBypassDocumentValidation();
	}
}
