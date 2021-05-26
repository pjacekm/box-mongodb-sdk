/**
*
* @author pjacekm@gmail.com
* @description Iterable for change streams.
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="ChangeStreamIterable" type="any" default="";

	/**
	* Sets the number of documents to return per batch
	*/
	public ChangeStreamIterable function batchSize(required numeric batchSize){
		getChangeStreamIterable().batchSize(
			javacast("int", arguments.batchSize)
		);
		return this;
	}



	/**
	 * Sets the collation options 
	 *
	 * @collation 
	 */
	public ChangeStreamIterable function collation(required Collation collation) {
		getChangeStreamIterable().collation(arguments.collation.build());
		return this;
	}



	/**
	 * Returns a cursor used for iterating over elements of type ChangeStreamDocument
	 */
	public MongoChangeStreamCursor function cursor() {
		return getWirebox()
			.getInstance("MongoChangeStreamCursor@box-mongodb-sdk")
			.setMongoCursor(
				getChangeStreamIterable().cursor()
			);
	}



	/**
	* Sets the maximum amount of time for the server to wait on new documents to satisfy a tailable cursor query.
	* @timeUnit literal constant name, as described in https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeUnit.html?is-external=true
	*/
	public ChangeStreamIterable function maxAwaitTime(required numeric maxAwaitTime, required string timeUnit) {
		var tuObj=getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit");
		var tu=tuObj[uCase(arguments.timeUnit)];
		getChangeStreamIterable().maxAwaitTime(javacast("long", arguments.maxAwaitTime), tu);
		return this;
	}



	
	/**
	 * Sets the logical starting point for the new change stream.
	 *
	 * @resumeToken 
	 */
	public ChangeStreamIterable function resumeAfter(required Document resumeToken) {
		getChangeStreamIterable().resumeAfter(
			arguments.resumeToken.toBsonDocument()
		);
		return this;
	}



	/**
	 * Similar to resumeAfter, this option takes a resume token and starts a new change stream returning the first notification after the token.
	 *
	 * @startAfter 
	 */
	public ChangeStreamIterable function startAfter(required Document startAfter) {
		getChangeStreamIterable().resumeAfter(
			arguments.startAfter.toBsonDocument()
		);
		return this;
	}



	/**
	 * The change stream will only provide changes that occurred at or after the specified timestamp.
	 *
	 * @startAtOperationTime timestamp (long)
	 */
	public ChangeStreamIterable function startAtOperationTime(required numeric startAtOperationTime) {
		var BsonTimestamp=getJavaFactory().getJavaObject("org.bson.BsonTimestamp").init(
			javaCast("long", arguments.startAtOperationTime)
		);

		getChangeStreamIterable().startAtOperationTime(
			getUtil().toBsonDocument(BsonTimestamp)
		);

		return this;
	}
}
