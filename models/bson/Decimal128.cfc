/**
* @author pjacekm@gmail.com
* @description I represent org.bson.types.Decimal128 - a binary integer decimal representation of a 128-bit decimal value, supporting 34 decimal digits of significand and an exponent range of -6143 to +6144.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="Decimal128" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getDecimal128();
	}




	public function onDIComplete() {
		return this;
	}




	
	/**
	 * Initializes with provided string.
	 * Parses provided string using org.bson.types.Decimal128's native parse() method
	 *
	 * @number 
	 */
	function initWithString(required string number){
		switch(arguments.number){
			case "POSITIVE_INFINITY":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").POSITIVE_INFINITY
				);
			break;

			case "NEGATIVE_INFINITY":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").NEGATIVE_INFINITY
				);
			break;

			case "NaN":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").NaN
				);
			break;

			case "NEGATIVE_NaN":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").NEGATIVE_NaN
				);
			break;

			case "POSITIVE_ZERO":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").POSITIVE_ZERO
				);
			break;

			case "NEGATIVE_ZERO":
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").NEGATIVE_ZERO
				);
			break;
		
			default:
				setDecimal128(
					getJavaFactory().getJavaObject("org.bson.types.Decimal128").parse(arguments.number)
				);
			break;
		}
		
		return this;
	}




	/**
	 * Initializes with Java BigDecimal object
	 *
	 * @BigDecimal 
	 */
	public function initWithBigDecimal(required BigDecimal){
		setDecimal128(
			getJavaFactory().getJavaObject("org.bson.types.Decimal128").init(arguments.BigDecimal)
		);
		return this;
	}
	



	/**
	 * Converts this Decimal128 to a double.
	 */
	public function doubleValue() {
		return getDecimal128().doubleValue();
	}




	/**
	 * Converts this Decimal128 to a float.
	 */
	public function floatValue() {
		return getDecimal128().floatValue();
	}




	/**
	 * Converts this Decimal128 to a int.
	 */
	public function intValue() {
		return getDecimal128().intValue();
	}




	/**
	 * Returns true if this Decimal128 is finite.
	 */
	public boolean function isFinite() {
		return getDecimal128().isFinite();
	}




	/**
	 * Returns true if this Decimal128 is infinite.
	 */
	public boolean function isInfinite() {
		return getDecimal128().isInfinite();
	}




	/**
	 * Returns true if this Decimal128 is Not-A-Number (NaN).
	 */
	public boolean function isNaN() {
		return getDecimal128().isNaN();
	}




	/**
	 * Returns true if this Decimal128 is negative.
	 */
	public boolean function isNegative() {
		return getDecimal128().isNegative();
	}




	/**
	 * Converts this Decimal128 to a long.
	 */
	public function longValue() {
		return getDecimal128().longValue();
	}
	
}
