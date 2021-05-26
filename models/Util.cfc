/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="ModelFactory" inject="ModelFactory@box-mongodb-sdk";
	property name="MongoFactory" inject="MongoFactory@box-mongodb-sdk";

	// Local properties
	property name="NullSupport" type="boolean" default="false"; // For future use

	public function init(){
		return this;
	}




	/**
	 * Translates objects into Java objects understood by MongoDB.
	 * Currently does it by extracting underlying Java objects from CF wrapper objects (all of which should implement getBaseJavaObject() method). 
	 * Returns unchanged argument in case it's a Java object.
	 * Goes over structs and arrays recursively. 
	 *
	 * @object Simple value, struct, array, CF wrapper object (e.g. Document, ObjectId, etc.), Java object (e.g. "org.bson.Document", "org.bson.types.ObjectId", etc.) or null.
	 */
	function toMongo(object){
		
		if( isNull(arguments.object) ){
			return javaCast("null", "");
		}

		// Nested methods
		var structRecurse=function(required struct str){
			for(var key in arguments.str){
				if( isNull( str[key] ) ){

				}
				else if ( isObject( str[key] ) ){
					arguments.str[key]=toMongo(arguments.str[key]);
				}
				else if ( isStruct( arguments.str[key] ) ) {
					arguments.str[key]=structRecurse(arguments.str[key]);
				}
				else if ( isArray( arguments.str[key] ) ) {
					arguments.str[key]=arrayRecurse(arguments.str[key]);
				}
				else{
					// do nothing
				}
			}

			// Convert to native Document
			return getJavaFactory().getJavaObject("org.bson.Document").init(arguments.str);
		}

		var arrayRecurse=function(required array arr){
			for (var i = 1; i <= arguments.arr.len(); i++) {
				if( isNull( arguments.arr[i] ) ){
					
				}
				else if ( isObject( arguments.arr[i] ) ){
					arguments.arr[i]=toMongo(arguments.arr[i]);
				}
				else if ( isStruct( arguments.arr[i] ) ) {
					arguments.arr[i]=structRecurse(arguments.arr[i]);
				}
				else if ( isArray( arguments.arr[i] ) ) {
					arguments.arr[i]=arrayRecurse(arguments.arr[i]);
				}
				else{
					// do nothing
				}
			}

			// Convert to native Java array
			return getJavaFactory().getJavaObject("java.util.ArrayList").init(arguments.arr);
		}


		if( isObject( arguments.object ) ){
			var metadata=getMetadata(arguments.object);

			// Detect whether argument is a CF wrapper object or raw Java object
			if(isStruct(metadata) && metadata.keyExists("type") && metadata["type"] == "component"){
				// CF wrapper object
				switch(metadata["name"]){
					/* case "":
						
					break; */
				
					default:
						// Return underlying Java object
						return arguments.object.getBaseJavaObject();
					break;
				}
			}
			else if(isObject(metadata)){
				// Assuming Java object
				return arguments.object;
			}
			else{
				// TODO: determine whether to convert to native Java, returning unchanged argument for now
				return arguments.object;
			}
		}
		else if( isStruct( arguments.object ) ){
			return structRecurse(arguments.object);
		}
		else if( isArray( arguments.object ) ){
			return arrayRecurse(arguments.object);
		}
		else{
			return arguments.object;
		}
		
	}




	/**
	 * Translates Java/MongoDB objects into CF objects.
	 * Returns unchanged argument in case it's a CF object.
	 * Goes over structs and arrays recursively. 
	 *
	 * @object Java object (e.g. "org.bson.Document", "org.bson.types.ObjectId", etc.)
	 */
	function toCF(object){

		if( isNull(arguments.object) ){
			return javaCast("null", "");
		}

		// Nested methods
		var structRecurse=function(required struct str){
			for(var key in arguments.str){
				if( isNull( arguments.str[key] ) ){

				}
				else if ( isObject( str[key] ) ){
					arguments.str[key]=toCF(arguments.str[key]);
				}
				else if ( isStruct( arguments.str[key] ) ) {
					arguments.str[key]=structRecurse(arguments.str[key]);
				}
				else if ( isArray( arguments.str[key] ) ) {
					arguments.str[key]=arrayRecurse(arguments.str[key]);
				}
				else{
					// do nothing
				}
			}

			return arguments.str;
		}

		var arrayRecurse=function(required array arr){
			for (var i = 1; i <= arguments.arr.len(); i++) {
				if( isNull( arguments.arr[i] ) ){
					
				}
				else if ( isObject( arguments.arr[i] ) ){
					arguments.arr[i]=toCF(arguments.arr[i]);
				}
				else if ( isStruct( arguments.arr[i] ) ) {
					// Make sure it's a struct and not Mongo Document
					var tmpMetadata=getMetadata(arguments.arr[i]);
					switch( tmpMetadata.getName() ){
						case "org.bson.Document": case "org.bson.BsonDocument":
							arguments.arr[i]=toCF(arguments.arr[i]);
						break;
					
						default:
							arguments.arr[i]=structRecurse(arguments.arr[i]);
						break;
					}
				}
				else if ( isArray( arguments.arr[i] ) ) {
					arguments.arr[i]=arrayRecurse(arguments.arr[i]);
				}
				else{
					// do nothing
				}
			}

			// Return as-is
			return arguments.arr;
		}

		var metadata=getMetadata(arguments.object);

		// Detect whether argument is a CF wrapper object or raw Java object
		if(isStruct(metadata) && metadata.keyExists("type") && metadata["type"] == "component"){
			// CF wrapper object
			return arguments.object;
		}
		else if(isObject(metadata)){
			// Assuming Java object
			switch(metadata.getName()){
				case "org.bson.types.ObjectId":
					return getBsonFactory().ObjectId(arguments.object);
				break;

				case "org.bson.BsonObjectId":
					return getBsonFactory().ObjectId(arguments.object);
				break;

				case "org.bson.types.Decimal128":
					return getBsonFactory().Decimal128(arguments.object);
				break;

				case "java.lang.Integer": case "org.bson.BsonInt32":
					return getBsonFactory().Int32(arguments.object);
				break;

				case "java.lang.Long": case "org.bson.BsonInt64":
					return getBsonFactory().Int64(arguments.object);
				break;

				case "java.util.Date":
					return getBsonFactory().DateTime(arguments.object);
				break;

				case "org.bson.Document": case "org.bson.BsonDocument":
					return getBsonFactory().Document(arguments.object);
				break;

				case "java.util.ArrayList":
					return arrayRecurse(arguments.object);
				break;

				case "com.mongodb.client.model.Variable":
					return getModelFactory().Variable(arguments.object);
				break;

				case "com.mongodb.client.model.BsonField":
					return getModelFactory().BsonField(arguments.object);
				break;

				case "java.util.LinkedHashMap$LinkedKeySet":
					return arguments.object.toArray();
				break;

				case "com.mongodb.ServerAddress":
					return getMongoFactory().ServerAddress(arguments.object);
				break;

				case "java.time.Instant":
					return getBsonFactory().DateTime(arguments.object);
				break;

				default:
					return arguments.object;	
				break;
			}
		}
		else if( isStruct( arguments.object ) ){
			return structRecurse(arguments.object);
		}
		else if( isArray( arguments.object ) ){
			return arrayRecurse(arguments.object);
		}
		else{
			return arguments.object;
		}
		
	}




	/**
	 * Utility method for converting standard responses (objects - CF components returned by toCF() method) 
	 * into simple CF data constructs: strings, numbers, dates, structs, arrays, etc.
	 *
	 * @object 
	 */
	function toSimpleCF(object){

		if( isNull(arguments.object) ){
			return javaCast("null", "");
		}

		// Nested methods
		var structRecurse=function(required struct str){
			for(var key in arguments.str){
				if( isNull( arguments.str[key] ) ){

				}
				else if ( isObject( str[key] ) ){
					arguments.str[key]=toSimpleCF(arguments.str[key]);
				}
				else if ( isStruct( arguments.str[key] ) ) {
					arguments.str[key]=structRecurse(arguments.str[key]);
				}
				else if ( isArray( arguments.str[key] ) ) {
					arguments.str[key]=arrayRecurse(arguments.str[key]);
				}
				else{
					// do nothing
				}
			}

			return arguments.str;
		}

		var arrayRecurse=function(required array arr){
			for (var i = 1; i <= arguments.arr.len(); i++) {
				if( isNull( arguments.arr[i] ) ){
					
				}
				else if ( isObject( arguments.arr[i] ) ){
					arguments.arr[i]=toSimpleCF(arguments.arr[i]);
				}
				else if ( isStruct( arguments.arr[i] ) ) {
					arguments.arr[i]=structRecurse(arguments.arr[i]);
				}
				else if ( isArray( arguments.arr[i] ) ) {
					arguments.arr[i]=arrayRecurse(arguments.arr[i]);
				}
				else{
					// do nothing
				}
			}

			// Return as-is
			return arguments.arr;
		}

		var documentRecurse=function(required Document doc){
			var response=[:];
			
			for(var k in arguments.doc.keySet()){
				var o=arguments.doc.get( k );
				
				if( isNull( o ) ){
					response[k]=javaCast("null", "");
				}
				else if( isObject( o ) ){
					// CF component
					response[k]=toSimpleCF( o );
				}
				else if( isStruct( o ) ){
					response[k]=structRecurse( o );					
				}
				else if( isArray( o ) ){
					response[k]=arrayRecurse( o );
				}
				else{
					response[k]=o;
				}
				
			}

			return response;
		}

		var metadata=getMetadata(arguments.object);

		// Detect whether argument is a CF wrapper object or raw Java object
		if(isStruct(metadata) && metadata.keyExists("type") && metadata["type"] == "component"){
			switch( metadata["name"].listLast(".") ){
				case "ObjectId":
					return arguments.object.toString();
				break;

				case "DateTime":
					return arguments.object.toDate();
				break;

				case "Decimal128":
					return arguments.object.doubleValue();
				break;

				case "Document":
					return documentRecurse(arguments.object);
				break;

				case "Double":
					return arguments.object.getValue();
				break;

				case "Int32":
					return arguments.object.getValue();
				break;

				case "Int64":
					return arguments.object.getValue();
				break;

				case "Null":
					return javaCast("null", "");
				break;

				default:
					return arguments.object;	
				break;
			}
		}
		else if( isStruct( arguments.object ) ){
			return structRecurse(arguments.object);
		}
		else if( isArray( arguments.object ) ){
			return arrayRecurse(arguments.object);
		}
		else{
			return arguments.object;
		}
	}



	/**
	* Converts query struct or pipeline array to MongoDB BsonDocument format. 
	* Not compatible with older MongoDB versions that still use DBObject 
	* (see https://stackoverflow.com/a/29758237/2131787 for more insight). 
	* 
	* Use plain JSON notation (Strict Mode) for complex data and objects in queries, e.g.
	* 	{"_id":{"$oid":"5917654b4420c216dd1bd0dd"}} for specifying _id in search criteria, 
	*	{"$date": "20190510T00:01:02.000T"} for specifying dates in search criteria,
	* 	or: {"field":{"$regex": "^value$", "$options": "i"}} for case-insensitive searches.
	*	See: https://docs.mongodb.com/manual/reference/mongodb-extended-json/
	*/
	function toBsonDocument(required any data){
		if(isObject(arguments.data)){
			return arguments.data;
		}
		else if(isArray(arguments.data)){
			var javaArrayList = getJavaFactory().getJavaObject("java.util.ArrayList");

			for(var i in arguments.data){
				javaArrayList.add(toBsonDocument(i));
			}

			return javaArrayList;
			
		}
		else {
			var doc = getJavaFactory().getJavaObject("org.bson.BsonDocument");
			return doc.parse(serializeJSON(arguments.data));
		}
	}




	/**
	 * Converts CF to MongoDB Document.
	 * You're in charge of the datatypes! (e.g. ObjectId)
	 *
	 * @data CF data to be converted, usually a struct or array.
	 */
	function toDocument(required any data){
		if(isObject(arguments.data)){
			return arguments.data;
		}
		else if(isArray(arguments.data)){
			var list = getJavaFactory().getJavaObject("java.util.ArrayList");

			for(var i in arguments.data){
				list.add(toDocument(i));
			}

			return list;
			
		}
		else {
			var doc = getJavaFactory().getJavaObject("org.bson.Document");
			return doc.init(arguments.data);
		}
	}




	public any function ObjectId(string _id="") {
		if(len(arguments._id)){
			return getJavaFactory().getJavaObject("org.bson.types.ObjectId").init(arguments._id);
		}
		else{
			return getJavaFactory().getJavaObject("org.bson.types.ObjectId").init();
		}
	}




	function isObjectId(required string id){
		return getJavaFactory().getJavaObject("org.bson.types.ObjectId").isValid(arguments.id);
	}




	function isObjectIdString(required string sId){

		return (
			isSimpleValue(sId) 
			&& 
			!isNumeric(sId)
			&&
			left(trim(sId),1) != '$'
			&&
			arrayLen(sId.getBytes("UTF-8")) == 24
		);
	}




	/**
	* DEPRECATED: Returns the results of a MongoIterable object as an array of documents
	*/
	function mongoIterableToArray(required any mongoIterable){
		var aResults = [];
		var cursor = mongoIterable.iterator();
		
		while(cursor.hasNext()){
			var nextResult = cursor.next();
			
			if(isObject(nextResult)){
				switch(getMetadata(nextResult).getCanonicalName()){
					case "org.bson.BsonString":
						nextResult=nextResult.asString().getValue();
					break;

					case "com.mongodb.client.gridfs.model.GridFSFile":
						nextResult={
							"hashCode":nextResult.hashCode(),
							"length":nextResult.getLength(),
							"_id":nextResult.getObjectId(),
							"uploadDate":nextResult.getUploadDate(),
							"fileName":nextResult.getFilename(),
							"metadata":nextResult.getMetadata(),
							"chunkSize":nextResult.getChunkSize(),
							"md5":nextResult.getMD5()
						};
					break;
				
					default:
						throw(type = "box-mongodb-sdk.unsupportedObjectTypeException", message = "Support for object '#getMetadata(nextResult).getCanonicalName()#' has not yet been implemented in box-mongodb-sdk", detail="");
					break;
				}
			}
			
			arrayAppend(aResults, nextResult);
		}

		cursor.close();

		return toCF(aResults);
	}
}
