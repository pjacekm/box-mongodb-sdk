/**
* Wrapper for com.mongodb.client.model.FindOneAndDeleteOptions.
* Carries the options for a findOneAndDelete operation.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="FindOneAndDeleteOptions" type="any";
	
	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setFindOneAndDeleteOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.FindOneAndDeleteOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getFindOneAndDeleteOptions();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	public any function collation(required Collation collation){
		getFindOneAndDeleteOptions().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	public function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getFindOneAndDeleteOptions().getCollation()
		)
	}




	/**
	 * Sets the hint to apply.
	 *
	 * @hint A document describing the index which should be used for this operation.
	 */
	public any function hint(required Document hint){
		getFindOneAndDeleteOptions().hint(
			arguments.hint.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the hint to apply.
	 */
	public Document function getHint(){
		return getBsonFactory().Document(
			getFindOneAndDeleteOptions().getHint()
		);
	}




	/**
	 * Sets the hint to apply. Note: If hint(Document) is set that will be used instead of any hint string.
	 *
	 * @hint The name of the index which should be used for the operation
	 */
	public any function hintString(required string hint){
		getFindOneAndDeleteOptions().hintString(
			javaCast("string", arguments.hint)
		);
		return this;
	}




	/**
	 * Gets the hint string to apply.
	 */
	public string function getHintString(){
		return getFindOneAndDeleteOptions().getHintString();
	}




	/**
	 * Sets the maximum execution time on the server for this operation.
	 *
	 * @maxTime Number
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public function maxTime(required numeric maxTime, required TimeUnit timeUnit){
		getFindOneAndDeleteOptions().maxTime(
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
		return getFindOneAndDeleteOptions().getMaxTime(
			arguments.timeUnit.getTimeUnit()
		);
	}




	/**
	 * Sets a document describing the fields to return for all matching documents..
	 *
	 * @projection The project document, which may be null.
	 */
	public any function projection(required Document projection){
		getFindOneAndDeleteOptions().projection(
			arguments.projection.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets a document describing the fields to return for all matching documents.
	 */
	public Document function getProjection(){
		return getBsonFactory().Document(
			getFindOneAndDeleteOptions().getProjection()
		);
	}




	/**
	 * Sets the sort criteria to apply to the query.
	 *
	 * @sort The sort criteria, which may be null.
	 */
	public any function sort(required Document sort){
		getFindOneAndDeleteOptions().sort(
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
			getFindOneAndDeleteOptions().getSort()
		);
	}




	/**
	 * 
	 */
	public string function toString(){
		return getFindOneAndDeleteOptions().toString();
	}





}
