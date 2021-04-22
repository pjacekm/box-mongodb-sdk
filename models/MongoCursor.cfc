/**
* 
* @author pjacekm@gmail.com
* @description CFML wrapper for native MongoDB MongoCursor
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="MongoCursor" type="any" default="";

	public function init(){
		return this;
	}




	public boolean function hasNext() {
		return getMongoCursor().hasNext();
	}




	public any function next() {
		var next=getMongoCursor().next();

		switch(getMetadata(next).getCanonicalName()){
			case "org.bson.Document":
				next=getWirebox().getInstance("Document@box-mongodb-sdk").setMongoDocument(next);
			break;

			case "com.mongodb.client.model.changestream.ChangeStreamDocument":
				next=getWirebox().getInstance("ChangeStreamDocument@box-mongodb-sdk").setChangeStreamDocument(next);
			break;
		
			default:
				throw(type = "com.dh.MongoCursor.notImplementedException", message = "#getMetadata(next).getCanonicalName()# handling not yet implemented", detail="", errorCode = "com.dh.error");
				
			break;
		}
		

		return next;
	}




	public any function getServerCursor(){
		return getMongoCursor().getServerCursor();
	}




	public void function close() {
		return getMongoCursor().close();
	}




	public any function getServerAddress() {
		return getWirebox().getInstance("MongoFactory@box-mongodb-sdk").ServerAddress(
			getMongoCursor().getServerAddress()
		);
	}
}
