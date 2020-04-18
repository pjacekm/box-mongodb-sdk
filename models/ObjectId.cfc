/**
*
* @author pjacekm@gmail.com
* @description I represent org.bson.types.ObjectId
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="ObjectId" type="any" default="";
	property name="_id" type="string" default="";

	public function init(string _id="") {
		set_id(arguments["_id"]);
		return this;
	}




	public function onDIComplete() {
		// Initialize complex values
		if( len( get_id() ) ){
			setObjectId(
				getJavaFactory().getJavaObject("org.bson.types.ObjectId").init( get_id() )
			);
		}
		else{
			setObjectId(
				getJavaFactory().getJavaObject("org.bson.types.ObjectId").init()
			);
		}
		
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
