/**
* @author pjacekm@gmail.com
* @description I represent com.mongodb.client.model.BsonField. A representation of a BSON document field whose value is another BSON document.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";

	// Local properties
	property name="BsonField" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBsonField();
	}




	/**
	 * Creates a representation of a BSON document field whose value is another BSON document.
	 *
	 * @name Field name
	 * @value Expression
	 */
	function initWithDocument(required string name, required Document value){
		setBsonField(
			getJavaFactory().getJavaObject("com.mongodb.client.model.BsonField").init(
				javaCast("string", arguments.name),
				arguments.value.getMongoDocument()
			)
		);
		return this;
	}




	/**
	 * Creates a representation of a BSON document field whose value is another BSON document.
	 *
	 * @BsonField com.mongodb.client.model.BsonField
	 */
	function initWithBsonField(required BsonField){
		setBsonField(
			arguments.BsonField
		);
		return this;
	}




	/**
	 * Returns the name of the field
	 */
	string function getName(){
		return getBsonField().getName();
	}




	/**
	 * Returns the value of the field wrapped in Document
	 */
	Document function getValue(){
		return getBsonFactory().Document(
			getBsonField().getValue()
		);
	}
}
