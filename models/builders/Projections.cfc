/**
* A factory for projections. CF wrapper for com.mongodb.client.model.Projections.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="JavaProjections";

	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getJavaProjections();
	}




	function onDIComplete(){
		setJavaProjections(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Projections")
		);

		return this;
	}




	/**
	 * Creates a projection of a field whose value is computed from the given expression. 
	 * Projection with an expression is only supported using the $project aggregation pipeline stage.
	 * See http://mongodb.github.io/mongo-java-driver/4.2/apidocs/mongodb-driver-core/com/mongodb/client/model/Aggregates.html#project(org.bson.conversions.Bson)
	 *
	 * @fieldName The field name
	 * @expression The expression
	 */
	function computed(required string fieldName, required expression){
		return getBsonFactory().Document(
			getJavaProjections().computed(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Creates a projection that includes all of the given fields.
	 *
	 * @fieldNames The field names
	 */
	function include(required array fieldNames){
		return getBsonFactory().Document(
			getJavaProjections().include(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Creates a projection that excludes all of the given fields.
	 *
	 * @fieldNames The field names
	 */
	function exclude(required array fieldNames){
		return getBsonFactory().Document(
			getJavaProjections().exclude(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Creates a projection that excludes the _id field. This suppresses the automatic inclusion of _id that is the default, even when other fields are explicitly included.
	 */
	function excludeId(){
		return getBsonFactory().Document(
			getJavaProjections().excludeId()
		);
	}




	/**
	 * If @filter is null (=not provided): Creates a projection that includes for the given field only the first element of an array that matches the query filter. This is referred to as the positional $ operator.
	 * See http://docs.mongodb.org/manual/reference/operator/projection/positional/#projection
	 * Produces (example): {"scores.$": 1}
	 * 
	 * If @filter is a struct or Document: Creates a projection that includes for the given field only the first element of the array value of that field that matches the given query filter.
	 * See http://docs.mongodb.org/manual/reference/operator/projection/elemMatch
	 * Produces (example): {"games": {"$elemMatch": {"score": {"$gt": 5}}}}
	 *
	 * @fieldName The field name
	 * @filter The filter to apply
	 */
	function elemMatch(required string fieldName, filter=javaCast("null", "")){
		if(isNull( arguments.filter )){
			return getBsonFactory().Document(
				getJavaProjections().elemMatch(
					javaCast("string", arguments.fieldName)
				)
			);
		}
		else{
			return getBsonFactory().Document(
				getJavaProjections().elemMatch(
					javaCast("string", arguments.fieldName),
					getUtil().toMongo(
						arguments.filter
					)
				)
			);
		}
	}




	/**
	 * Creates a $meta projection to the given field name for the given meta field name.
	 * See https://docs.mongodb.com/manual/reference/operator/aggregation/meta/#projection
	 *
	 * @fieldName The field name
	 * @metaFieldName The meta field name
	 */
	function meta(required string fieldName, required string metaFieldName){
		return getBsonFactory().Document(
			getJavaProjections().meta(
				javaCast("string", arguments.fieldName),
				javaCast("string", arguments.metaFieldName)
			)
		);
	}




	/**
	 * Creates a projection to the given field name of the textScore, for use with text queries.
	 * See https://docs.mongodb.com/manual/reference/operator/aggregation/meta/#projection
	 *
	 * @fieldName The field name
	 */
	function metaTextScore(required string fieldName){
		return getBsonFactory().Document(
			getJavaProjections().metaTextScore(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates a projection to the given field name of a slice of the array value of that field.
	 * This function covers two scenarios in Java driver's overloaded method:
	 * 		`slice(String fieldName, int limit)`
	 * 		`slice(String fieldName, int skip, int limit)`
	 *
	 * @fieldName The field name
	 * @skip The number of elements to skip before applying the limit
	 * @limit The number of elements to project
	 */
	function slice(){
		switch( arguments.len() ){
			case 2:
				// slice(String fieldName, int limit)
				return getBsonFactory().Document(
					getJavaProjections().slice(
						javaCast("string", arguments[1]),
						javaCast("int", arguments[2])
					)
				);
			break;

			case 3:
				// slice(String fieldName, int skip, int limit)
				return getBsonFactory().Document(
					getJavaProjections().slice(
						javaCast("string", arguments[1]),
						javaCast("int", arguments[2]),
						javaCast("int", arguments[3])
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidArgumentsException", message = "Invalid arguments. Please invoke with two or three arguments: 'slice(string fieldName, numeric limit)' or 'slice(string fieldName, numeric skip, numeric limit)'", detail="");
			break;
		}
		
	}




	/**
	 * Creates a projection that combines the list of projections into a single one. If there are duplicate keys, the last one takes precedence.
	 * Example usage:
	 * 
	 * 		Projections.fields(
	 *			[
	 *				Projections.include(["quantity", "totalAmount"]),
	 *				Projections.excludeId()
	 *			]
	 *		)
	 *
	 * @projections The list of projections to combine
	 */
	function fields(required array projections){
		return getBsonFactory().Document(
			getJavaProjections().fields(
				getUtil().toMongo(
					arguments.projections
				)
			)
		);
	}

}
