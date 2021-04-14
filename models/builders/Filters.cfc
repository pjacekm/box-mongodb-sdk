/**
* 
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="JavaFilters";

	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getJavaFilters();
	}




	function onDIComplete(){
		setJavaFilters(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Filters")
		);

		return this;
	}




	/**
	 * Creates a filter that matches all documents where the value of the field name equals the specified value. Note that this doesn't actually generate a $eq operator, as the query language doesn't require it.
	 *
	 * @fieldName The field name
	 * @value The value, which may be null
	 */
	function eq(required string fieldName, value=javaCast("null", "")){
		return getBsonFactory().Document(
			getJavaFilters().eq(
				javaCast("string", arguments.fieldName),
				isNull(arguments.value) ? javaCast("null", "") : getUtil().toMongo(arguments.value)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the field name does not equal the specified value.
	 *
	 * @fieldName The field name
	 * @value The value, which may be null
	 */
	function ne(required string fieldName, value=javaCast("null", "")){
		return getBsonFactory().Document(
			getJavaFilters().ne(
				javaCast("string", arguments.fieldName),
				isNull(arguments.value) ? javaCast("null", "") : getUtil().toMongo(arguments.value)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the given field is greater than the specified value.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	function gt(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaFilters().gt(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the given field is less than the specified value.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	function lt(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaFilters().lt(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the given field is greater than or equal to the specified value.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	function gte(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaFilters().gte(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the given field is less than or equal to the specified value.
	 *
	 * @fieldName The field name
	 * @value The value
	 */
	function lte(required string fieldName, required value){
		return getBsonFactory().Document(
			getJavaFilters().lte(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of a field equals any value in the array of specified values.
	 *
	 * @fieldName The field name
	 * @values The array with values
	 */
	function in(required string fieldName, required array values){
		return getBsonFactory().Document(
			getJavaFilters().in(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of a field does not equal any of the specified values or does not exist.
	 *
	 * @fieldName The field name
	 * @values The array with values
	 */
	function nin(required string fieldName, required array values){
		return getBsonFactory().Document(
			getJavaFilters().nin(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				)
			)
		);
	}




	/**
	 * Creates a filter that performs a logical AND of the provided array of filters. 
	 *
	 * @filters The array of filters to "and" together
	 */
	function and(required array filters){
		return getBsonFactory().Document().setMongoDocument(
			getJavaFilters().and(
				getUtil().toMongo(
					arguments.filters
				)
			)
		);
	}




	/**
	 * Creates a filter that preforms a logical OR of the provided array of filters. 
	 *
	 * @filters The array of filters to "or" together
	 */
	function or(required array filters){
		return getBsonFactory().Document().setMongoDocument(
			getJavaFilters().or(
				getUtil().toMongo(
					arguments.filters
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents that do not match the passed in filter. 
	 * Requires the field name to be passed as part of the value passed in and lifts it to create a valid "$not" query. Example:
	 * 		Filters.not(
	 *			Filters.eq("id", 5)
	 *		)
	 *
	 * @filter 
	 */
	function not(required filter){
		return getBsonFactory().Document(
			getJavaFilters().not(
				getUtil().toMongo(
					arguments.filter
				)
			)
		);
	}




	/**
	 * Creates a filter that performs a logical NOR operation on all the specified filters.
	 *
	 * @filters The array of filters to "nor" together
	 */
	function nor(required array filters){
		return getBsonFactory().Document().setMongoDocument(
			getJavaFilters().nor(
				getUtil().toMongo(
					arguments.filters
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents that either contain or do not contain the given field, depending on the value of the exists parameter.
	 *
	 * @fieldName The field name
	 * @exists True to check for existence, false to check for absence
	 */
	function exists(required string fieldName, required boolean exists){
		return getBsonFactory().Document(
			getJavaFilters().exists(
				javaCast("string", arguments.fieldName),
				javaCast("boolean", arguments.exists)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the field is of the specified BSON type.
	 *
	 * @fieldName The field name
	 * @type The string representation of the BSON type
	 */
	function type(required string fieldName, required string type){
		return getBsonFactory().Document(
			getJavaFilters().type(
				javaCast("string", arguments.fieldName),
				javaCast("string", arguments.type)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of a field divided by a divisor has the specified remainder (i.e. perform a modulo operation to select documents).
	 *
	 * @fieldName The field name
	 * @divisor The modulus
	 * @remainder The remainder
	 */
	function mod(required string fieldName, required numeric divisor, required numeric remainder){
		return getBsonFactory().Document(
			getJavaFilters().mod(
				javaCast("string", arguments.fieldName),
				javaCast("long", arguments.divisor),
				javaCast("long", arguments.remainder)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of the field matches the given regular expression pattern with the given options applied.
	 *
	 * @fieldName The field name
	 * @pattern The pattern
	 * @options The options
	 */
	function regex(required string fieldName, required string pattern, string options=""){
		return getBsonFactory().Document(
			getJavaFilters().regex(
				javaCast("string", arguments.fieldName),
				javaCast("string", arguments.pattern),
				arguments.options.len() ? javaCast("string", arguments.options) : javaCast("null", "")
			)
		);
	}




	/**
	 * Creates a filter that matches all documents matching the given the search term with the given text search options.
	 *
	 * @search The search term
	 * @textSearchOptions The text search options to use
	 */
	function text(required string search, TextSearchOptions textSearchOptions=getWirebox().getInstance("TextSearchOptions@box-mongodb-sdk")){
		return getBsonFactory().Document(
			getJavaFilters().text(
				javaCast("string", arguments.search),
				arguments.textSearchOptions.getTextSearchOptions()
			)
		);
	}




	/**
	 * Creates a filter that matches all documents for which the given expression is true.
	 *
	 * @javaScriptExpression The JavaScript expression
	 */
	function where(required string javaScriptExpression){
		return getBsonFactory().Document(
			getJavaFilters().where(
				javaCast("string", arguments.javaScriptExpression)
			)
		);
	}




	/**
	 * Allows the use of aggregation expressions within the query language.
	 *
	 * @expression The aggregation expression 
	 * 
	 * See https://docs.mongodb.com/manual/reference/operator/query/expr/
	 */
	function expr(required expression){
		return getBsonFactory().Document(
			getJavaFilters().expr(
				getUtil().toMongo(
					arguments.expression
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents where the value of a field is an array that contains all the specified values.
	 *
	 * @fieldName The field name
	 * @values The array with values
	 */
	function all(required string fieldName, required array values){
		return getBsonFactory().Document(
			getJavaFilters().all(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.values
				)
			)
		);
	}




	/**
	 * Creates a filter that matches all documents containing a field that is an array where at least one member of the array matches the given filter.
	 * Example:
	 * 
	 * 		Filters.elemMatch(
	 *			"field",
	 *			BsonFactory.Document({"$gt": BsonFactory.Int32(1), "$lt": BsonFactory.Int32(5)})
	 *		)
	 * 
	 *
	 * @fieldName The field name
	 * @filter The filter to apply to each element
	 */
	function elemMatch(required string fieldName, required filter){
		return getBsonFactory().Document(
			getJavaFilters().elemMatch(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.filter
				)
			)
		);
	}




	




	
}
