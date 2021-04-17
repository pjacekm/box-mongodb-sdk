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
	 * Usage example:
	 * 		Aggregates.addFields(
	 *			[
	 *				ModelFactory.Field(
	 *					"field_name", 
	 *					BsonFactory.Document({ "$add": [ "$totalHomework", "$totalQuiz", "$extraCredit" ] })
	 *				),
	 *				ModelFactory.Field(
	 *					"another_name", 
	 *					"$another_field"
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
	 * Covers the following scenarios (overloaded methods in Java driver):
	 * 1. lookup(String from, Document[] pipeline, String as)
	 * 		Aggregates.lookup(
	 *			"collection1",
	 *			[
	 *	 			Aggregates.match(Filters.eq("a", "b"))
	 *			],
	 *			"outputField"
	 *		)
	 * 
	 * 2. lookup(String from, String localField, String foreignField, String as)
	 * 		Aggregates.lookup(
	 *			"collection1",
	 *			"field1",
	 *			"field2",
	 *			"outputField"
	 *		)
	 *
	 * 3. lookup(String from, Variable[] let, Document[] pipeline, String as)
	 * 		Aggregates.lookup(
	 *			"collection1",
	 *			[
	 *				ModelFactory.Variable("order_item", "$item"),
	 *				ModelFactory.Variable("order_qty", "$ordered")
	 *			],
	 *			[
	 *				Aggregates.match(Filters.eq("a", "b"))
	 *			],
	 *			"outputField"
	 *		)
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
					return getBsonFactory().Document(
						getJavaAggregates().lookup(
							javaCast("string", arguments[1]),
							getUtil().toMongo(arguments[2]),
							getUtil().toMongo(arguments[3]),
							javaCast("string", arguments[4])
						)
					);
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
	 * Creates a facet pipeline stage
	 * Example usage:
	 * 		Aggregates.facet(
	 *			[
	 *				ModelFactory.Facet(
	 *					"categorizedByTags",
	 *					[
	 *						BsonFactory.Document("$unwind", "$tags"),
	 *						BsonFactory.Document("$sortByCount", "$tags")
	 *					]
	 *				),
	 * 				ModelFactory.Facet(
	 *					"categorizedByPrice",
	 *					[
	 *						Aggregates.match(Filters.exists("price", true)),
	 *						...
	 *					]
	 *				),
	 *				...
	 *			]
	 *		)
	 *
	 * @facets The facets to use
	 */
	Document function facet(required Facet[] facets){
		return getBsonFactory().Document(
			getJavaAggregates().facet(
				getUtil().toMongo(
					arguments.facets
				)
			)
		);
	}




	/**
	 * Creates a graphLookup pipeline stage for the specified filter
	 * Example usage:
	 * 		Aggregates.graphLookup(
	 *			"from",
	 *			"$startWith",
	 *			"connectFromField",
	 *			"connectToField",
	 *			"as",
	 *			ModelFactory.GraphLookupOptions()
	 *				.depthField("depthField")
	 *				.maxDepth(5)
	 *				.restrictSearchWithMatch(
	 *					BsonFactory.Document({ "hobbies" : "golf" })
	 *				)
	 *		)
	 *
	 * @from The collection to query
	 * @startWith The expression to start the graph lookup with (string, struct or Document)
	 * @connectFromField The from field
	 * @connectToField The to field
	 * @as Name of field in output document
	 * @options Optional values for the graphLookup
	 */
	Document function graphLookup(
		required string from, 
		required startWith,
		required string connectFromField,
		required string connectToField,
		required string as,
		GraphLookupOptions options=getModelFactory().GraphLookupOptions()
	){
		return getBsonFactory().Document(
			getJavaAggregates().graphLookup(
				javaCast("string", arguments.from),
				getUtil().toMongo(
					arguments.startWith
				),
				javaCast("string", arguments.connectFromField),
				javaCast("string", arguments.connectToField),
				javaCast("string", arguments.as),
				getUtil().toMongo(
					arguments.options
				)
			)
		);
	}




	/**
	 * Creates a $group pipeline stage for the specified filter
	 * Usage examples:
	 * 		Aggregates.group(
	 *			BsonFactory.Document({"field": "$field"}),
	 *			[
	 *				ModelFactory.BsonField("count", BsonFactory.Document({"$sum": "$field2"}))
	 *			]
	 *		)
 	 *
	 *		Aggregates.group(
	 *			"$field",
	 *			[
	 *				ModelFactory.BsonField("count", BsonFactory.Document({"$sum": BsonFactory.Int32(1)}))
	 *			]
	 *		)
	 *
	 *		Aggregates.group(
	 *			BsonFactory.Null(),
	 *			[
	 *				ModelFactory.BsonField("count", BsonFactory.Document({"$sum": "$field2"}))
	 *			]
	 *		)
	 *
	 *		Aggregates.group(
	 *			javaCast("null", ""),
	 *			[
	 *				ModelFactory.BsonField("count", BsonFactory.Document({"$sum": "$field2"}))
	 *			]
	 *		)
	 *
	 *		Aggregates.group()
	 *
	 * @id The id expression for the group, which may be null (or the Null component), string, struct or Document
	 * @fieldAccumulators Zero or more field accumulator pairs
	 */
	Document function group(id=javaCast("null", ""), BsonField[] fieldAccumulators=[]){
		return getBsonFactory().Document(
			getJavaAggregates().group(
				isNull(arguments.id) ? javaCast("null", "") : getUtil().toMongo(arguments.id),
				getUtil().toMongo(arguments.fieldAccumulators)
			)
		);
	}




	/**
	 * Creates a $unionWith pipeline stage.
	 * Usage example:
	 * 		Aggregates.unionWith(
	 *			"collection",
	 *			[
	 *				Aggregates.project(
	 *					Projections.fields([
	 *						Projections.include(["field1", "field2"]),
	 *						Projections.excludeId()
	 *					])
	 *				)
	 *			]
	 *		)
	 *
	 * @collection The name of the collection in the same database to perform the union with.
	 * @pipeline The pipeline to run on the union.
	 */
	Document function unionWith(required string collection, required Document[] pipeline){
		return getBsonFactory().Document(
			getJavaAggregates().unionWith(
				javaCast("string", arguments.collection),
				getUtil().toMongo(
					arguments.pipeline
				)
			)
		);
	}




	/**
	 * Creates an $unwind pipeline stage for the specified field name, which must be prefixed by a '$' sign.
	 * Usage example:
	 * 		Aggregates.unwind(
	 *			"$fieldName",
	 *			ModelFactory.UnwindOptions()
	 *				.preserveNullAndEmptyArrays(true)
	 *				.includeArrayIndex("arrayIndex")
	 *		)
	 *
	 * @fieldName The field name, prefixed by a '$' sign
	 * @unwindOptions Options for the unwind pipeline stage
	 */
	Document function unwind(
		required string fieldName, 
		UnwindOptions unwindOptions=getModelFactory().UnwindOptions()
	){
		return getBsonFactory().Document(
			getJavaAggregates().unwind(
				javaCast("string", arguments.fieldName),
				arguments.unwindOptions.getUnwindOptions()
			)
		);
	}




	/**
	 * 1. Creates a $out pipeline stage that writes into the specified collection
	 * Usage example:
	 * 		Aggregates.out(
	 *			"collection1"
	 *		)
	 *
	 *	2. Creates a $out pipeline stage that supports outputting to a different database.
	 *	Usage example:
	 *		Aggregates.out(
	 *			"database1",
	 *			"collection1"
	 *		)
	 *
	 *	3. Creates a $out pipeline stage that writes out to the specified destination
	 *	Usage example:
	 *		Aggregates.out(
	 *			BsonFactory.Document({ "db": "reporting", "coll": "authors" })
	 *		)
	 */
	Document function out(){
		switch( arguments.len() ){
			case 1:
				if( isSimpleValue(arguments[1]) ){
					// out(string collectionName)
					return getBsonFactory().Document(
						getJavaAggregates().out(
							javaCast("string", arguments[1])
						)
					);
				}
				else{
					// out(Document destination)
					return getBsonFactory().Document(
						getJavaAggregates().out(
							getUtil().toMongo(
								arguments[1]
							)
						)
					);
				}
			break;

			case 2:
				// out(string databaseName, string collectionName)
				return getBsonFactory().Document(
					getJavaAggregates().out(
						javaCast("string", arguments[1]),
						javaCast("string", arguments[2])
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'out(String collectionName)' or 'out(String databaseName, String collectionName)' or 'out(Document destination)'.", detail="");
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




	

}
