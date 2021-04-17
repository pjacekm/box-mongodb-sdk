/**
* Wrapper for com.mongodb.client.model.UnwindOptions.
* Carries the options for a count operation.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="UnwindOptions" type="any";
	
	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setUnwindOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.UnwindOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getUnwindOptions();
	}




	/**
	 * If true the unwind stage will include documents that have null values or empty arrays.
	 * Returns the preserve null values and empty arrays value or null
	 */
	boolean function isPreserveNullAndEmptyArrays(){
		return getUnwindOptions().isPreserveNullAndEmptyArrays();
	}




	/**
	 * Sets true if the unwind stage should include documents that have null values or empty arrays
	 *
	 * @preserveNullAndEmptyArrays Flag depicting if the unwind stage should include documents that have null values or empty arrays
	 */
	UnwindOptions function preserveNullAndEmptyArrays(required boolean preserveNullAndEmptyArrays){
		getUnwindOptions().preserveNullAndEmptyArrays(
			javaCast("boolean", arguments.preserveNullAndEmptyArrays)
		);
		return this;
	}




	/**
	 * Gets the includeArrayIndex field if set or null
	 */
	string function getIncludeArrayIndex(){
		return getUnwindOptions().getIncludeArrayIndex();
	}




	/**
	 * Sets the field to be used to store the array index of the unwound item
	 *
	 * @arrayIndexFieldName The field to be used to store the array index of the unwound item
	 */
	UnwindOptions function includeArrayIndex(required string arrayIndexFieldName){
		getUnwindOptions().includeArrayIndex(
			javaCast("string", arguments.arrayIndexFieldName)
		);
		return this;
	}




	/**
	 * 
	 */
	public string function toString(){
		return getUnwindOptions().toString();
	}





}
