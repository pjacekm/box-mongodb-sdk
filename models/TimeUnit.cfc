/**
* CF wrapper for the java.util.concurrent.TimeUnit.
* Use one of the method described as CONSTRUCTOR - they represent original java object ENUMs.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="TimeUnit" type="any";
	property name="CurrentValue" type="string";


	public any function onDIComplete(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getTimeUnit();
	}




	/**
	 * CONSTRUCTOR: Returns Time Unit representing twenty four hours.
	 */
	public any function DAYS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").DAYS
		);
		setCurrentValue("DAYS");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing sixty minutes.
	 */
	public any function HOURS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").HOURS
		);
		setCurrentValue("HOURS");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing one thousandth of a millisecond.
	 */
	public any function MICROSECONDS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").MICROSECONDS
		);
		setCurrentValue("MICROSECONDS");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing one thousandth of a second.
	 */
	public any function MILLISECONDS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").MILLISECONDS
		);
		setCurrentValue("MILLISECONDS");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing sixty seconds.
	 */
	public any function MINUTES() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").MINUTES
		);
		setCurrentValue("MINUTES");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing one thousandth of a microsecond.
	 */
	public any function NANOSECONDS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").NANOSECONDS
		);
		setCurrentValue("NANOSECONDS");
		return this;
	}




	/**
	 * CONSTRUCTOR: Returns Time unit representing one second.
	 */
	public any function SECONDS() {
		setTimeUnit(
			getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit").SECONDS
		);
		setCurrentValue("SECONDS");
		return this;
	}










}
