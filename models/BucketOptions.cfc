/**
* Wrapper for com.mongodb.client.model.BucketOptions.
* Carries the options for a $bucket aggregation pipeline stage.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="BucketOptions" type="any";

	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setBucketOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.BucketOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getBucketOptions();
	}




	/**
	 * The name of the default bucket for values outside the defined buckets
	 *
	 * @name The bucket value
	 */
	BucketOptions function defaultBucket(required string name){
		getBucketOptions().defaultBucket(
			javaCast("string", arguments.name)
		);
		return this;
	}




	/**
	 * Returns the default bucket value
	 */
	string function getDefaultBucket(){
		return getBucketOptions().getDefaultBucket();
	}




	/**
	 * The definition of the output document in each bucket
	 *
	 * output The output document definition 
	 */
	BucketOptions function output(required BsonField[] output){
		getBucketOptions().output(
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

		for(var bField in getBucketOptions().getOutput()){
			response.append(
				getModelFactory().BsonField(bField)
			);
		}

		return response;
	}




	string function toString(){
		return getBucketOptions().toString();
	}
}
