/**
* Wrapper for com.mongodb.client.model.MergeOptions.
* Options to control the behavior of the $merge aggregation stage
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="MergeOptions" type="any";


	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setMergeOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.MergeOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getMergeOptions();
	}




	/**
	 * Gets the fields that act as a unique identifier for a document. The identifier determine if a results document matches an already existing document in the output collection.
	 */
	array function getUniqueIdentifier(){
		return getMergeOptions().getUniqueIdentifier();
	}




	/**
	 * Sets the field that act as a unique identifier(s) for a document. 
	 * The identifier determine if a results document matches an already existing document in the output collection.
	 *
	 * @uniqueIdentifier The unique identifier (Array of strings or string)
	 */
	MergeOptions function uniqueIdentifier(required uniqueIdentifier){
		getMergeOptions().uniqueIdentifier(
			arguments.uniqueIdentifier
		)
		return this;
	}




	/**
	 * Gets the behavior of $merge if a result document and an existing document in the collection have the same value for the specified on field(s).
	 * NOTE: the behavior differs from the original Java driver: returns enum value (string) instead of enum object.
	 */
	function getWhenMatched(){
		if( isNull( getMergeOptions().getWhenMatched() ) ){
			return getMergeOptions().getWhenMatched();
		}
		else{
			return getMergeOptions().getWhenMatched().name();
		}
	}




	/**
	 * Sets the behavior of $merge if a result document and an existing document in the collection have the same value for the specified on field(s).
	 * NOTE: the behavior differs from the original Java driver: receives enum value instead of enum object.
	 *
	 * @whenMatched One of the following (case sensitive):
	 * - REPLACE
	 * - KEEP_EXISTING
	 * - MERGE
	 * - PIPELINE
	 * - FAIL
	 */
	MergeOptions function whenMatched(required string whenMatched){
		getMergeOptions().whenMatched(
			getJavaFactory().getJavaObject("com.mongodb.client.model.MergeOptions$WhenMatched").valueOf(
				javaCast("string", arguments.whenMatched)
			)
		);
		return this;
	}




	/**
	 * Gets the behavior of $merge if a result document does not match an existing document in the out collection.
	 * NOTE: the behavior differs from the original Java driver: returns enum value (string) instead of enum object.
	 */
	function getWhenNotMatched(){
		if( isNull( getMergeOptions().getWhenNotMatched() ) ){
			return getMergeOptions().getWhenNotMatched();
		}
		else{
			return getMergeOptions().getWhenNotMatched().name();
		}
	}




	/**
	 * Sets the behavior of $merge if a result document does not match an existing document in the out collection.
	 * NOTE: the behavior differs from the original Java driver: receives enum value instead of enum object.
	 *
	 * @whenNotMatched One of the following (case sensitive):
	 * - DISCARD
	 * - FAIL
	 * - INSERT
	 */
	MergeOptions function whenNotMatched(required string whenNotMatched){
		getMergeOptions().whenNotMatched(
			getJavaFactory().getJavaObject("com.mongodb.client.model.MergeOptions$WhenNotMatched").valueOf(
				javaCast("string", arguments.whenNotMatched)
			)
		);
		return this;
	}




	/**
	 * Gets the variables accessible for use in the whenMatched pipeline
	 */
	Variable[] function getVariables(){
		return getUtil().toCF(
			getMergeOptions().getVariables()
		);
	}




	/**
	 * Sets the variables accessible for use in the whenMatched pipeline.
	 *
	 * @variables Array with the variables 
	 */
	MergeOptions function variables(required Variable[] variables){
		getMergeOptions().variables(
			getUtil().toMongo(
				arguments.variables
			)
		);
		return this;
	}




	/**
	 * Gets aggregation pipeline to update the document in the collection.
	 */
	function getWhenMatchedPipeline(){
		return getUtil().toCF(
			getMergeOptions().getWhenMatchedPipeline()
		);
	}




	/**
	 * Sets aggregation pipeline to update the document in the collection.
	 *
	 * @whenMatchedPipeline When matched pipeline
	 */
	MergeOptions function whenMatchedPipeline(required Document[] whenMatchedPipeline){
		getMergeOptions().whenMatchedPipeline(
			getUtil().toMongo(
				arguments.whenMatchedPipeline
			)
		);
		return this;
	}




	
}
