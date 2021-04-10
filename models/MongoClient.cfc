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

		lock name="mongoDatabasesCache" type="exclusive" timeout=2 {
			variables["mongoDatabasesCache"]={};
		}

		return this;
	}




	public function getDatabase(required string databaseName) {

		if(!structKeyExists(variables["mongoDatabasesCache"], arguments.databaseName)){
			lock name="mongoDatabasesCache" type="exclusive" throwOnTimeout="true" timeout=10 {
				if(!structKeyExists(variables["mongoDatabasesCache"], arguments.databaseName)){
					var database=getWirebox().getInstance("MongoDatabase@box-mongodb-sdk");
					var mongoDatabase=getMongoClient().getDatabase(
						javaCast("string", arguments.databaseName)
					);
					database.setMongoDatabase(mongoDatabase);

					variables["mongoDatabasesCache"][arguments.databaseName]=database;
				}
			}
		}

		return variables["mongoDatabasesCache"][arguments.databaseName];
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




	/**
	 * Close the client, which will close all underlying cached resources, including, for example, sockets and background monitoring threads.
	 */
	public void function close() {
		getMongoClient().close();
	}




	public any function watch() {
		// TODO: start here tomorrow
		return getMongoClient().watch()
	}
}
