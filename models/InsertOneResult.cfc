/**
* Wrapper for com.mongodb.client.result.InsertOneResult.
* Carries the result of the InsertOne operation.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="InsertOneResult" type="any";

	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setInsertOneResult(
			getJavaFactory().getJavaObject("com.mongodb.client.result.InsertOneResult")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getInsertOneResult();
	}




	/**
	 * Returns CF ObjectId if _id of the inserted document if available, otherwise null 
	 */
	function getInsertedId(){
		var id=getInsertOneResult().getInsertedId();

		if(isNull(id)){
			return javaCast("null", "");
		}
		else {
			return BsonFactory.ObjectId(
				getInsertOneResult().getInsertedId()
			);
		}
	}




	/**
	 * Returns true if the write was acknowledged.
	 */
	boolean function wasAcknowledged(){
		return getInsertOneResult().wasAcknowledged();
	}
}
