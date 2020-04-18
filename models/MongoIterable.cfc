/**
*
* @author pjacekm@gmail.com
* @description Encapsulates MongoDB responses
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";

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
		return getUtil().mongoIterableToArray( getMongoIterable() );
	}
}
