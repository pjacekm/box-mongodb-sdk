/**
* CF wrapper for com.mongodb.client.model.Variable
* Should be instantiated via ModelFactory.
* Example usage:
	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
	var Variable=ModelFactory.Variable(
		"myFieldName", 
		"$otherField"
	);
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="JavaVariable" type="any";


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
		return getJavaVariable();
	}




	/**
	 * Creates a new variable for the $lookup pipeline stage
	 *
	 * @name Field name
	 * @value Expression. Can be string, struct or Document
	 */
	function initWithExpression(required string name, required value){
		setJavaVariable(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Variable").init(
				javaCast("string", arguments.name),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
		return this;
	}




	/**
	 * Returns the name of the new variable
	 */
	string function getName(){
		return getJavaVariable().getName();
	}




	/**
	 * Returns the value of the new variable wrapped in appropriate CF container (string as string, Document for structs and Documents)
	 */
	function getValue(){
		return getUtil().toCF(
			getJavaVariable().getValue()
		);
	}
}
