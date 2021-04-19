/**
* Wrapper for com.mongodb.client.model.PushOptions.
* The options to apply to a $push update operator.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="PushOptions" type="any";


	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setPushOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.PushOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getPushOptions();
	}




	/**
	 * Gets the position at which to add the pushed values in the array.
	 */
	numeric function getPosition(){
		return getPushOptions().getPosition();
	}




	/**
	 * Sets the position at which to add the pushed values in the array.
	 *
	 * @position The position
	 */
	PushOptions function position(required numeric position){
		getPushOptions().position(
			javaCast("int", arguments.position)
		);
		return this;
	}




	/**
	 * Gets the slice value, which is the limit on the number of array elements allowed.
	 */
	numeric function getSlice(){
		return getPushOptions().getSlice();
	}




	/**
	 * Sets the limit on the number of array elements allowed.
	 *
	 * @slice The limit
	 */
	PushOptions function slice(required numeric slice){
		getPushOptions().slice(
			javaCast("int", arguments.slice)
		);
		return this;
	}




	/**
	 * Gets the sort direction for sorting array elements that are not documents.
	 */
	numeric function getSort(){
		return getPushOptions().getSort();
	}




	/**
	 * Sets the sort direction for sorting array elements that are not documents.
	 *
	 * @sort The sort direction (1 or -1)
	 */
	PushOptions function sort(required numeric sort){
		getPushOptions().sort(
			javaCast("int", arguments.sort)
		);
		return this;
	}




	/**
	 * Gets the sort direction for sorting array elements that are documents.
	 */
	Document function getSortDocument(){
		return getUtil().toCF(
			getPushOptions().getSortDocument()
		);
	}




	/**
	 * Sets the sort direction for sorting array elements that are documents.
	 *
	 * @sortDocument The sort document
	 */
	PushOptions function sortDocument(required Document sortDocument){
		getPushOptions().sortDocument(
			arguments.sortDocument.getMongoDocument()
		);
		return this;
	}
}
