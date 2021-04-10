/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="MongoDatabase" type="any" default="";

	public function init(){
		
		lock name="mongoCollectionsCache" type="exclusive" timeout=2 {
			variables["mongoCollectionsCache"]={};
		}

		return this;
	}



	/**
	* Returns current database name
	*/
	public string function getName() {
		return getMongoDatabase().getName();
	}



	/**
	* Drops current database
	*/
	public void function drop() {
		getMongoDatabase().drop();
	}



	/**
	* Creates new collection
	* <TODO> Add CreateCollectionOptions support
	*/
	public void function createCollection(required string collectionName) {
		getMongoDatabase().createCollection(javacast("string", arguments.collectionName));
	}



	/**
	* Gets MongoCollection wrapper object
	*/
	public any function getCollection(required string collectionName) {
		
		if(!structKeyExists(variables["mongoCollectionsCache"], arguments.collectionName)){
			lock name="mongoCollectionsCache" type="exclusive" throwOnTimeout="true" timeout=10 {
				if(!structKeyExists(variables["mongoCollectionsCache"], arguments.collectionName)){

					var collection=getWirebox().getInstance("MongoCollection@box-mongodb-sdk");
					var mongoCollection=getMongoDatabase().getCollection(javacast("string", arguments.collectionName));
					collection.setMongoCollection(mongoCollection);
					
					variables["mongoCollectionsCache"][arguments.collectionName]=collection;
				
				}
			}
		}

		return variables["mongoCollectionsCache"][arguments.collectionName];
	}




	public any function runCommand(required struct command) {
		var commandDocument=getUtil().toBsonDocument(arguments.command);
		var result=getMongoDatabase().runCommand(commandDocument);
		
		return getUtil().toCF(result);
	}
}
