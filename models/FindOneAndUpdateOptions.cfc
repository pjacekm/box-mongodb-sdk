/**
* Wrapper for com.mongodb.client.model.FindOneAndUpdateOptions.
* The options to apply to an operation that atomically finds a document and updates it.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="FindOneAndUpdateOptions" type="any";
	
	
	function init(){
		return this;
	}




	FindOneAndUpdateOptions function onDIComplete(){
		setFindOneAndUpdateOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.FindOneAndUpdateOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getFindOneAndUpdateOptions();
	}




	/**
	 * Sets a document describing the fields to return for all matching documents..
	 *
	 * @projection The project document, which may be null.
	 */
	FindOneAndUpdateOptions function projection(required Document projection){
		getFindOneAndUpdateOptions().projection(
			arguments.projection.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets a document describing the fields to return for all matching documents.
	 */
	public Document function getProjection(){
		return getBsonFactory().Document(
			getFindOneAndUpdateOptions().getProjection()
		);
	}




	/**
	 * Sets the sort criteria to apply to the query.
	 *
	 * @sort The sort criteria, which may be null.
	 */
	FindOneAndUpdateOptions function sort(required Document sort){
		getFindOneAndUpdateOptions().sort(
			arguments.sort.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the sort criteria to apply to the query. 
	 * The default is null, which means that the documents will be returned in an undefined order.
	 */
	public Document function getSort(){
		return getBsonFactory().Document(
			getFindOneAndUpdateOptions().getSort()
		);
	}




	/**
	 * Set to true if a new document should be inserted if there are no matches to the query filter.
	 *
	 * @upsert True if a new document should be inserted if there are no matches to the query filter
	 */
	FindOneAndUpdateOptions function upsert(required boolean upsert){
		getFindOneAndUpdateOptions().upsert(
			javaCast("boolean", arguments.upsert)
		)
		return this;
	}




	/**
	 * Returns true if a new document should be inserted if there are no matches to the query filter. The default is false.
	 */
	boolean function isUpsert(){
		return getFindOneAndUpdateOptions().isUpsert();
	}




	/**
	 * Set whether to return the document before it was updated / inserted or after
	 * NOTE: the behavior differs from the original Java driver: receives enum value instead of enum object.
	 *
	 * @returnDocument One of the following (case sensitive):
	 * - BEFORE
	 * - AFTER
	 */
	FindOneAndUpdateOptions function returnDocument(required string returnDocument){
		getFindOneAndUpdateOptions().returnDocument(
			getJavaFactory().getJavaObject("com.mongodb.client.model.ReturnDocument").valueOf(
				javaCast("string", arguments.returnDocument)
			)
		)
		return this;
	}




	/**
	 * Gets the ReturnDocument value indicating whether to return the document before it was updated / inserted or after.
	 * NOTE: the behavior differs from the original Java driver: returns enum value instead of enum object.
	 */
	string function getReturnDocument(){
		return getFindOneAndUpdateOptions().getReturnDocument().name()
	}




	/**
	 * Sets the maximum execution time on the server for this operation.
	 *
	 * @maxTime Number
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public function maxTime(required numeric maxTime, required TimeUnit timeUnit){
		getFindOneAndUpdateOptions().maxTime(
			javaCast("long", arguments.maxTime),
			arguments.timeUnit.getTimeUnit()
		);
		return this;
	}




	/**
	 * Gets the maximum execution time on the server for this operation. The default is 0, which places no limit on the execution time.
	 *
	 * @timeUnit The time unit to return the result in
	 */
	public numeric function getMaxTime(required TimeUnit timeUnit){
		return getFindOneAndUpdateOptions().getMaxTime(
			arguments.timeUnit.getTimeUnit()
		);
	}




	/**
	 * Sets the bypass document level validation flag.
	 *
	 * @bypassDocumentValidation If true, allows the write to opt-out of document level validation.
	 */
	FindOneAndUpdateOptions function bypassDocumentValidation(required boolean bypassDocumentValidation){
		getFindOneAndUpdateOptions().bypassDocumentValidation(
			javaCast("boolean", arguments.bypassDocumentValidation)
		)
		return this;
	}




	/**
	 * Gets the the bypass document level validation flag
	 */
	boolean function getBypassDocumentValidation(){
		return getFindOneAndUpdateOptions().getBypassDocumentValidation();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	FindOneAndUpdateOptions function collation(required Collation collation){
		getFindOneAndUpdateOptions().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	Collation function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getFindOneAndUpdateOptions().getCollation()
		)
	}




	/**
	 * Sets the array filters option
	 *
	 * @arrayFilters The array filters 
	 */
	FindOneAndUpdateOptions function arrayFilters(required Document[] arrayFilters){
		getFindOneAndUpdateOptions().arrayFilters(
			getUtil().toMongo(
				arguments.arrayFilters
			)
		);
		return this;
	}




	/**
	 * Returns the array filters option
	 */
	array function getArrayFilters(){
		return getUtil().toCF(
			getFindOneAndUpdateOptions().getArrayFilters()
		);
	}




	/**
	 * Sets the hint to apply.
	 *
	 * @hint A document describing the index which should be used for this operation.
	 */
	FindOneAndUpdateOptions function hint(required Document hint){
		getFindOneAndUpdateOptions().hint(
			arguments.hint.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the hint to apply.
	 */
	public Document function getHint(){
		return getBsonFactory().Document(
			getFindOneAndUpdateOptions().getHint()
		);
	}




	/**
	 * Sets the hint to apply. Note: If hint(Document) is set that will be used instead of any hint string.
	 *
	 * @hint The name of the index which should be used for the operation
	 */
	FindOneAndUpdateOptions function hintString(required string hint){
		getFindOneAndUpdateOptions().hintString(
			javaCast("string", arguments.hint)
		);
		return this;
	}




	/**
	 * Gets the hint string to apply.
	 */
	public string function getHintString(){
		return getFindOneAndUpdateOptions().getHintString();
	}




	/**
	 * 
	 */
	public string function toString(){
		return getFindOneAndUpdateOptions().toString();
	}

}
