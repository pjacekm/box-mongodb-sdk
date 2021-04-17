/**
* Factory/builder for assorted com.mongodb object wrappers
*/

component output="false" accessors="true" {

	property name="Wirebox" inject="wirebox";

	public function init(){
		return this;
	}




	/**
	 * "Constructor" for MongoNamespace
	 * Covers two scenarios:
	 * 		MongoFactory.MongoNamespace(string fullName)
	 * 		MongoFactory.MongoNamespace(string databaseName, string collectionName)
	 */
	MongoNamespace function MongoNamespace(){
		switch( arguments.len() ){
			case 1:
				// MongoNamespace(string fullName)
				return getWirebox().getInstance("MongoNamespace@box-mongodb-sdk").initWithFullName(
					arguments[1]
				);
			break;

			case 2:
				// MongoNamespace(string databaseName, string collectionName)
				return getWirebox().getInstance("MongoNamespace@box-mongodb-sdk").initWithDatabaseAndCollection(
					arguments[1],
					arguments[2]
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'BsonField(object BsonField)' or 'BsonField(string fieldName, Document fieldValue)'.", detail="");
			break;
		}
		return getWirebox().getInstance("MongoNamespace@box-mongodb-sdk");
	}

}
