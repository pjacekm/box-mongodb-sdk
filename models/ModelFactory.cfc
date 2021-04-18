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
	 * @expression The expression (Document, struct or string)
	 */
	Field function Field(required string fieldName, required expression){
		return getWirebox().getInstance("Field@box-mongodb-sdk").initWithExpression(
			arguments.fieldName,
			arguments.expression
		);
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




	/**
	 * "Constructor" for Variable. Helps define a new variable to use in the pipeline field stages ("let").
	 * Covers two scenarios:
	 * 		ModelFactory.Variable(object Variable)
	 * 		ModelFactory.Variable(string name, string|struct|Document expression)
	 * 
	 * Example usage:
	 *	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
	 *	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
	 *	var Variable=ModelFactory.Variable(
	 *		"myFieldName", 
	 *		"$anotherField"
	 *	);
	 *
	 */
	Variable function Variable(){
		switch( arguments.len() ){
			case 1:
				// Assuming the argument is a Java Variable object
				return getWirebox().getInstance("Variable@box-mongodb-sdk").initWithVariable(
					arguments[1]
				);
			break;

			case 2:
				return getWirebox().getInstance("Variable@box-mongodb-sdk").initWithExpression(
					arguments[1],
					arguments[2]
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: .", detail="");
			break;
		}
		
	}




	/**
	 * "Constructor" for Facet. Helps define a new a Facet for use in $facet pipeline stages.
	 * Example usage:
	 *	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
	 *	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
	 *	var Facet=ModelFactory.Facet(
	 *		"myFacetName", 
	 *		[
	 *	 		BsonFactory.Document({ "$unwind": "$tags" }),
	 *			BsonFactory.Document({ "$sortByCount": "$tags" })
	 * 		]
	 *	);
	 *
	 * @name The name of this facet
	 * @pipeline The facet definition pipeline
	 */
	Facet function Facet(required string name, required Document[] pipeline){
		return getWirebox().getInstance("Facet@box-mongodb-sdk").initWithPipeline(
			arguments.name,
			arguments.pipeline
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
	 * Returns GraphLookupOptions
	 */
	GraphLookupOptions function GraphLookupOptions(){
		return getWirebox().getInstance("GraphLookupOptions@box-mongodb-sdk");
	}




	/**
	 * Returns CountOptions
	 */
	CountOptions function CountOptions(){
		return getWirebox().getInstance("CountOptions@box-mongodb-sdk");
	}




	/**
	 * Returns EstimatedDocumentCountOptions
	 */
	EstimatedDocumentCountOptions function EstimatedDocumentCountOptions(){
		return getWirebox().getInstance("EstimatedDocumentCountOptions@box-mongodb-sdk");
	}




	/**
	 * Returns UnwindOptions
	 */
	UnwindOptions function UnwindOptions(){
		return getWirebox().getInstance("UnwindOptions@box-mongodb-sdk");
	}




	/**
	 * Returns MergeOptions
	 */
	MergeOptions function MergeOptions(){
		return getWirebox().getInstance("MergeOptions@box-mongodb-sdk");
	}

}
