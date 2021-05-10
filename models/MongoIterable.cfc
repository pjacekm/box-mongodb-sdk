/**
*
* @author pjacekm@gmail.com
* @description Encapsulates MongoDB responses
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";
	//property name="Util" inject="Util@box-mongodb-sdk";
	//property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";

	// Local properties
	property name="MongoIterable" type="any" default="";

	public function init(){
		return this;
	}




	public function forEach(required fn) {
		return getMongoIterable().forEach(arguments.fn);
	}




	public MongoCursor function iterator() {
		return getWirebox().getInstance("MongoCursor@box-mongodb-sdk").setMongoCursor(
			getMongoIterable().iterator() 
		);
	}




	public MongoCursor function cursor() {
		return getWirebox().getInstance("MongoCursor@box-mongodb-sdk").setMongoCursor(
			getMongoIterable().cursor() 
		);
	}




	/**
	* Sets the number of documents to return per batch
	*/
	public MongoIterable function batchSize(required numeric batchSize){
		getMongoIterable().batchSize(
			javacast("int", arguments.batchSize)
		);
		return this;
	}




	/**
	 * Converts result to array
	 */
	public array function toArray() {
		var response=[];
		var cursor=getMongoIterable().iterator();

		while(cursor.hasNext()){
			response.append(
				BsonFactory.Document().setMongoDocument(
					cursor.next()
				)
			)
		}

		cursor.close();

		return response;
	}
}
