/**
* Factory/builder for assorted com.mongodb.client.model object wrappers
*/

component output="false" accessors="true" {

	property name="Wirebox" inject="wirebox";

	public function init(){
		return this;
	}




	/**
	 * "Constructor" for Field. Creates a new field definition for use in $addFields pipeline stages.
	 * Example usage:
	 *	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
	 *	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
	 *	var Field=ModelFactory.Field(
	 *		"myFieldName", 
	 *		BsonFactory.Document({ "$add": [ "$totalHomework", "$totalQuiz", "$extraCredit" ] })
	 *	);
	 *
	 * @fieldName The field name
	 * @expression The expression (Document)
	 */
	Field function Field(required string fieldName, required Document expression){
		return getWirebox().getInstance("Field@box-mongodb-sdk").initWithExpression(
			arguments.fieldName,
			arguments.expression
		);
	}




	/**
	 * Returns BucketOptions
	 */
	BucketOptions function BucketOptions(){
		return getWirebox().getInstance("BucketOptions@box-mongodb-sdk");
	}




	/**
	 * Returns BucketAutoOptions
	 */
	BucketAutoOptions function BucketAutoOptions(){
		return getWirebox().getInstance("BucketAutoOptions@box-mongodb-sdk");
	}




	/**
	 * "Constructor" for BsonField. A representation of a BSON document field whose value is another BSON document.
	 * Covers two scenarios:
	 * 		ModelFactory.BsonField(object BsonField)
	 * 		ModelFactory.BsonField(string fieldName, Document fieldValue)
	 * 
	 */
	BsonField function BsonField(){
		switch( arguments.len() ){
			case 1:
				// Assuming the argument is a Java BsonField object
				return getWirebox().getInstance("BsonField@box-mongodb-sdk").initWithBsonField(
					arguments[1]
				);
			break;

			case 2:
				return getWirebox().getInstance("BsonField@box-mongodb-sdk").initWithDocument(
					arguments[1],
					arguments[2]
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'BsonField(object BsonField)' or 'BsonField(string fieldName, Document fieldValue)'.", detail="");
			break;
		}
	}

}
