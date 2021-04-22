/**
* Wrapper for the Collation object
*
* Example usage:
*	var collation=Wirebox.getInstance("Collation@box-mongodb-sdk");
*	collation.locale("en_US");
*	collation.numericOrdering(true);
*	var results=myCollection.aggregate([my pipeline]).collation(collation).toArray();
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";

	// Local properties
	property name="MongoCollation" type="any" default="";

	public function init(){
		return this;
	}




	public any function onDIComplete() {
		setMongoCollation(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Collation").builder()
		);
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getMongoCollation();
	}




	/**
	 * Sets the locale
	 *
	 * @locale The locale
	 */
	public Collation function locale(required string locale) {
		getMongoCollation().locale(javaCast("string", arguments.locale));
		return this;
	}




	/**
	 * Sets the backwards value. Causes secondary differences to be considered in reverse order, as it is done in the French language.
	 *
	 * @backwards The backwards value
	 */
	public Collation function backwards(required boolean backwards) {
		getMongoCollation().backwards(javaCast("boolean", arguments.backwards));
		return this;
	}




	/**
	 * Sets the case level value. Turns on case sensitivity.
	 *
	 * @caseLevel The case level value
	 */
	public Collation function caseLevel(required boolean caseLevel) {
		getMongoCollation().caseLevel(javaCast("boolean", arguments.caseLevel));
		return this;
	}




	/**
	 * Sets the normalization value. If true, normalizes text into Unicode NFD.
	 *
	 * @normalization The normalization value
	 */
	public Collation function normalization(required boolean normalization) {
		getMongoCollation().normalization(javaCast("boolean", arguments.normalization));
		return this;
	}




	/**
	 * Sets the numeric ordering
	 *
	 * @numericOrdering If true will order numbers based on numerical order and not collation order
	 */
	public Collation function numericOrdering(required boolean numericOrdering) {
		getMongoCollation().numericOrdering(javaCast("boolean", arguments.numericOrdering));
		return this;
	}




	/**
	 * Collation strength
	 * 
	 * @strength	One of the following values (all uppercase!):
	 * 	- IDENTICAL
	 * 	- PRIMARY
	 * 	- SECONDARY
	 * 	- TERTIARY
	 * 	- QUATERNARY
	 */
	public Collation function collationStrength(required string strength) {
		var CollationStrength=getJavaFactory().getJavaObject("com.mongodb.client.model.CollationStrength");
		getMongoCollation().collationStrength(CollationStrength[javaCast("string", arguments.strength)]);
		return this;
	}




	/**
	 * Collation alternate
	 *
	 * @alternate One of the following values (all uppercase!):
	 * 	- NON_IGNORABLE
	 * 	- SHIFTED
	 */
	public Collation function collationAlternate(required string alternate) {
		var CollationAlternate=getJavaFactory().getJavaObject("com.mongodb.client.model.CollationAlternate");
		getMongoCollation().collationAlternate(CollationAlternate[javaCast("string", arguments.alternate)]);
		return this;
	}




	/**
	 * Collation case first. Determines if Uppercase or lowercase values should come first.
	 *
	 * @caseFirst One of the following values (all uppercase!):
	 * 	- LOWER
	 * 	- OFF
	 * 	- UPPER
	 */
	public Collation function collationCaseFirst(required string caseFirst) {
		var CollationCaseFirst=getJavaFactory().getJavaObject("com.mongodb.client.model.CollationCaseFirst");
		getMongoCollation().collationCaseFirst(CollationCaseFirst[javaCast("string", arguments.caseFirst)]);
		return this;
	}




	/**
	 * Collation max variable
	 *
	 * @maxVariable One of the following values (all uppercase!):
	 * 	- PUNCT
	 * 	- SPACE
	 */
	public Collation function collationMaxVariable(required string maxVariable) {
		var CollationMaxVariable=getJavaFactory().getJavaObject("com.mongodb.client.model.CollationMaxVariable");
		getMongoCollation().collationMaxVariable(CollationMaxVariable[javaCast("string", arguments.maxVariable)]);
		return this;
	}




	/**
	 * Build the Collation object
	 */
	public any function build() {
		return getMongoCollation().build();
	}
}
