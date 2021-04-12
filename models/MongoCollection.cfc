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

	// Local properties
	property name="MongoCollection" type="any" default="";


	public function init(){
		return this;
	}




	public AggregateIterable function aggregate(required array pipeline) {
		var aggregateIterable=wirebox.getInstance("AggregateIterable@box-mongodb-sdk");

		var filter=getUtil().toDocument(arguments.pipeline);
		var result=getMongoCollection().aggregate(filter);

		aggregateIterable.setMongoIterable(result);

		return aggregateIterable;
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
		CountOptions options=getWirebox().getInstance("CountOptions@box-mongodb-sdk")
	) {
		return getMongoCollection().countDocuments(
			arguments.filter.getMongoDocument(),
			arguments.options.getCountOptions()
		);
	}




	/**
	 * Gets an estimate of the count of documents in a collection using collection metadata.
	 */
	public numeric function estimatedDocumentCount(){
		return getMongoCollection().estimatedDocumentCount()
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
		IndexOptions options=getWirebox.getInstance("IndexOptions@box-mongodb-sdk")
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




	public DeleteResult function deleteMany(struct filter={}) {
		var deleteResult=wirebox.getInstance("DeleteResult@box-mongodb-sdk");

		var query=getUtil().toDocument(arguments.filter);
		var result=getMongoCollection().deleteMany(query);

		deleteResult.setMongoDeleteResult(result);

		return deleteResult;
	}




	public DeleteResult function deleteOne(struct filter={}) {
		var deleteResult=wirebox.getInstance("DeleteResult@box-mongodb-sdk");

		var query=getUtil().toDocument(arguments.filter);
		var result=getMongoCollection().deleteMany(query);

		deleteResult.setMongoDeleteResult(result);

		return deleteResult;
	}




	public DistinctIterable function distinct(required string fieldName, struct filter={}) {
		var distinctIterable=wirebox.getInstance("DistinctIterable@box-mongodb-sdk");
		var query=getUtil().toDocument(arguments.filter);

		var result=getMongoCollection().distinct(
			javacast("string", arguments.fieldName), 
			query, 
			getJavaFactory().getJavaObject("org.bson.BsonValue").getClass()
		);

		distinctIterable.setMongoIterable(result);

		return distinctIterable;
	}




	public void function drop() {
		getMongoCollection().drop();
	}




	public void function dropIndex(required string indexName) {
		getMongoCollection().dropIndex(javacast("string", arguments.indexName));
	}



	/**
	* Drop all the indexes on this collection, except for the default on _id.
	*/
	public void function dropIndexes() {
		getMongoCollection().dropIndexes();
	}




	public FindIterable function find(Document filter=getBsonFactory().Document()) {
		return wirebox.getInstance("FindIterable@box-mongodb-sdk").setMongoIterable(
			getMongoCollection().find(arguments.filter.getMongoDocument())
		);
	}




	/**
	 * Creates a change stream for this collection.
	 */
	public ChangeStreamIterable function watch(array pipeline=[]){
		var changeStreamIterable=wirebox.getInstance("ChangeStreamIterable@box-mongodb-sdk");
		var filter=getUtil().toDocument(arguments.pipeline);

		changeStreamIterable.setChangeStreamIterable(
			getMongoCollection().watch(filter)
		);

		return changeStreamIterable;
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
		FindOneAndDeleteOptions options=getWirebox().getInstance("FindOneAndDeleteOptions@box-mongodb-sdk")
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




	public struct function findOneAndUpdate(struct filter={}, struct update={}, struct options={}) {
		var filter=getUtil().toDocument(arguments.filter);
		var findOneAndUpdateOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.FindOneAndUpdateOptions");
		var updateDocument=getUtil().toDocument(arguments.update);

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					findOneAndUpdateOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "maxTime":
					var tuObj=getJavaFactory().getJavaObject("java.util.concurrent.TimeUnit");
					var tu=tuObj[arguments.options[i]["timeUnit"]];
					findOneAndUpdateOptions.maxTime(javacast("long", arguments.options[i]["maxTime"]), tu);
				break;

				case "projection":
					var filter=getUtil().toBsonDocument(arguments.options[i]);
					findOneAndUpdateOptions.projection(filter);
				break;

				case "returnDocument":
					// Two values currently supported: BEFORE, AFTER. Default driver value: BEFORE.
					var returnDocument=getJavaFactory().getJavaObject("com.mongodb.client.model.ReturnDocument");
					findOneAndUpdateOptions.returnDocument(returnDocument[uCase(arguments.options[i])]);
				break;

				case "sort":
					var filter=getUtil().toBsonDocument(arguments.options[i]);
					findOneAndUpdateOptions.sort(filter);
				break;

				case "upsert":
					findOneAndUpdateOptions.upsert(javacast("boolean", arguments.options[i]));
				break;

				case "arrayFilters":
					updateOptions.arrayFilters( getUtil().toDocument(arguments.options[i]) );
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		var result=getMongoCollection().findOneAndUpdate(filter, updateDocument, findOneAndUpdateOptions);
		
		if(isNull(result)){
			throw(type = "box-mongodb-sdk.documentNotFoundException", message = "Document not found", detail="");
		}

		return getUtil().toCF(result);
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




	public UpdateResult function replaceOne(struct filter={}, struct replacement={}, struct options={}) {
		var updateOptions=getJavaFactory().getJavaObject("com.mongodb.client.model.UpdateOptions");
		var filter=getUtil().toDocument(arguments.filter);
		var replaceDocument=getUtil().toDocument(arguments.replacement);
		var updateResult=wirebox.getInstance("UpdateResult@box-mongodb-sdk");

		for(var i in arguments.options){
			switch(i){
				case "bypassDocumentValidation":
					updateOptions.bypassDocumentValidation(javacast("boolean", arguments.options[i]));
				break;

				case "upsert":
					updateOptions.upsert(javacast("boolean", arguments.options[i]));
				break;
			
				default:
					throw(type = "box-mongodb-sdk.optionNotImplementedException", message = "Option not implemented", detail="");
				break;
			}
		}

		var result=getMongoCollection().replaceOne(filter, replaceDocument, updateOptions);
		
		if(isNull(result)){
			throw(type = "box-mongodb-sdk.documentNotFoundException", message = "Document not found", detail="");
		}

		updateResult.setUpdateResult(result);

		return updateResult;
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
