/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";

	// Local properties
	property name="MongoCollection" type="any" default="";


	public function init(){
		return this;
	}




	/**
	 * Aggregates documents according to the specified aggregation pipeline.
	 *
	 * @pipeline The aggregation pipeline
	 */
	public AggregateIterable function aggregate(required array pipeline) {
		return wirebox.getInstance("AggregateIterable@box-mongodb-sdk").setMongoIterable(
			getMongoCollection().aggregate(
				getUtil().toMongo(
					arguments.pipeline
				)
			)
		);
	}




	public any function bulkWrite(required array requests, struct options={}) {
		// TODO: Implement this method
		throw(type = "box-mongodb-sdk.notImplementedException", message = "Method 'bulkWrite()' is not yet implemented.", detail="");
	}




	/**
	 * Counts the number of documents in the collection according to the given options. 
	 * Note: For a fast count of the total documents in a collection see estimatedDocumentCount().
	 *
	 * @filter (optional) The query filter (Document)
	 * @options (optional) The options describing the count (CountOptions)
	 */
	public numeric function countDocuments(
		Document filter=getBsonFactory().Document(), 
		CountOptions options=getModelFactory().CountOptions()
	) {
		return getMongoCollection().countDocuments(
			arguments.filter.getMongoDocument(),
			arguments.options.getCountOptions()
		);
	}




	/**
	 * Gets an estimate of the count of documents in a collection using collection metadata.
	 */
	public numeric function estimatedDocumentCount(
		EstimatedDocumentCountOptions options=getModelFactory().EstimatedDocumentCountOptions()
	){
		return getMongoCollection().estimatedDocumentCount(
			arguments.options.getEstimatedDocumentCountOptions()
		)
	}




	/**
	 * Create an index with the given keys and options.
	 * Returns index name.
	 *
	 * @keys An object describing the index key(s), which may not be null.
	 * @options The options for the index
	 */
	public string function createIndex(
		required Document keys, 
		IndexOptions options=getWirebox().getInstance("IndexOptions@box-mongodb-sdk")
	) {
		return getMongoCollection().createIndex(
			arguments.keys.getMongoDocument(), 
			arguments.options.getIndexOptions()
		);
	}




	/**
	 * Create multiple indexes.
	 * Returns an array with index names.
	 *
	 * @indexes Array of structs 
	 * 	[
	 * 		{
	 * 			keys: <Document>,
	 * 			options: <IndexOptions>
	 * 		}
	 * 	]
	 */
	public array function createIndexes(required array indexes) {
		var response=[];

		for(var i in arguments.indexes){
			arrayAppend(response, createIndex(argumentCollection=i));
		}

		return response;
	}




	/**
	 * Removes all documents from the collection that match the given query filter. If no documents match, the collection is not modified.
	 *
	 * @filter The query filter to apply the the delete operation
	 * @options The options to apply to the delete operation
	 */
	public DeleteResult function deleteMany(
		Document filter=getBsonFactory().Document(),
		DeleteOptions options=getModelFactory().DeleteOptions()
	) {

		return wirebox.getInstance("DeleteResult@box-mongodb-sdk").setMongoDeleteResult(
			getMongoCollection().deleteMany(
				arguments.filter.getMongoDocument(),
				arguments.options.getDeleteOptions()
			)
		);

	}




	/**
	 * Removes at most one document from the collection that matches the given filter. If no documents match, the collection is not modified. 
	 *
	 * @filter The query filter to apply the the delete operation
	 * @options The options to apply to the delete operation
	 */
	public DeleteResult function deleteOne(
		Document filter=getBsonFactory().Document(),
		DeleteOptions options=getModelFactory().DeleteOptions()
	) {

		return wirebox.getInstance("DeleteResult@box-mongodb-sdk").setMongoDeleteResult(
			getMongoCollection().deleteOne(
				arguments.filter.getMongoDocument(),
				arguments.options.getDeleteOptions()
			)
		);

	}




	/**
	 * Gets the distinct values of the specified field name.
	 * Covers two scenarios:
	 * 		distinct(string fieldName)
	 * 		distinct(string fieldName, Document filter)
	 */
	public DistinctIterable function distinct() {
		switch( arguments.len() ){
			case 1:
				return getWirebox().getInstance("DistinctIterable@box-mongodb-sdk").setMongoIterable(
					getMongoCollection().distinct(
						javacast("string", arguments[1]), 
						getJavaFactory().getJavaObject("org.bson.BsonValue").getClass()
					)
				);
			break;

			case 2:
				return getWirebox().getInstance("DistinctIterable@box-mongodb-sdk").setMongoIterable(
					getMongoCollection().distinct(
						javacast("string", arguments[1]), 
						getUtil().toMongo(arguments[2]),
						getJavaFactory().getJavaObject("org.bson.BsonValue").getClass()
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'distinct(string fieldName)' or 'distinct(string fieldName, Document filter)'.", detail="");
			break;
		}
		
	}




	/**
	 * Drops this collection from the Database.
	 */
	public void function drop() {
		getMongoCollection().drop();
	}




	/**
	 * Drops the index.
	 * Covers two scenarios:
	 * 		dropIndex(string indexName)
	 * 		dropIndex(Document keys)
	 */
	public void function dropIndex() {
		switch( arguments.len() ){
			case 1:
				if( isValid("string", arguments[1]) ){
					getMongoCollection().dropIndex(
						javacast("string", arguments[1])
					);
				}
				else{
					getMongoCollection().dropIndex(
						getUtil().toMongo(
							arguments[1]
						)
					);
				}
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments. Usage: 'dropIndex(string indexName)' or 'dropIndex(Document keys)'.", detail="");
			break;
		}
	}



	/**
	* Drop all the indexes on this collection, except for the default on _id.
	*/
	public void function dropIndexes() {
		getMongoCollection().dropIndexes();
	}




	/**
	 * Finds all documents in the collection.
	 * Usage: 
	 * 		find()
	 * 		find(Document filter) - can be result of Filters.*()
	 * 		find(struct filter)
	 *
	 * @filter The query filter
	 */
	public FindIterable function find() {
		switch( arguments.len() ){
			case 0:
				return wirebox.getInstance("FindIterable@box-mongodb-sdk").setMongoIterable(
					getMongoCollection().find()
				);
			break;

			case 1:
				return wirebox.getInstance("FindIterable@box-mongodb-sdk").setMongoIterable(
					getMongoCollection().find(
						getUtil().toMongo(
							arguments[1]
						)
					)
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidArgumentsException", message = "Invalid arguments. Usage: 'find()' or 'find(Document filter)' or 'find(struct filter)'.", detail="");
			break;
		}
		
	}




	/**
	 * Creates a change stream for this collection.
	 */
	public ChangeStreamIterable function watch(array pipeline=[]){
		
		return getWirebox().getInstance("ChangeStreamIterable@box-mongodb-sdk").setChangeStreamIterable(
			getMongoCollection().watch(
				getUtil().toMongo(
					arguments.pipeline
				)
			)
		);

	}




	/**
	 * Atomically find a document and remove it. 
	 *
	 * @filter The query filter to find the document with
	 * @options The options to apply to the operation
	 * 
	 * Returns the document that was removed. If no documents matched the query filter, then null will be returned
	 */
	public function findOneAndDelete(
		required Document filter, 
		FindOneAndDeleteOptions options=getModelFactory().FindOneAndDeleteOptions()
	) {
		
		var result=getMongoCollection().findOneAndDelete(
			arguments.filter.getMongoDocument(), 
			arguments.options.getFindOneAndDeleteOptions()
		);
		
		return isNull(result) ? javaCast("null", "") : BsonFactory.Document(result);
	}




	public struct function findOneAndReplace(struct filter={}, struct replacement={}, struct options={}) {
		var filter=getUtil().toDocument(arguments.filter);
		var findOneAndReplaceOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.FindOneAndReplaceOptions");
		var replaceDocument=getUtil().toDocument(arguments.replacement);

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					findOneAndReplaceOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "maxTime":
					var tuObj=getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit");
					var tu=tuObj[arguments.options[i]["timeUnit"]];
					findOneAndReplaceOptions.maxTime(javacast("long", arguments.options[i]["maxTime"]), tu);
				break;

				case "projection":
					var filter=getUtil().toBsonDocument(arguments.options[i]);
					findOneAndReplaceOptions.projection(filter);
				break;

				case "returnDocument":
					// Two values currently supported: BEFORE, AFTER. Default driver value: BEFORE.
					var returnDocument=getJavaFactory().getJavaObject("com.mongodb.client.model.ReturnDocument");
					findOneAndReplaceOptions.returnDocument(returnDocument[uCase(arguments.options[i])]);
				break;

				case "sort":
					var filter=getUtil().toBsonDocument(arguments.options[i]);
					findOneAndReplaceOptions.sort(filter);
				break;

				case "upsert":
					findOneAndReplaceOptions.upsert(javacast("boolean", arguments.options[i]));
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		var result=getMongoCollection().findOneAndReplace(filter, replaceDocument, findOneAndReplaceOptions);
		
		if(isNull(result)){
			throw(type = "box-mongodb-sdk.documentNotFoundException", message = "Document not found", detail="");
		}

		return getUtil().toCF(result);
	}




	/**
	 * Atomically find a document and update it. 
	 *
	 * @filter A document describing the query filter, which may not be null.
	 * @update A document or pipeline describing the update, which may not be null. The update to apply must include at least one update operator.
	 * @options The options to apply to the operation.
	 * 
	 * Returns the document that was updated: Depending on the value of the returnOriginal option, 
	 * this will either be the document as it was before the update or as it is after the update. 
	 * If no documents matched the query filter, then null will be returned
	 */
	function findOneAndUpdate(
		required filter, 
		required update, 
		options=getModelFactory().FindOneAndUpdateOptions()
	) {
		
		return getUtil().toCF(
			getMongoCollection().findOneAndUpdate(
				getUtil().toMongo(arguments.filter), 
				getUtil().toMongo(arguments.update), 
				arguments.options.getFindOneAndUpdateOptions()
			)
		);
		
	}




	public void function insertMany(required array documents, struct options={}) {
		var docs=getUtil().toDocument(arguments.documents);
		var insertManyOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.InsertManyOptions");

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					insertManyOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "ordered":
					insertManyOptions.ordered(javacast("boolean", arguments.options[i]));
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		getMongoCollection().insertMany(docs, insertManyOptions);
	}




	/**
	 * Inserts one document. 
	 *
	 * @document 
	 * @options 
	 * 
	 * Returns InsertOneResult object. 
	 */
	public InsertOneResult function insertOne(
		required Document document, 
		InsertOneOptions options=getWirebox().getInstance("InsertOneOptions@box-mongodb-sdk")
	) {


		return getWirebox().getInstance("InsertOneResult@box-mongodb-sdk").setInsertOneResult(
			getMongoCollection().insertOne(
				arguments.document.getMongoDocument(), 
				arguments.options.getInsertOneOptions()
			)
		);

	}




	public ListIndexesIterable function listIndexes() {
		var listIndexesIterable=wirebox.getInstance("ListIndexesIterable@box-mongodb-sdk");

		var result=getMongoCollection().listIndexes();

		listIndexesIterable.setMongoIterable(result);

		return listIndexesIterable;
	}




	public MapReduceIterable function mapReduce(required string mapFunction, required string reduceFunction) {
		var mapReduceIterable=wirebox.getInstance("MapReduceIterable@box-mongodb-sdk");

		var result=getMongoCollection().mapReduce(arguments.mapFunction, arguments.reduceFunction);

		mapReduceIterable.setMongoIterable(result);

		return mapReduceIterable;
	}



	/**
	* Rename the collection with oldCollectionName to the newCollectionName.
	* Full namespace (e.g. "database.collection") should be provided. Otherwise "state should be: databaseName is not empty" error will be raised by the driver.
	* https://docs.mongodb.com/manual/reference/command/renameCollection/#dbcmd.renameCollection
	*/
	public void function renameCollection(required string newCollectionNamespace, struct options={}) {
		var mongoNamespace=getJavaFactory().getJavaObject("com.mongodb.MongoNamespace");
		var renameCollectionOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.RenameCollectionOptions");

		mongoNamespace.init(javacast("string", arguments.newCollectionNamespace));

		for(var i in arguments.options){
			switch(i){
				case "dropTarget":
					renameCollectionOptions.dropTarget(javacast("boolean", arguments.options[i]));
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		getMongoCollection().renameCollection(mongoNamespace, renameCollectionOptions);
	}




	public UpdateResult function replaceOne(
		Document filter, 
		Document replacement, 
		ReplaceOptions replaceOptions=getModelFactory().ReplaceOptions()
	) {
		
		var result=getMongoCollection().replaceOne(
			arguments.filter.getMongoDocument(), 
			arguments.replacement.getMongoDocument(), 
			arguments.replaceOptions.getReplaceOptions()
		);
		
		if(isNull(result)){
			throw(type = "box-mongodb-sdk.documentNotFoundException", message = "Document not found", detail="");
		}

		return wirebox.getInstance("UpdateResult@box-mongodb-sdk").setUpdateResult(result);

	}




	public UpdateResult function updateMany(struct filter={}, struct update={}, struct options={}) {
		var updateOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.UpdateOptions");
		var filter=getUtil().toDocument(arguments.filter);
		var replaceDocument=getUtil().toDocument(arguments.update);
		var updateResult=wirebox.getInstance("UpdateResult@box-mongodb-sdk");

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					updateOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "upsert":
					updateOptions.upsert(javacast("boolean", arguments.options[i]));
				break;

				case "arrayFilters":
					updateOptions.arrayFilters( getUtil().toDocument(arguments.options[i]) );
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		var result=getMongoCollection().updateMany(filter, replaceDocument, updateOptions);
		
		if(isNull(result)){
			throw(type = "box-mongodb-sdk.documentNotFoundException", message = "Document not found", detail="");
		}

		updateResult.setUpdateResult(result);

		return updateResult;
	}




	public UpdateResult function updateOne(struct filter={}, struct update={}, struct options={}) {
		var updateOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.UpdateOptions");
		var filter=getUtil().toDocument(arguments.filter);
		var updateDocument=getUtil().toDocument(arguments.update);
		var updateResult=wirebox.getInstance("UpdateResult@box-mongodb-sdk");

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					updateOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "upsert":
					updateOptions.upsert(javacast("boolean", arguments.options[i]));
				break;

				case "arrayFilters":
					updateOptions.arrayFilters( getUtil().toDocument(arguments.options[i]) );
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		var result=getMongoCollection().updateOne(filter, updateDocument, updateOptions);

		updateResult.setUpdateResult(result);

		return updateResult;
	}
}
