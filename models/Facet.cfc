/**
* CF wrapper for com.mongodb.client.model.Facet
* Should be instantiated via ModelFactory.
* Example usage:
*	var ModelFactory=getInstance("ModelFactory@box-mongodb-sdk");
*	var BsonFactory=getInstance("BsonFactory@box-mongodb-sdk");
*	var Facet=ModelFactory.Facet(
*		"myFacetName", 
*		[
*			BsonFactory.Document({ "$unwind": "$tags" }),
*			BsonFactory.Document({ "$sortByCount": "$tags" })
*		]
*	);
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="JavaFacet" type="any";


	/**
	 * Mainly decorative purpose, for proper initialization use initWithExpression()
	 */
	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getJavaFacet();
	}




	/**
	 * Creates a new facet for the $facet pipeline stage
	 *
	 * @name Facet name
	 * @pipeline Pipeline. Array of Documents.
	 */
	function initWithPipeline(required string name, required Document[] pipeline){
		setJavaFacet(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Facet").init(
				javaCast("string", arguments.name),
				getUtil().toMongo(
					arguments.pipeline
				)
			)
		);
		return this;
	}




	/**
	 * Returns the facet name
	 */
	string function getName(){
		return getJavaFacet().getName();
	}




	/**
	 * Returns the pipeline definition
	 */
	Document[] function getPipeline(){
		return getUtil().toCF(
			getJavaFacet().getPipeline()
		);
	}
}
