/**
* A factory for defining index keys. CF wrapper for com.mongodb.client.model.Indexes.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";

	// Local properties
	property name="JavaIndexes";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getJavaIndexes();
	}




	function onDIComplete(){
		setJavaIndexes(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Indexes")
		);

		return this;
	}




	/**
	 * Create an index key for an ascending index on the given fields.
	 *
	 * @fieldNames Array with field names, which must contain at least one
	 */
	Document function ascending(required array fieldNames){
		return getBsonFactory().Document(
			getJavaIndexes().ascending(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Create an index key for an descending index on the given fields.
	 *
	 * @fieldNames Array with field names, which must contain at least one
	 */
	Document function descending(required array fieldNames){
		return getBsonFactory().Document(
			getJavaIndexes().descending(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Create an index key for an 2dsphere index on the given fields.
	 *
	 * @fieldNames Array with field names, which must contain at least one
	 */
	Document function geo2dsphere(required array fieldNames){
		return getBsonFactory().Document(
			getJavaIndexes().geo2dsphere(
				getUtil().toMongo(
					arguments.fieldNames
				)
			)
		);
	}




	/**
	 * Create an index key for a 2d index on the given field. 
	 * Note: A 2d index is for data stored as points on a two-dimensional plane. The 2d index is intended for legacy coordinate pairs used in MongoDB 2.2 and earlier. 
	 *
	 * @fieldName The field to create a 2d index on
	 */
	Document function geo2d(required string fieldName){
		return getBsonFactory().Document(
			getJavaIndexes().geo2d(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Create an index key for a geohaystack index on the given field. 
	 * Note: For queries that use spherical geometry, a 2dsphere index is a better option than a haystack index. 2dsphere indexes allow field reordering; geoHaystack indexes require the first field to be the location field. Also, geoHaystack indexes are only usable via commands and so always return all results at once.
	 *
	 * @fieldName The field to create a geoHaystack index on
	 * @additional The additional field that forms the geoHaystack index key
	 */
	Document function geoHaystack(required string fieldName, required Document additional){
		return getBsonFactory().Document(
			getJavaIndexes().geoHaystack(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.additional
				)
			)
		);
	}




	/**
	 * Create an index key for a text index on the given field: text()
	 * -or-
	 * Create an index key for a text index on every field that contains string data: text(string fieldName)
	 */
	Document function text(){
		switch( arguments.len() ){
			case 0:
				return getBsonFactory().Document(
					getJavaIndexes().text()
				);
			break;

			case 1:
				return getBsonFactory().Document(
					getJavaIndexes().text(
						javaCast("string", arguments[1])
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'text()' or 'text(string fieldName)'.", detail="");
			break;
		}
	}




	/**
	 * Create an index key for a hashed index on the given field.
	 *
	 * @fieldName The field to create a hashed index on
	 */
	Document function hashed(required string fieldName){
		return getBsonFactory().Document(
			getJavaIndexes().hashed(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Create a compound index specifications. If any field names are repeated, the last one takes precedence.
	 * Usage example:
	 * 		Indexes.compoundIndex(
				[
					Indexes.ascending(["field1", "field2"]),
					Indexes.descending(["field3"])
				]
			)
	 *
	 * @Indexes Array (of Documents) with the index specifications 
	 */
	Document function compoundIndex(required Document[] indexes){
		return getBsonFactory().Document(
			getJavaIndexes().compoundIndex(
				getUtil().toMongo(
					arguments.indexes
				)
			)
		);
	}
}
