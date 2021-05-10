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
	 * Inits the object with java.util.Date
	 * Taking advantage of the fact that it's decorated with CF-specific methods, like dateTimeFormat()
	 *
	 * @javaDate The java.util.Date object
	 */
	function initWithJavaDate(required javaDate){
		setZonedDateTime(
			getJavaFactory().getJavaObject("java.time.ZonedDateTime").ofInstant(
				arguments.javaDate.toInstant(),
				getJavaFactory().getJavaObject("java.time.ZoneId").ofOffset( 
					"UTC",
					getJavaFactory().getJavaObject("java.time.ZoneOffset").of(
						arguments.javaDate.dateTimeFormat("Z") 
					)
				)
			)
		);
		return this;
	}




	/**
	 * Inits the object with java.time.Instant
	 * Taking advantage of the fact that it's decorated with CF-specific methods, like dateTimeFormat()
	 *
	 * @javaInstant The java.time.Instant object
	 */
	function initWithJavaInstant(required javaInstant){
		setZonedDateTime(
			getJavaFactory().getJavaObject("java.time.ZonedDateTime").ofInstant(
				arguments.javaInstant,
				getJavaFactory().getJavaObject("java.time.ZoneId").of( 
					"Z"
				)
			)
		);
		return this;
	}




	/**
	 * Returns datetime object understood by CF (java.util.Date)
	 */
	date function toDate(){
		return getJavaFactory().getJavaObject("java.util.Date").from(
			getZonedDateTime().toInstant()
		);
	}




	/**
	 * Alias for toDate()
	 */
	date function toCFDateTime(){
		return toDate();
	}




	/**
	 * Returns date (converted to UTC) as ISO-8601-formatted string.
	 */
	string function toISO8601(){
		return getZonedDateTime().format(
			getJavaFactory().getJavaObject("java.time.format.DateTimeFormatter")["ISO_INSTANT"]
		)
	}




	/**
	 * Gets the year field. 
	 */
	numeric function getYear(){
		return getZonedDateTime().getYear();
	}




	/**
	 * Gets the month-of-year field from 1 to 12. 
	 */
	numeric function getMonthValue(){
		return getZonedDateTime().getMonthValue();
	}




	/**
	 * Gets the day-of-month field. 
	 */
	numeric function getDayOfMonth(){
		return getZonedDateTime().getDayOfMonth();
	}




	/**
	 * Gets the day-of-year field. 
	 * Returns the day-of-year, from 1 to 365, or 366 in a leap year 
	 */
	numeric function getDayOfYear(){
		return getZonedDateTime().getDayOfYear();
	}




	/**
	 * Gets the hour-of-day field.
	 * Returns the hour-of-day, from 0 to 23
	 */
	numeric function getHour(){
		return getZonedDateTime().getHour();
	}




	/**
	 * Gets the minute-of-hour field.
	 * Returns the minute-of-hour, from 0 to 59
	 */
	numeric function getMinute(){
		return getZonedDateTime().getMinute();
	}




	/**
	 * Gets the second-of-minute field.
	 * Returns the second-of-minute, from 0 to 59
	 */
	numeric function getSecond(){
		return getZonedDateTime().getSecond();
	}




	/**
	 * Gets the nano-of-second field.
	 * Returns the nano-of-second, from 0 to 999,999,999
	 */
	numeric function getNano(){
		return getZonedDateTime().getNano();
	}




	/**
	 * Adds years to current date
	 *
	 * @years The years to add, may be negative
	 */
	function plusYears(required numeric years){
		setZonedDateTime(
			getZonedDateTime().plusYears(
				javaCast("long", arguments.years)
			)
		);
		return this;
	}




	/**
	 * Adds months to current date
	 *
	 * @months The months to add, may be negative
	 */
	function plusMonths(required numeric months){
		setZonedDateTime(
			getZonedDateTime().plusMonths(
				javaCast("long", arguments.months)
			)
		);
		return this;
	}




	/**
	 * Adds weeks to current date
	 *
	 * @weeks The weeks to add, may be negative
	 */
	function plusWeeks(required numeric weeks){
		setZonedDateTime(
			getZonedDateTime().plusWeeks(
				javaCast("long", arguments.weeks)
			)
		);
		return this;
	}




	/**
	 * Adds days to current date
	 *
	 * @days The days to add, may be negative
	 */
	function plusDays(required numeric days){
		setZonedDateTime(
			getZonedDateTime().plusDays(
				javaCast("long", arguments.days)
			)
		);
		return this;
	}




	/**
	 * Adds hours to current date
	 *
	 * @hours The hours to add, may be negative
	 */
	function plusHours(required numeric hours){
		setZonedDateTime(
			getZonedDateTime().plusHours(
				javaCast("long", arguments.hours)
			)
		);
		return this;
	}




	/**
	 * Adds minutes to current date
	 *
	 * @minutes The minutes to add, may be negative
	 */
	function plusMinutes(required numeric minutes){
		setZonedDateTime(
			getZonedDateTime().plusMinutes(
				javaCast("long", arguments.minutes)
			)
		);
		return this;
	}




	/**
	 * Adds seconds to current date
	 *
	 * @seconds The seconds to add, may be negative
	 */
	function plusSeconds(required numeric seconds){
		setZonedDateTime(
			getZonedDateTime().plusSeconds(
				javaCast("long", arguments.seconds)
			)
		);
		return this;
	}




	/**
	 * Adds nanos to current date
	 *
	 * @nanos The nanos to add, may be negative
	 */
	function plusNanos(required numeric nanos){
		setZonedDateTime(
			getZonedDateTime().plusNanos(
				javaCast("long", arguments.nanos)
			)
		);
		return this;
	}









	/**
	 * Subtracts years from current date
	 *
	 * @years The years to subtract, may be negative
	 */
	function minusYears(required numeric years){
		setZonedDateTime(
			getZonedDateTime().minusYears(
				javaCast("long", arguments.years)
			)
		);
		return this;
	}




	/**
	 * Subtracts months from current date
	 *
	 * @months The months to subtract, may be negative
	 */
	function minusMonths(required numeric months){
		setZonedDateTime(
			getZonedDateTime().minusMonths(
				javaCast("long", arguments.months)
			)
		);
		return this;
	}




	/**
	 * Subtracts weeks from current date
	 *
	 * @weeks The weeks to subtract, may be negative
	 */
	function minusWeeks(required numeric weeks){
		setZonedDateTime(
			getZonedDateTime().minusWeeks(
				javaCast("long", arguments.weeks)
			)
		);
		return this;
	}




	/**
	 * Subtracts days from current date
	 *
	 * @days The days to subtract, may be negative
	 */
	function minusDays(required numeric days){
		setZonedDateTime(
			getZonedDateTime().minusDays(
				javaCast("long", arguments.days)
			)
		);
		return this;
	}




	/**
	 * Subtracts hours from current date
	 *
	 * @hours The hours to subtract, may be negative
	 */
	function minusHours(required numeric hours){
		setZonedDateTime(
			getZonedDateTime().minusHours(
				javaCast("long", arguments.hours)
			)
		);
		return this;
	}




	/**
	 * Subtracts minutes from current date
	 *
	 * @minutes The minutes to subtract, may be negative
	 */
	function minusMinutes(required numeric minutes){
		setZonedDateTime(
			getZonedDateTime().minusMinutes(
				javaCast("long", arguments.minutes)
			)
		);
		return this;
	}




	/**
	 * Subtracts seconds from current date
	 *
	 * @seconds The seconds to subtract, may be negative
	 */
	function minusSeconds(required numeric seconds){
		setZonedDateTime(
			getZonedDateTime().minusSeconds(
				javaCast("long", arguments.seconds)
			)
		);
		return this;
	}




	/**
	 * Subtracts nanos from current date
	 *
	 * @nanos The nanos to subtract, may be negative
	 */
	function minusNanos(required numeric nanos){
		setZonedDateTime(
			getZonedDateTime().minusNanos(
				javaCast("long", arguments.nanos)
			)
		);
		return this;
	}









	
	/**
	 * Converts to string
	 */
	public string function toString(){
		return getZonedDateTime().toString();
	}
	
}
