/**
* CF wrapper for com.mongodb.client.model.Field
* Should be instantiated via ModelFactory.
* Example usage:
	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
	var Field=ModelFactory.Field(
		"myFieldName", 
		BsonFactory.Document({ "$add": [ "$totalHomework", "$totalQuiz", "$extraCredit" ] })
	);
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";

	// Local properties
	property name="JavaField" type="any";


	/**
	 * Mainly decorative purpose, for proper initialization use initWithExpression()
	 */
	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getJavaField();
	}




	/**
	 * Creates a new field definition for use in $addFields pipeline stages
	 *
	 * @name Field name
	 * @value Expression
	 */
	function initWithExpression(required string name, required Document value){
		setJavaField(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Field").init(
				javaCast("string", arguments.name),
				arguments.value.getMongoDocument()
			)
		);
		return this;
	}




	/**
	 * Returns the name of the field
	 */
	string function getName(){
		return getJavaField().getName();
	}




	/**
	 * Returns the value of the field wrapped in Document
	 */
	Document function getValue(){
		return getBsonFactory().Document(
			getJavaField().getValue()
		);
	}
}
