/**
* @author pjacekm@gmail.com
* @description I represent org.bson.BsonNull. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonNull" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBsonNull();
	}




	public function onDIComplete() {
		setBsonNull(
			getJavaFactory().getJavaObject("org.bson.BsonNull").init()
		);
		return this;
	}




	
	public function toString() {
		return getBsonNull().toString();
	}
	
}
