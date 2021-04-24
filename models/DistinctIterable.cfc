/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" extends="MongoIterable" accessors="true" {
	public DistinctIterable function batchSize(required numeric batchSize) {
		getMongoIterable().batchSize(javacast("int", arguments.batchSize));
		return this;
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	public DistinctIterable function collation(required Collation collation){
		getMongoIterable().collation(
			arguments.collation.getMongoCollation()
		);
		return this;
	}




	/**
	 * Sets the query filter to apply to the query.
	 *
	 * @filter The filter, which may be Document, struct or Null
	 */
	public DistinctIterable function filter(required filter) {
		getMongoIterable().filter(
			getUtil().toMongo(arguments.filter)
		);
		return this;
	}
	
	
	
	/**
	* Sets the maximum execution time on the server for this operation.
	* @timeUnit literal constant name, as described in https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/TimeUnit.html?is-external=true
	*/
	public DistinctIterable function maxTime(required numeric maxTime, required string timeUnit) {
		var tuObj=getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit");
		var tu=tuObj[arguments.timeUnit];
		getMongoIterable().maxTime(javacast("long", arguments.maxTime), tu);
		return this;
	}
}
