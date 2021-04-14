/**
* Wrapper for com.mongodb.client.model.TextSearchOptions. 
* Carries the options for a text search operation.
*/

component output="false" accessors="true" {
	

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	//property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	//property name="Util" inject="Util@box-mongodb-sdk";
	//property name="Wirebox" inject="wirebox";

	// Local properties
	property name="TextSearchOptions" type="any";
	
	
	function init(){
		return this;
	}




	function onDIComplete(){
		setTextSearchOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.TextSearchOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getTextSearchOptions();
	}




	/**
	 * Set the language for the text search
	 *
	 * @skip The language to use for the text search
	 */
	function language(required string language){
		getTextSearchOptions().language(
			javaCast("string", arguments.language)
		);
		return this;
	}




	/**
	 * Returns the language to be used with the text search
	 */
	string function getLanguage(){
		return getTextSearchOptions().getLanguage();
	}




	/**
	 * Set the case-sensitive flag for the text search
	 *
	 * @caseSensitive The case-sensitive flag for the text search
	 */
	function caseSensitive(required boolean caseSensitive){
		getTextSearchOptions().caseSensitive(
			javaCast("boolean", arguments.caseSensitive)
		);
		return this;
	}




	/**
	 * Returns the case-sensitive flag to use with the text search
	 */
	boolean function getCaseSensitive(){
		return getTextSearchOptions().getCaseSensitive();
	}




	/**
	 * Set the diacritic-sensitive flag for the text search
	 *
	 * @diacriticSensitive The diacritic-sensitive flag for the text search
	 */
	function diacriticSensitive(required boolean diacriticSensitive){
		getTextSearchOptions().diacriticSensitive(
			javaCast("boolean", arguments.diacriticSensitive)
		);
		return this;
	}




	/**
	 * Returns the diacritic-sensitive flag to use with the text search
	 */
	boolean function getDiacriticSensitive(){
		return getTextSearchOptions().getDiacriticSensitive();
	}




	string function toString(){
		return getCountOptions().toString();
	}
}
