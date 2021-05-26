/**
* Wrapper for com.mongodb.client.model.ReplaceOptions.
* The options to apply to an operation that atomically finds a document and updates it.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="ReplaceOptions" type="any";
	
	
	function init(){
		return this;
	}




	ReplaceOptions function onDIComplete(){
		setReplaceOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.ReplaceOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getReplaceOptions();
	}




	/**
	 * Set to true if a new document should be inserted if there are no matches to the query filter.
	 *
	 * @upsert True if a new document should be inserted if there are no matches to the query filter
	 */
	ReplaceOptions function upsert(required boolean upsert){
		getReplaceOptions().upsert(
			javaCast("boolean", arguments.upsert)
		)
		return this;
	}




	/**
	 * Returns true if a new document should be inserted if there are no matches to the query filter. The default is false.
	 */
	boolean function isUpsert(){
		return getReplaceOptions().isUpsert();
	}




	/**
	 * Sets the bypass document level validation flag.
	 *
	 * @bypassDocumentValidation If true, allows the write to opt-out of document level validation.
	 */
	ReplaceOptions function bypassDocumentValidation(required boolean bypassDocumentValidation){
		getReplaceOptions().bypassDocumentValidation(
			javaCast("boolean", arguments.bypassDocumentValidation)
		)
		return this;
	}




	/**
	 * Gets the the bypass document level validation flag
	 */
	boolean function getBypassDocumentValidation(){
		return getReplaceOptions().getBypassDocumentValidation();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	ReplaceOptions function collation(required Collation collation){
		getReplaceOptions().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	Collation function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getReplaceOptions().getCollation()
		)
	}




	/**
	 * Sets the hint to apply.
	 *
	 * @hint A document describing the index which should be used for this operation.
	 */
	ReplaceOptions function hint(required Document hint){
		getReplaceOptions().hint(
			arguments.hint.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the hint to apply.
	 */
	public Document function getHint(){
		return getBsonFactory().Document(
			getReplaceOptions().getHint()
		);
	}




	/**
	 * Sets the hint to apply. Note: If hint(Document) is set that will be used instead of any hint string.
	 *
	 * @hint The name of the index which should be used for the operation
	 */
	ReplaceOptions function hintString(required string hint){
		getReplaceOptions().hintString(
			javaCast("string", arguments.hint)
		);
		return this;
	}




	/**
	 * Gets the hint string to apply.
	 */
	public string function getHintString(){
		return getReplaceOptions().getHintString();
	}




	/**
	 * 
	 */
	public string function toString(){
		return getReplaceOptions().toString();
	}

}
