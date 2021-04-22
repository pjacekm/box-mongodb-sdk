/**
* Wrapper for com.mongodb.client.model.DeleteOptions.
* Carries the options for a delete operation.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="DeleteOptions" type="any";
	
	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setDeleteOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.DeleteOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getDeleteOptions();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	public any function collation(required Collation collation){
		getDeleteOptions().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	public function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getDeleteOptions().getCollation()
		)
	}




	/**
	 * Sets the hint to apply.
	 *
	 * @hint A document describing the index which should be used for this operation.
	 */
	public any function hint(required Document hint){
		getDeleteOptions().hint(
			arguments.hint.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the hint to apply.
	 */
	public Document function getHint(){
		return getBsonFactory().Document(
			getDeleteOptions().getHint()
		);
	}




	/**
	 * Sets the hint to apply. Note: If hint(Document) is set that will be used instead of any hint string.
	 *
	 * @hint The name of the index which should be used for the operation
	 */
	public any function hintString(required string hint){
		getDeleteOptions().hintString(
			javaCast("string", arguments.hint)
		);
		return this;
	}




	/**
	 * Gets the hint string to apply.
	 */
	public string function getHintString(){
		return getDeleteOptions().getHintString();
	}




	/**
	 * 
	 */
	public string function toString(){
		return getDeleteOptions().toString();
	}

}
