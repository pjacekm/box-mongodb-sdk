/**
* Builders for sort specifications. CF wrapper for com.mongodb.client.model.Sorts.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";
	property name="MongoFactory" inject="MongoFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="JavaSorts";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getJavaSorts();
	}




	function onDIComplete(){
		setJavaSorts(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Sorts")
		);

		return this;
	}




	/**
	 * Create a sort specification for an ascending sort on the given fields.
	 *
	 * @fieldNames Array with field names, which must contain at least one
	 */
	Document function ascending(required array fieldNames){
		return getBsonFactory().Document(
			getJavaSorts().ascending(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Create a sort specification for a descending sort on the given fields.
	 *
	 * @fieldNames Array with field names, which must contain at least one
	 */
	Document function descending(required array fieldNames){
		return getBsonFactory().Document(
			getJavaSorts().descending(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Create a sort specification for the text score meta projection on the given field.
	 *
	 * @fieldName The field name
	 */
	Document function metaTextScore(required string fieldName){
		return getBsonFactory().Document(
			getJavaSorts().metaTextScore(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Combine multiple sort specifications. If any field names are repeated, the last one takes precedence.
	 * Usage example:
	 * 		Sorts.orderBy(
				[
					Sorts.ascending(["field1", "field2"]),
					Sorts.descending(["field3"])
				]
			)
	 *
	 * @sorts Array (of Documents) with the sort specifications 
	 */
	Document function orderBy(required Document[] sorts){
		return getBsonFactory().Document(
			getJavaSorts().orderBy(
				getUtil().toMongo(
					arguments.sorts
				)
			)
		);
	}
}
