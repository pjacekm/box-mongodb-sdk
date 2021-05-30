/**
* Builders for document updates. CF wrapper for com.mongodb.client.model.Updates.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";

	// Local properties
	property name="JavaUpdates";


	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getJavaUpdates();
	}




	function onDIComplete(){
		setJavaUpdates(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Updates")
		);

		return this;
	}




	/**
	 * Combine a list of updates into a single update.
	 *
	 * @updates The array of updates
	 */
	Document function combine(required Document[] updates){
		return getBsonFactory().Document(
			getJavaUpdates().combine(
				getUtil().toMongo(
					arguments.updates
				)
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field with the given name to the given value.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	Document function set(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().set(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that deletes the field with the given name.
	 *
	 * @fieldName The field name
	 */
	Document function unset(required string fieldName){
		return getBsonFactory().Document(
			getJavaUpdates().unset(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field with the given name to the given value, but only if the update is an upsert that results in an insert of a document.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	Document function setOnInsert(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().setOnInsert(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that renames a field.
	 *
	 * @fieldName The field name
	 * @newFieldName The new field name
	 */
	Document function rename(required string fieldName, required string newFieldName){
		return getBsonFactory().Document(
			getJavaUpdates().rename(
				javaCast("string", arguments.fieldName),
				javaCast("string", arguments.newFieldName)
			)
		);
	}




	/**
	 * Creates an update that increments the value of the field with the given name by the given value.
	 *
	 * @fieldName The field name
	 * @number The value
	 */
	Document function inc(required string fieldName, required numeric number){
		return getBsonFactory().Document(
			getJavaUpdates().inc(
				javaCast("string", arguments.fieldName),
				arguments.number
			)
		);
	}




	/**
	 * Creates an update that multiplies the value of the field with the given name by the given number.
	 *
	 * @fieldName The field name
	 * @number The value
	 */
	Document function mul(required string fieldName, required numeric number){
		return getBsonFactory().Document(
			getJavaUpdates().mul(
				javaCast("string", arguments.fieldName),
				arguments.number
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field to the given value if the given value is less than the current value of the field.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	Document function min(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().min(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field to the given value if the given value is greater than the current value of the field.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	Document function max(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().max(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field to the current date as a BSON date.
	 *
	 * @fieldName The field name
	 */
	Document function currentDate(required string fieldName){
		return getBsonFactory().Document(
			getJavaUpdates().currentDate(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates an update that sets the value of the field to the current date as a BSON timestamp.
	 *
	 * @fieldName The field name
	 */
	Document function currentTimestamp(required string fieldName){
		return getBsonFactory().Document(
			getJavaUpdates().currentTimestamp(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates an update that adds the given value to the array value of the field with the given name, unless the value is already present, in which case it does nothing.
	 *
	 * @fieldName The field name
	 * @value The value, which may be null (use BsonFactory.Null() in this case)
	 */
	Document function addToSet(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().addToSet(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that adds each of the given values to the array value of the field with the given name, unless the value is already present, in which case it does nothing.
	 *
	 * @fieldName The field name
	 * @values The values
	 */
	Document function addEachToSet(required string fieldName, required array values){
		return getBsonFactory().Document(
			getJavaUpdates().addEachToSet(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				)
			)
		);
	}




	/**
	 * Creates an update that adds the given value to the array value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @value The value, which may be null (use BsonFactory.Null() in this case)
	 */
	Document function push(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().push(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that adds each of the given values to the array value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @values The values
	 */
	Document function pushEach(
		required string fieldName, 
		required array values,
		PushOptions options=getModelFactory().PushOptions()
	){
		return getBsonFactory().Document(
			getJavaUpdates().pushEach(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				),
				arguments.options.getPushOptions()
			)
		);
	}




	/**
	 * Creates an update that removes all instances of the given value from the array value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @value The value, which may be null (use BsonFactory.Null() in this case)
	 */
	Document function pull(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaUpdates().pull(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates an update that removes from an array all elements that match the given filter.
	 *
	 * @filter The query filter
	 */
	Document function pullByFilter(required Document filter){
		return getBsonFactory().Document(
			getJavaUpdates().pullByFilter(
				arguments.filter.getMongoDocument()
			)
		);
	}




	/**
	 * Creates an update that removes all instances of the given values from the array value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @values The values
	 */
	Document function pullAll(required string fieldName, required array values){
		return getBsonFactory().Document(
			getJavaUpdates().pullAll(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				)
			)
		);
	}




	/**
	 * Creates an update that pops the first element of an array that is the value of the field with the given name.
	 *
	 * @fieldName The field name
	 */
	Document function popFirst(required string fieldName){
		return getBsonFactory().Document(
			getJavaUpdates().popFirst(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates an update that pops the last element of an array that is the value of the field with the given name.
	 *
	 * @fieldName The field name
	 */
	Document function popLast(required string fieldName){
		return getBsonFactory().Document(
			getJavaUpdates().popLast(
				javaCast("string", arguments.fieldName)
			)
		);
	}




	/**
	 * Creates an update that performs a bitwise and between the given long value and the integral value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @value The value, which must be one of the following CF components: Int32 or Int64.
	 */
	Document function bitwiseAnd(required string fieldName, required value){
		if( isInstanceOf(arguments.value, "Int32") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseAnd(
					javaCast("string", arguments.fieldName),
					arguments.value.intValue()
				)
			);
		}
		else if( isInstanceOf(value, "Int64") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseAnd(
					javaCast("string", arguments.fieldName),
					arguments.value.longValue()
				)
			);
		}
		else{
			throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'bitwiseAnd(String fieldName, Int32 value)' or 'bitwiseAnd(String fieldName, Int64 value)'.", detail="");
		}
		
	}




	/**
	 * Creates an update that performs a bitwise or between the given integer value and the integral value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @value The value, which must be one of the following CF components: Int32 or Int64.
	 */
	Document function bitwiseOr(required string fieldName, required value){
		if( isInstanceOf(arguments.value, "Int32") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseOr(
					javaCast("string", arguments.fieldName),
					arguments.value.intValue()
				)
			);
		}
		else if( isInstanceOf(value, "Int64") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseOr(
					javaCast("string", arguments.fieldName),
					arguments.value.longValue()
				)
			);
		}
		else{
			throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'bitwiseOr(String fieldName, Int32 value)' or 'bitwiseOr(String fieldName, Int64 value)'.", detail="");
		}
		
	}




	/**
	 * Creates an update that performs a bitwise xor between the given long value and the integral value of the field with the given name.
	 *
	 * @fieldName The field name
	 * @value The value, which must be one of the following CF components: Int32 or Int64.
	 */
	Document function bitwiseXor(required string fieldName, required value){
		if( isInstanceOf(arguments.value, "Int32") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseXor(
					javaCast("string", arguments.fieldName),
					arguments.value.intValue()
				)
			);
		}
		else if( isInstanceOf(value, "Int64") ){
			return getBsonFactory().Document(
				getJavaUpdates().bitwiseXor(
					javaCast("string", arguments.fieldName),
					arguments.value.longValue()
				)
			);
		}
		else{
			throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'bitwiseXor(String fieldName, Int32 value)' or 'bitwiseXor(String fieldName, Int64 value)'.", detail="");
		}
		
	}

}
