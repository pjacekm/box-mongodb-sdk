/**
* I represent org.bson.BsonTimestamp. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonTimestamp" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getBsonTimestamp();
	}




	/**
	 * Construct a new instance with a null time and a 0 increment.
	 */
	function initEmpty(){
		setBsonTimestamp(
			getJavaFactory().getJavaObject("org.bson.BsonTimestamp").init()
		);
		return this;
	}




	/**
	 * Construct a new instance for the given value, which combines the time in seconds and the increment as a single long value.
	 *
	 * @value The timetamp as a single long value
	 */
	function initWithLong(required numeric value){
		setBsonTimestamp(
			getJavaFactory().getJavaObject("org.bson.BsonTimestamp").init(
				javaCast("long", arguments.value)
			)
		);
		return this;
	}
	
	
	
	
	/**
	 * Construct a new instance for the given time and increment.
	 *
	 * @seconds The number of seconds since the epoch
	 * @increment The increment
	 */
	function initWithSecondsAndInc(required numeric seconds, required numeric increment){
		setBsonTimestamp(
			getJavaFactory().getJavaObject("org.bson.BsonTimestamp").init(
				javaCast("int", arguments.seconds),
				javaCast("int", arguments.increment)
			)
		);
		return this;
	}




	/**
	 * Gets the value of the timestamp.
	 */
	numeric function getValue(){
		return getBsonTimestamp().getValue();
	}




	/**
	 * Gets the time in seconds since epoch.
	 */
	numeric function getTime(){
		return getBsonTimestamp().getTime();
	}




	/**
	 * Gets the increment value.
	 */
	numeric function getInc(){
		return getBsonTimestamp().getInc();
	}




	string function toString(){
		return getBsonTimestamp().toString();
	}
}
