/**
* Wrapper for com.mongodb.client.model.GraphLookupOptions.
* Carries the options for a graphLookup aggregation pipeline stage.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="GraphLookupOptions" type="any";

	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setGraphLookupOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.GraphLookupOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getGraphLookupOptions();
	}




	/**
	 * The name of the field in which to store the depth value
	 *
	 * @field The field name
	 */
	GraphLookupOptions function depthField(required string field){
		getGraphLookupOptions().depthField(
			javaCast("string", arguments.field)
		);
		return this;
	}




	/**
	 * Returns the field name
	 */
	string function getDepthField(){
		return getGraphLookupOptions().getDepthField();
	}




	/**
	 * Specifies a maximum recursive depth for the $graphLookup. This number must be non-negative.
	 *
	 * @max The maximum depth
	 */
	GraphLookupOptions function maxDepth(required numeric max){
		getGraphLookupOptions().maxDepth(
			javaCast("int", arguments.max)
		);
		return this;
	}




	/**
	 * Returns the maximum depth
	 */
	numeric function getMaxDepth(){
		return getGraphLookupOptions().getMaxDepth();
	}




	/**
	 * A document specifying additional conditions for the recursive search
	 *
	 * @filter The filter expression
	 */
	GraphLookupOptions function restrictSearchWithMatch(required Document filter){
		getGraphLookupOptions().restrictSearchWithMatch(
			arguments.filter.getMongoDocument()
		);
		return this;
	}




	Document function getRestrictSearchWithMatch(){
		return getBsonFactory.Document(
			getGraphLookupOptions().getRestrictSearchWithMatch()
		);
	}




	string function toString(){
		return getGraphLookupOptions().toString();
	}
}
