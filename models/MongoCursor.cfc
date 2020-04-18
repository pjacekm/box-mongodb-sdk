/**
* 
* @author pjacekm@gmail.com
* @description CFML wrapper for native MongoDB MongoCursor
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";

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

		/* switch(getMetadata(next).getCanonicalName()){
			case "org.bson.Document":
				next=getWirebox().getInstance("Document@box-mongodb-sdk").setMongoDocument(next);
			break;
		
			default:
				
			break;
		} */
		

		return next;
	}




	public any function getServerCursor(){
		return getMongoCursor().getServerCursor();
	}




	public void function close() {
		return getMongoCursor().close();
	}




	public any function getServerAddress() {
		return getWirebox().getInstance("ServerAddress@box-mongodb-sdk").setServerAddress(
			getMongoCursor().getServerAddress()
		);
	}
}
