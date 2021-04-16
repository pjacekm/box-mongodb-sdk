/**
* Wrapper for com.mongodb.client.model.BucketAutoOptions.
* Carries the options for a $bucketAuto aggregation pipeline stage.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="BucketAutoOptions" type="any";

	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setBucketAutoOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.BucketAutoOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBucketAutoOptions();
	}




	/**
	 * The definition of the output document in each bucket
	 *
	 * output The output document definition 
	 */
	BucketAutoOptions function output(required BsonField[] output){
		getBucketAutoOptions().output(
			getUtil().toMongo(
				arguments.output
			)
		);
		return this;
	}




	/**
	 * Returns the output document definition
	 */
	BsonField[] function getOutput(){
		var response=[];

		for(var bField in getBucketAutoOptions().getOutput()){
			response.append(
				getModelFactory().BsonField(bField)
			);
		}

		return response;
	}




	/**
	 * Specifies the granularity of the bucket definitions.
	 *
	 * @granularity The granularity of the bucket definitions. See http://mongodb.github.io/mongo-java-driver/4.2/apidocs/mongodb-driver-core/com/mongodb/client/model/BucketGranularity.htm for valid granularity names.
	 */
	BucketAutoOptions function granularity(required string granularity){
		// NOTE: not using "com.mongodb.client.model.BucketGranularity" here, convert to object if needed.
		getBucketAutoOptions().granularity(
			getJavaFactory().getJavaObject("com.mongodb.client.model.BucketGranularity").fromString(
				javaCast("string", arguments.granularity)
			)
		);
		return this;
	}




	/**
	 * Returns the granularity of the bucket definitions
	 */
	string function getGranularity(){
		return getBucketAutoOptions().getGranularity().getValue();
	}




	string function toString(){
		return getBucketAutoOptions().toString();
	}
}
