/**
* Builders for accumulators used in the group pipeline stage of an aggregation pipeline. CF wrapper for com.mongodb.client.model.Accumulators.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";

	// Local properties
	property name="JavaAccumulators";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getJavaAccumulators();
	}




	function onDIComplete(){
		setJavaAccumulators(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Accumulators")
		);

		return this;
	}




	/**
	 * Gets a field name for a $group operation representing the sum of the values of the given expression when applied to all members of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function sum(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().sum(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the average of the values of the given expression when applied to all members of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function avg(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().avg(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the value of the given expression when applied to the first member of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function first(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().first(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the value of the given expression when applied to the last member of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function last(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().last(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the maximum of the values of the given expression when applied to all members of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function max(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().max(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the minimum of the values of the given expression when applied to all members of the group.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function min(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().min(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing an array of all values that results from applying an expression to each document in a group of documents that share the same group by key.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function push(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().push(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing all unique values that results from applying the given expression to each document in a group of documents that share the same group by key.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function addToSet(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().addToSet(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the sample standard deviation of the values of the given expression when applied to all members of the group.
	 * Use if the values encompass the entire population of data you want to represent and do not wish to generalize about a larger population.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function stdDevPop(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().stdDevPop(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Gets a field name for a $group operation representing the sample standard deviation of the values of the given expression when applied to all members of the group.
	 * Use if the values encompass a sample of a population of data from which to generalize about the population.
	 *
	 * @fieldName The field name
	 * @expression The expression (string, struct or Document)
	 */
	BsonField function stdDevSamp(required string fieldName, required expression){
		return getModelFactory().BsonField(
			getJavaAccumulators().stdDevSamp(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Creates an $accumulator pipeline stage
	 * Covers 5 scenarios:
	 * - accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction)
	 * - accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction)
	 * - accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction, String lang)
	 * - accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction)
	 * - accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction, String lang)
	 * 
	 * https://mongodb.github.io/mongo-java-driver/4.2/apidocs/mongodb-driver-core/com/mongodb/client/model/Accumulators.html#accumulator(java.lang.String,java.lang.String,java.lang.String,java.lang.String)
	 *
	 */
	BsonField function accumulator(){
		switch( arguments.len() ){
			case 4:
				// accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction)
				return getModelFactory().BsonField(
					getJavaAccumulators().accumulator(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2]),
						javaCast("string", arguments[3]),
						javaCast("string", arguments[4])
					)
				);
			break;

			case 5:
				// accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction)
				return getModelFactory().BsonField(
					getJavaAccumulators().accumulator(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2]),
						javaCast("string", arguments[3]),
						javaCast("string", arguments[4]),
						getUtil().toMongo(arguments[5])
					)
				);
			break;

			case 6:
				// accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction, String lang)
				return getModelFactory().BsonField(
					getJavaAccumulators().accumulator(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2]),
						javaCast("string", arguments[3]),
						javaCast("string", arguments[4]),
						getUtil().toMongo(arguments[5]),
						javaCast("string", arguments[6])
					)
				);
			break;

			case 7:
				// accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction)
				return getModelFactory().BsonField(
					getJavaAccumulators().accumulator(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2]),
						getUtil().toMongo(arguments[3]),
						javaCast("string", arguments[4]),
						getUtil().toMongo(arguments[5]),
						javaCast("string", arguments[6]),
						getUtil().toMongo(arguments[7])
					)
				);
			break;

			case 8:
				// accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction, String lang)
				return getModelFactory().BsonField(
					getJavaAccumulators().accumulator(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2]),
						getUtil().toMongo(arguments[3]),
						javaCast("string", arguments[4]),
						getUtil().toMongo(arguments[5]),
						javaCast("string", arguments[6]),
						getUtil().toMongo(arguments[7]),
						javaCast("string", arguments[8])
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction)' -or- 'accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction)' -or- 'accumulator(String fieldName, String initFunction, String accumulateFunction, String mergeFunction, @Nullable String finalizeFunction, String lang)' -or- 'accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction)' -or- 'accumulator(String fieldName, String initFunction, @Nullable List<String> initArgs, String accumulateFunction, @Nullable List<String> accumulateArgs, String mergeFunction, @Nullable String finalizeFunction, String lang)'.", detail="");
			break;
		}
		
	}

}
