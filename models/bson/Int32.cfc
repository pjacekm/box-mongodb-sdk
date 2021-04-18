/**
* @author pjacekm@gmail.com
* @description I represent org.bson.BsonInt32. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonInt32" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBsonInt32();
	}




	public function onDIComplete() {
		return this;
	}




	
	/**
	 * Initializes with provided number.
	 *
	 * @number 
	 */
	Int32 function initWithNumber(required numeric number){
		setBsonInt32(
			getJavaFactory().getJavaObject("org.bson.BsonInt32").init(arguments.number)
		);
		
		return this;
	}




	/**
	 * Initializes with provided Java BsonInt32 object
	 *
	 * @BsonInt32 
	 */
	Int32 function initWithBsonInt32(required BsonInt32){
		setBsonInt32(
			arguments.BsonInt32
		);
		
		return this;
	}




	/**
	 * Returns the value of the specified number as a double, which may involve rounding.
	 */
	public function doubleValue() {
		return getBsonInt32().doubleValue();
	}




	/**
	 * Returns the value of the specified number as an int, which may involve rounding or truncation.
	 */
	public function intValue() {
		return getBsonInt32().intValue();
	}




	
	/**
	 * Returns the value of the specified number as an long, which may involve rounding or truncation.
	 */
	public function longValue() {
		return getBsonInt32().longValue();
	}




	/**
	 * Gets the integer value.
	 */
	public function getValue() {
		return getBsonInt32().getValue();
	}
	
}
