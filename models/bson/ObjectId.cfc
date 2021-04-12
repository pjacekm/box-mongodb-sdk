/**
*
* @author pjacekm@gmail.com
* @description I represent org.bson.types.ObjectId. 
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="ObjectId" type="any";


	/**
	 * Inits default _id
	 */	
	public function initEmpty() {
		setObjectId(
			getJavaFactory().getJavaObject("org.bson.types.ObjectId")
		);

		return this;
	}




	/**
	 * Inits with given _id
	 */	
	public function initWithId(required string _id) {
		setObjectId(
			getJavaFactory().getJavaObject("org.bson.types.ObjectId").init( javaCast("string", arguments["_id"]) )
		);

		return this;
	}




	/**
	 * Inits with org.bson.BsonObjectId
	 */	
	public function initWithBsonObjectId(required any BsonObjectId) {
		setObjectId(
			arguments.BsonObjectId.getValue()
		);

		return this;
	}




	/**
	 * Inits with org.bson.types.ObjectId
	 */	
	public function initWithObjectId(required any ObjectId) {
		setObjectId(
			arguments.ObjectId
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getObjectId();
	}




	public function onDIComplete() {
		return this;
	}




	public string function toString() {
		return getObjectId().toString();
	}




	public string function toHexString() {
		return getObjectId().toHexString();
	}




	public date function getDate() {
		return getObjectId().getDate();
	}




	public numeric function getTimestamp() {
		return getObjectId().getTimestamp();
	}




	public boolean function isValid(required string hexString) {
		return getObjectId().isValid(arguments.hexString);
	}
}
