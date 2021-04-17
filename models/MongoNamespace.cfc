/**
* CF wrapper for com.mongodb.MongoNamespace
* Should be instantiated via MongoFactory
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="MongoNamespace" type="any";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getMongoNamespace();
	}




	/**
	 * Initializes object with full name
	 *
	 * @fullName 
	 */
	MongoNamespace function initWithFullName(required string fullName){
		setMongoNamespace(
			getJavaFactory().getJavaObject("com.mongodb.MongoNamespace").init(
				javaCast("string", arguments.fullName)
			)
		);
		return this;
	}




	/**
	 * Initializes object with database name and collection name
	 *
	 * @databaseName 
	 * @collectionName 
	 */
	MongoNamespace function initWithDatabaseAndCollection(required string databaseName, required string collectionName){
		setMongoNamespace(
			getJavaFactory().getJavaObject("com.mongodb.MongoNamespace").init(
				javaCast("string", arguments.databaseName),
				javaCast("string", arguments.collectionName)
			)
		);
		return this;
	}




	/**
	 * Check the validity of the given database name. 
	 * A valid database name is non-null, non-empty, and does not contain any of the following characters: '\0', '/', '\\', ' ', '"', '.'. 
	 * The server may impose additional restrictions on database names.
	 * 
	 * @throws java.lang.IllegalArgumentException if the database name is invalid
	 *
	 * @databaseName The database name
	 */
	void function checkDatabaseNameValidity(required string databaseName){
		getMongoNamespace().checkDatabaseNameValidity(
			javaCast("string", arguments.databaseName)
		);
	}




	/**
	 * Check the validity of the given collection name. 
	 * A valid collection name is non-null and non-empty. 
	 * The server may impose additional restrictions on collection names.
	 * 
	 * @throws java.lang.IllegalArgumentException if the collection name is invalid
	 *
	 * @collectionName The collection name
	 */
	void function checkCollectionNameValidity(required string collectionName){
		getMongoNamespace().checkCollectionNameValidity(
			javaCast("string", arguments.collectionName)
		);
	}




	/**
	 * Gets the database name.
	 */
	string function getDatabaseName(){
		return getMongoNamespace().getDatabaseName();
	}




	/**
	 * Gets the collection name.
	 */
	string function getCollectionName(){
		return getMongoNamespace().getCollectionName();
	}




	/**
	 * Gets the full name, which is the database name and the collection name, separated by a period.
	 */
	string function getFullName(){
		return getMongoNamespace().getFullName();
	}




}
