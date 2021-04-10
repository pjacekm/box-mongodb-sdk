/**
* Wrapper for com.mongodb.client.model.CountOptions.
* Carries the options for a count operation.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="CountOptions" type="any";
	
	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setCountOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.CountOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getCountOptions();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	public any function collation(required Collation collation){
		getCountOptions().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	public function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getCountOptions().getCollation()
		)
	}




	/**
	 * Sets the maximum execution time on the server for this operation.
	 *
	 * @maxTime Number
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public function maxTime(required numeric maxTime, required TimeUnit timeUnit){
		getCountOptions().maxTime(
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
		return getCountOptions().getMaxTime(
			arguments.timeUnit.getTimeUnit()
		);
	}




	/**
	 * Sets the hint to apply.
	 *
	 * @hint A document describing the index which should be used for this operation.
	 */
	public any function hint(required Document hint){
		getCountOptions().hint(
			arguments.hint.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the hint to apply.
	 */
	public Document function getHint(){
		return getBsonFactory().Document(
			getCountOptions().getHint()
		);
	}




	/**
	 * Sets the hint to apply. Note: If hint(Document) is set that will be used instead of any hint string.
	 *
	 * @hint The name of the index which should be used for the operation
	 */
	public any function hintString(required string hint){
		getCountOptions().hintString(
			javaCast("string", arguments.hint)
		);
		return this;
	}




	/**
	 * Gets the hint string to apply.
	 */
	public string function getHintString(){
		return getCountOptions().getHintString();
	}




	/**
	 * Sets the limit to apply.
	 *
	 * @limit The limit.
	 */
	public any function limit(required numeric limit){
		getCountOptions().limit(
			javaCast("int", arguments.limit)
		);
		return this;
	}




	/**
	 * Gets the limit to apply. The default is 0, which means there is no limit.
	 */
	public numeric function getLimit(){
		return getCountOptions().getLimit();
	}




	/**
	 * Sets the number of documents to skip.
	 *
	 * @skip The number of documents to skip
	 */
	public any function skip(required numeric skip){
		getCountOptions().skip(
			javaCast("int", arguments.skip)
		);
		return this;
	}




	/**
	 * Gets the number of documents to skip. The default is 0.
	 */
	public numeric function getSkip(){
		return getCountOptions().getSkip();
	}




	/**
	 * 
	 */
	public string function toString(){
		return getCountOptions().toString();
	}





}
