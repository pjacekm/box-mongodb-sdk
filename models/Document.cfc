/**
*
* @author pjacekm@gmail.com
* @description I represent org.bson.Document
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="MongoDocument" type="any" default="";

	public function init(){
		return this;
	}




	public function onDIComplete() {
		// Initialize complex values
		setMongoDocument(
			getJavaFactory().getJavaObject("org.bson.Document")
		);
		return this;
	}




	public Document function append(required string key, required any value) {
		getMongoDocument().append(
			arguments.key, 
			getUtil().mapToMongo(arguments.value)
		);
		return this;
	}




	public Document function parse(required string json) {
		getMongoDocument().parse(arguments.json);
		return this;
	}




	public any function get(required string key) {
		return getMongoDocument().get(arguments.key);
	}




	public void function put(required string key, required any value) {
		getMongoDocument().put(arguments.key, arguments.value);
	}




	public void function clear() {
		getMongoDocument().clear();
	}




	public void function remove(required string key) {
		getMongoDocument().remove(arguments.key);
	}




	public numeric function size() {
		return getMongoDocument().size();
	}




	public boolean function isEmpty() {
		return getMongoDocument().isEmpty();
	}
}
