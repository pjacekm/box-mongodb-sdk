/**
* @author pjacekm@gmail.com
* @description I represent org.bson.BsonInt64. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonInt64" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBsonInt64();
	}




	public function onDIComplete() {
		return this;
	}




	
	/**
	 * Initializes with provided number.
	 *
	 * @number 
	 */
	function initWithNumber(required numeric number){
		setBsonInt64(
			getJavaFactory().getJavaObject("org.bson.BsonInt64").init(arguments.number)
		);
		
		return this;
	}




	/**
	 * Returns the value of the specified number as a double, which may involve rounding.
	 */
	public function doubleValue() {
		return getBsonInt64().doubleValue();
	}




	/**
	 * Returns the value of the specified number as an int, which may involve rounding or truncation.
	 */
	public function intValue() {
		return getBsonInt64().intValue();
	}




	
	/**
	 * Returns the value of the specified number as an long, which may involve rounding or truncation.
	 */
	public function longValue() {
		return getBsonInt64().longValue();
	}




	/**
	 * Gets the integer value.
	 */
	public function getValue() {
		return getBsonInt64().getValue();
	}
	
}
