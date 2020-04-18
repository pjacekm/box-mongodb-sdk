/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="MongoClient" type="any";

	public function init(){
		return this;
	}




	public function getDatabase(required string databaseName) {
		var database=getWirebox().getInstance("MongoDatabase@box-mongodb-sdk");
		var mongoDatabase=getMongoClient().getDatabase(
			javaCast("string", arguments.databaseName)
		);
		database.setMongoDatabase(mongoDatabase);
		return database;
	}




	public any function listDatabaseNames() {
		var dbNames=getMongoClient().listDatabaseNames();
		var mongoIterable=getWirebox().getInstance("MongoIterable@box-mongodb-sdk");
		mongoIterable.setMongoIterable(dbNames);
		return mongoIterable;
	}




	public any function listDatabases() {
		var dbs=getMongoClient().listDatabases();
		var listDatabasesIterable=getWirebox().getInstance("ListDatabasesIterable@box-mongodb-sdk");
		listDatabasesIterable.setMongoIterable(dbs);
		return listDatabasesIterable;
	}




	public any function watch() {
		// TODO: start here tomorrow
		return getMongoClient().watch()
	}
}
