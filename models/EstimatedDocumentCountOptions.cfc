/**
* Wrapper for com.mongodb.client.model.EstimatedDocumentCountOptions.
* Carries the options for a count operation.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="EstimatedDocumentCountOptions" type="any";
	
	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setEstimatedDocumentCountOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.EstimatedDocumentCountOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getEstimatedDocumentCountOptions();
	}




	/**
	 * Sets the maximum execution time on the server for this operation.
	 *
	 * @maxTime Number
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public function maxTime(required numeric maxTime, required TimeUnit timeUnit){
		getEstimatedDocumentCountOptions().maxTime(
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
		return getEstimatedDocumentCountOptions().getMaxTime(
			arguments.timeUnit.getTimeUnit()
		);
	}




	/**
	 * 
	 */
	public string function toString(){
		return getEstimatedDocumentCountOptions().toString();
	}





}
