/**
* Represents the $changeStream aggregation output document. 
*/

component output="false" accessors="true" {
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="ChangeStreamDocument" type="any" default="";

	public function init(){
		return this;
	}




	public function onDIComplete() {
		// Initialize complex values
		setChangeStreamDocument(
			getJavaFactory().getJavaObject("com.mongodb.client.model.changestream.ChangeStreamDocument")
		);
		return this;
	}




	
	public numeric function getClusterTime() {
		return getChangeStreamDocument().getClusterTime().getValue();
	}




	/**
	 * Returns the database name
	 */
	public string function getDatabaseName() {
		return getChangeStreamDocument().getDatabaseName();
	}




	/**
	 * Returns the destination namespace document, derived from the "to" field in a change stream document.
	 */
	public struct function getDestinationNamespaceDocument() {
		return getUtil().toCF(
			getChangeStreamDocument().getDestinationNamespaceDocument()
		);
	}




	/**
	 * Returns a document containing just the _id of the changed document.
	 */
	public struct function getDocumentKey() {
		return getUtil().toCF(
			getChangeStreamDocument().getDocumentKey()
		);
	}




	/**
	 * Returns the fullDocument
	 */
	public struct function getFullDocument() {
		return getUtil().toCF(
			getChangeStreamDocument().getFullDocument()
		);
	}




	/**
	 * Returns the identifier for the session associated with the transaction
	 */
	public struct function getLsid() {
		return getUtil().toCF(
			getChangeStreamDocument().getLsid()
		);
	}




	/**
	 * Returns the namespace document, derived from the "ns" field in a change stream document.
	 */
	public struct function getNamespaceDocument() {
		return getUtil().toCF(
			getChangeStreamDocument().getNamespaceDocument()
		);
	}




	/**
	 * Returns the operationType as a string.
	 * 
	 * delete
	 * drop
	 * drop_database
	 * insert
	 * invalidate
	 * other
	 * rename
	 * replace
	 * update
	 * 
	 */
	public string function getOperationType() {
		return getChangeStreamDocument().getOperationType().getValue();
	}




	/**
	 * Returns the resumeToken
	 */
	public struct function getResumeToken() {
		return getUtil().toCF(
			getChangeStreamDocument().getResumeToken()
		);
	}




	
	public UpdateDescription function getUpdateDescription() {
		return getWirebox()
			.getInstance("UpdateDescription@box-mongodb-sdk")
			.setUpdateDescription(
				getChangeStreamDocument().getUpdateDescription()
			);
	}
}
