/**
* Builders for aggregation pipeline stages. CF wrapper for com.mongodb.client.model.Aggregates.
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="JavaAggregates";

	public function init(){
		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	function getBaseJavaObject() {
		return getJavaAggregates();
	}




	function onDIComplete(){
		setJavaAggregates(
			getJavaFactory().getJavaObject("com.mongodb.client.model.Aggregates")
		);

		return this;
	}




	/**
	 * Creates an $addFields pipeline stage
	 * Usage:
	 * 		Aggregates.addFields(
	 *			[
	 *				ModelFactory.Field(
	 *					"field_name", 
	 *					BsonFactory.Document({ "$add": [ "$totalHomework", "$totalQuiz", "$extraCredit" ] })
	 *				),
	 *				ModelFactory.Field(
	 *					"another_name", 
	 *					BsonFactory.Document({ ... expression ... })
	 *				)
	 *			]
	 *		)
	 *
	 * @fields Array with the fields to add
	 */
	Document function addFields(required Field[] fields){
		return getBsonFactory().Document(
			getJavaAggregates().addFields(
				getUtil().toMongo(
					arguments.fields
				)
			)
		);
	}




	/**
	 * Creates a $bucket pipeline stage
	 * Example usage:
	 * 		Aggregates.bucket(
	 *			"$field",
	 *			[
	 *				1,2,3
	 *			],
	 *			ModelFactory.BucketOptions()
	 *			.defaultBucket("default")
	 *			.output(
	 *				[
	 *					ModelFactory.BsonField(
	 *						"sum", 
	 *						BsonFactory.Document("$sum", 1)
	 *					)
	 *				]
	 *			)
	 *		)
	 * 
	 *
	 * @groupBy The criteria to group by
	 * @boundaries The boundaries of the buckets
	 * @options The optional values for the $bucket stage
	 */
	Document function bucket(
		required groupBy,
		required array boundaries,
		BucketOptions options=getModelFactory().BucketOptions()
	){
		return getBsonFactory().Document(
			getJavaAggregates().bucket(
				arguments.groupBy,
				getUtil().toMongo(
					arguments.boundaries
				),
				arguments.options.getBucketOptions()
			)
		);
	}




	/**
	 * Creates a $bucketAuto pipeline stage
	 * Example usage:
	 * 		Aggregates.bucket(
	 *			"$field",
	 *			5,
	 *			ModelFactory.BucketAutoOptions()
	 *			.output(
	 *				[
	 *					ModelFactory.BsonField(
	 *						"sum", 
	 *						BsonFactory.Document("$sum", 1)
	 *					)
	 *				]
	 *			)
	 *			.granularity("POWERSOF2")
	 *		)
	 * 
	 *
	 * @groupBy The criteria to group by
	 * @buckets 
	 * @options 
	 */
	Document function bucketAuto(
		required groupBy,
		required numeric buckets,
		BucketAutoOptions options=getModelFactory().BucketAutoOptions()
	){
		return getBsonFactory().Document(
			getJavaAggregates().bucketAuto(
				arguments.groupBy,
				javaCast("int", arguments.buckets),
				arguments.options.getBucketAutoOptions()
			)
		);
	}




	/**
	 * Creates a $count pipeline stage using the named field or the field name "count" (if @field is null) to store the result
	 *
	 * @field The field in which to store the count
	 */
	Document function count(string field=javaCast("null", "")){
		if( isNull( arguments.field ) ){
			return getBsonFactory().Document(
				getJavaAggregates().count()
			);
		}
		else{
			return getBsonFactory().Document(
				getJavaAggregates().count(
					javaCast("string", arguments.field)
				)
			);
		}
	}




	/**
	 * Creates a $match pipeline stage for the specified filter
	 *
	 * @filter The filter to match - you are encouraged to use the Filters builder here
	 */
	Document function match(required Document filter){
		return getBsonFactory().Document(
			getJavaAggregates().match(
				arguments.filter.getMongoDocument()
			)
		);
	}




	/**
	 * Creates a $project pipeline stage for the specified projection
	 *
	 * @projection The projection - you are encouraged to use the Projections builder here
	 */
	Document function project(required Document projection){
		return getBsonFactory().Document(
			getJavaAggregates().project(
				arguments.projection.getMongoDocument()
			)
		);
	}




	/**
	 * Creates a $sort pipeline stage for the specified sort specification
	 *
	 * @sort The sort specification - you are encouraged to use the Sorts builder here
	 */
	Document function sort(required Document sort){
		return getBsonFactory().Document(
			getJavaAggregates().sort(
				arguments.sort.getMongoDocument()
			)
		);
	}




	/**
	 * Creates a $sortByCount pipeline stage for the specified filter
	 *
	 * @filter The filter specification (expression)
	 */
	Document function sortByCount(required filter){
		return getBsonFactory().Document(
			getJavaAggregates().sortByCount(
				getUtil().toMongo(
					arguments.filter
				)
			)
		);
	}




	/**
	 * Creates a $skip pipeline stage
	 *
	 * @skip The number of documents to skip
	 */
	Document function skip(required numeric skip){
		return getBsonFactory().Document(
			getJavaAggregates().skip(
				javaCast("int", arguments.skip)
			)
		);
	}




	/**
	 * Creates a $limit pipeline stage for the specified filter
	 *
	 * @limit The limit
	 */
	Document function limit(required numeric limit){
		return getBsonFactory().Document(
			getJavaAggregates().limit(
				javaCast("int", arguments.limit)
			)
		);
	}




	/**
	 * Creates a $lookup pipeline stage.
	 *
	 * 
	 */
	Document function lookup(){
		switch( arguments.len() ){
			case 3:
				// lookup(String from, Document[] pipeline, String as)
				return getBsonFactory().Document(
						getJavaAggregates().lookup(
							javaCast("string", arguments[1]),
							getUtil().toMongo(arguments[2]),
							javaCast("string", arguments[3])
						)
					);
			break;

			case 4:
				if( isArray(arguments[2]) && isArray(arguments[3]) ){
					// lookup(String from, Variable[] let, Document[] pipeline, String as)

				}
				else{
					// lookup(String from, String localField, String foreignField, String as)
					return getBsonFactory().Document(
						getJavaAggregates().lookup(
							javaCast("string", arguments[1]),
							javaCast("string", arguments[2]),
							javaCast("string", arguments[3]),
							javaCast("string", arguments[4])
						)
					);
				}
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'lookup(String from, Document[] pipeline, String as)' or 'lookup(String from, Variable[] let, Document[] pipeline, String as)' or 'lookup(String from, String localField, String foreignField, String as)'.", detail="");
			break;
		}

		
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	/**
	 * 
	 *
	 * @fieldName The field name
	 * @value2 
	 */
	Document function functionname(required string fieldName, required value2){
		return getBsonFactory().Document(
			getJavaAggregates().functionname(
				javaCast("string", arguments.fieldName),
				getUtil().toMongo(
					arguments.value2
				)
			)
		);
	}




	

}
