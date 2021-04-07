/**
* @author pjacekm@gmail.com
* @description I represent java.time.ZonedDateTime. I help with date-time-zone handling in non-ambiguous fashion.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="ZonedDateTime" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object converted to object understood by MongoDB. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getZonedDateTime().toInstant();
	}




	public function onDIComplete() {
		return this;
	}




	/**
	 * Inits the object with now()
	 */
	public function initWithNow() {
		setZonedDateTime(
			getJavaFactory().getJavaObject("java.time.ZonedDateTime").now()
		)
		return this;
	}




	/**
	 * Inits the object with a CF datetime object
	 */
	public function initWithCFDateTime(required date cfDateTime) {
		setZonedDateTime(
			getJavaFactory().getJavaObject("java.time.ZonedDateTime").of(
				arguments.cfDateTime.year(),
				arguments.cfDateTime.month(),
				arguments.cfDateTime.day(),
				arguments.cfDateTime.hour(),
				arguments.cfDateTime.minute(),
				arguments.cfDateTime.second(),
				0,
				getJavaFactory().getJavaObject("java.time.ZoneId").ofOffset( 
					"UTC",
					getJavaFactory().getJavaObject("java.time.ZoneOffset").of(
						arguments.cfDateTime.dateTimeFormat("Z") 
					)
				)
			)
		)
		return this;
	}




	/**
	 * Inits the object with a string
	 */
	public function initWithString(required string text) {
		setZonedDateTime(
			getJavaFactory().getJavaObject("java.time.ZonedDateTime").parse(
				javaCast("string", arguments.text)
			)
		)
		return this;
	}




	
	/**
	 * index
	 */
	public string function toString(){
		return getZonedDateTime().toString();
	}
	
}
