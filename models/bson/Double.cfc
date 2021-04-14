/**
* @author pjacekm@gmail.com
* @description I represent org.bson.BsonDouble. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonDouble" type="any";


	function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getBsonDouble();
	}




	function onDIComplete() {
		return this;
	}




	
	/**
	 * Initializes with provided number.
	 *
	 * @number 
	 */
	function initWithNumber(required numeric number){
		setBsonDouble(
			getJavaFactory().getJavaObject("org.bson.BsonDouble").init(
				javaCast("double", arguments.number)
			)
		);
		
		return this;
	}




	/**
	 * Gets the double value.
	 */
	numeric function getValue(){
		return getBsonDouble().getValue();
	}




	/**
	 * Gets the double value.
	 */
	numeric function doubleValue(){
		return getBsonDouble().doubleValue();
	}




	/**
	 * Returns the value as Int32 wrapper, which may involve rounding or truncation.
	 */
	function intValue(){
		return getBsonFactory().Int32(
			getBsonDouble.intValue()
		);
	}




	/**
	 * Returns the value as Int64 wrapper, which may involve rounding or truncation.
	 */
	function longValue(){
		return getBsonFactory().Int64(
			getBsonDouble.longValue()
		);
	}




	/**
	 * Returns the value as Decimal128 wrapper, which may involve rounding.
	 */
	function decimal128Value(){
		return getBsonFactory().Decimal128(
			getBsonDouble.decimal128Value()
		);
	}
}
