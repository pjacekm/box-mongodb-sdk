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




	/**
	 * "Constructor" for ServerAddress
	 * Covers three scenarios:
	 * 		MongoFactory.ServerAddress()
	 * 		MongoFactory.ServerAddress(string host) -or- MongoFactory.ServerAddress(ServerAddress serverAddress)
	 * 		MongoFactory.ServerAddress(string host, numeric port)
	 */
	ServerAddress function ServerAddress(){
		switch( arguments.len() ){
			case 0:
				return getWirebox().getInstance("ServerAddress@box-mongodb-sdk").initDefault();
			break;

			case 1:
				if( isValid("string", arguments[1]) ){
					return getWirebox().getInstance("ServerAddress@box-mongodb-sdk").initWithHost(
						arguments[1]
					);
				}
				else{
					return getWirebox().getInstance("ServerAddress@box-mongodb-sdk").initWithServerAddress(
						arguments[1]
					);
				}
			break;

			case 2:
				return getWirebox().getInstance("ServerAddress@box-mongodb-sdk").initWithHostAndPort(
					arguments[1],
					arguments[2]
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'MongoFactory.ServerAddress()' or 'MongoFactory.ServerAddress(ServerAddress serverAddress)' or 'MongoFactory.ServerAddress(string host)' or 'MongoFactory.ServerAddress(string host, numeric port)'.", detail="");
			break;
		}
	}

}
