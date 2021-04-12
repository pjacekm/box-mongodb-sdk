/**
* @author pjacekm@gmail.com
* @description I represent org.bson.BsonRegularExpression. 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonRegularExpression" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBsonRegularExpression();
	}




	public function onDIComplete() {
		return this;
	}




	/**
	 * Initializes the object with pattern
	 *
	 * @pattern The RegEx pattern
	 */
	function initWithPattern(required string pattern){
		setBsonRegularExpression(
			getJavaFactory().getJavaObject("org.bson.BsonRegularExpression").init(
				javaCast("string", arguments.pattern)
			)
		);
		return this;
	}




	/**
	 * Initializes the object with pattern and options
	 *
	 * @pattern The RegEx pattern
	 * @options The RegEx options
	 */
	function initWithPatternAndOptions(required string pattern, required string options){
		setBsonRegularExpression(
			getJavaFactory().getJavaObject("org.bson.BsonRegularExpression").init(
				javaCast("string", arguments.pattern),
				javaCast("string", arguments.options)
			)
		);
		return this;
	}




	/**
	 * Gets the regex pattern.
	 */
	string function getPattern(){
		return getBsonRegularExpression().getPattern();
	}




	/**
	 * Gets the options for the regular expression.
	 */
	string function getOptions(){
		return getBsonRegularExpression().getOptions();
	}




	
	public function toString() {
		return getBsonRegularExpression().toString();
	}
	
}
