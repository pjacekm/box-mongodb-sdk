/**
* Factory object which returns initialized "helper object" representing BSON types
*/

component output="false" accessors="true" {

	property name="Wirebox" inject="wirebox";

	function init(){
		return this;
	}




	/**
	 * Initializes and returns the Document CF-wrapper object. Simulates java method overloading: initializes object with nothing, key-value or struct.
	 */
	function Document() {
		
		switch(arguments.len()){
			case 0:
				return getWirebox().getInstance("Document@box-mongodb-sdk").initEmpty();
			break;

			case 1:
				if(isStruct(arguments[1])){
					switch( getMetadata( arguments[1] ).getName() ){
						case "org.bson.Document": case "org.bson.BsonDocument":
							return getWirebox().getInstance("Document@box-mongodb-sdk").initWithBsonDocument(arguments[1]);
						break;

						default:
							return getWirebox().getInstance("Document@box-mongodb-sdk").initWithStruct(arguments[1]);
						break;
					}
				}
				else if (isObject(arguments[1])) {
					return getWirebox().getInstance("Document@box-mongodb-sdk").initWithBsonDocument(arguments[1]);
				}
				else if(isNull(arguments[1])){
					return getWirebox().getInstance("Document@box-mongodb-sdk");
				}
				else{
					throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with a struct, Java object or null.", detail="");
				}
			break;

			case 2:
				try {
					switch( getMetadata(arguments[1]).getName() ){
						case "java.lang.String":
							return getWirebox().getInstance("Document@box-mongodb-sdk").initWithKeyValue(arguments[1], arguments[2]);
						break;
					
						default:
							throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. First argument should be 'java.lang.String'.", detail="");
						break;
					}
				} 
				catch (any e) {
					rethrow;
				}
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments", detail="");
			break;
		}
		
	}




	/**
	 * Initializes and returns the ObjectId CF-wrapper object. Simulates java method overloading: initializes object with nothing or string representation of _id.
	 */
	function ObjectId() {
		switch(arguments.len()){
			case 0:
				return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initEmpty();
			break;

			case 1:
				try {
					switch( getMetadata(arguments[1]).getName() ){
						case "java.lang.String":
							return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithId(arguments[1]);
						break;

						case "org.bson.BsonObjectId":
							return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithBsonObjectId(arguments[1]);
						break;

						case "org.bson.types.ObjectId":
							return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithObjectId(arguments[1]);
						break;
					
						default:
							throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with 'java.lang.String', 'org.bson.BsonObjectId' or 'org.bson.types.ObjectId'.", detail="");
						break;
					}

				} 
				catch (any e) {
					rethrow;
				}
			break;

			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Too many arguments", detail="");
			break;
		}
	}




	/**
	 * Initializes and returns the Decimal128 wrapper object.
	 *
	 * @number 
	 */
	function Decimal128() {
		switch(arguments.len()){
			case 0:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Missing argument", detail="");
			break;

			case 1:
				if( isObject( arguments[1] ) ){
					try {
						switch( getMetadata(arguments[1]).getName() ){
							case "java.math.BigDecimal":
								return getWirebox().getInstance("Decimal128@box-mongodb-sdk").initWithBigDecimal(arguments[1]);
							break;
						
							default:
								throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with 'java.math.BigDecimal'.", detail="");
							break;
						}
					} 
					catch (any e) {
						rethrow;
					}
				}
				else{
					return getWirebox().getInstance("Decimal128@box-mongodb-sdk").initWithString(arguments[1]);
				}
			break;

			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Too many arguments", detail="");
			break;
		}
		
		
	}




	/**
	 * Initializes and returns the Int32 wrapper object.
	 * Covers two scenarios:
	 * 		Int32(object BsonInt32)
	 * 		Int32(integer number)
	 *  
	 */
	function Int32() {
		switch( arguments.len() ){
			case 1:
				if( isObject(arguments[1]) ){
					return getWirebox().getInstance("Int32@box-mongodb-sdk").initWithBsonInt32(arguments[1]);
				}
				else if( isValid("integer", arguments[1]) ){
					return getWirebox().getInstance("Int32@box-mongodb-sdk").initWithNumber(arguments[1]);
				}
				else{
					throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Usage: 'Int32(object BsonInt32)' or 'Int32(integer number)'.", detail="");
				}
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Usage: 'Int32(object BsonInt32)' or 'Int32(integer number)'.", detail="");
			break;
		}
	}




	/**
	 * Initializes and returns the Int64 wrapper object.
	 * Covers two scenarios:
	 * 		Int64(object BsonInt64)
	 * 		Int64(integer number)
	 *  
	 */
	function Int64() {
		switch( arguments.len() ){
			case 1:
				if( isObject(arguments[1]) ){
					return getWirebox().getInstance("Int64@box-mongodb-sdk").initWithBsonInt64(arguments[1]);
				}
				else if( isValid("integer", arguments[1]) ){
					return getWirebox().getInstance("Int64@box-mongodb-sdk").initWithNumber(arguments[1]);
				}
				else{
					throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Usage: 'Int64(object BsonInt64)' or 'Int64(integer number)'.", detail="");
				}
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Usage: 'Int64(object BsonInt64)' or 'Int64(integer number)'.", detail="");
			break;
		}
	}




	/**
	 * Initializes and returns the Double wrapper object.
	 *
	 * @number 
	 */
	function Double(required numeric number) {
		return getWirebox().getInstance("Double@box-mongodb-sdk").initWithNumber(arguments.number);
	}




	/**
	 * Initializes and returns the DateTime CF-wrapper object. Simulates java method overloading:
	 * 
	 * DateTime() : (with no arguments) - inits the object with current datetime and system time zone
	 * DateTime(string) : inits the object with ISO-8601 string
	 * DateTime(CFdateTimeObject) : inits the object with CF datetime object and system time zone
	 * DateTime(int year, int month, int dayOfMonth, int hour, int minute, int second, int nanosecond, ZoneId zone): inits the object with year, month (from 1 (January) to 12 (December)), day, hour (from 0 to 23), minute, second, nanosecond (from 0 to 999,999,999) and correctly initialized ZoneId object
	 */
	function DateTime() {
		
		switch(arguments.len()){
			case 0:
				// Init as now()
				return getWirebox().getInstance("DateTime@box-mongodb-sdk").initWithNow();
			break;

			case 1:
				// Let's determine if CF date/time object or ISO string was passed in
				try {
					var cn=getMetadata( arguments[1] ).getName();
					
					if( cn.listLast(".").findNoCase("Date") ){
						// Init with CF DateTime
						return getWirebox().getInstance("DateTime@box-mongodb-sdk").initWithCFDateTime( arguments[1] );
					}
					else if ( cn.listLast(".") == "String" ) {
						// Init with ISO-8601 (should also support other formats)
						return getWirebox().getInstance("DateTime@box-mongodb-sdk").initWithString( arguments[1] );
					}
					else{
						throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with a CF DateTime or an ISO-8601 string.", detail="");
					}
				} 
				catch (any e) {
					rethrow;
				}
			break;

			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid arguments", detail="");
			break;
		}
		
	}




	/**
	 * Initializes and returns the Null wrapper object.
	 *
	 */
	function Null() {
		return getWirebox().getInstance("Null@box-mongodb-sdk");
	}




	/**
	 * Initializes and returns the RegularExpression wrapper object.
	 *
	 */
	function RegularExpression() {
		switch(arguments.len()){
			case 1:
				return getWirebox().getInstance("RegularExpression@box-mongodb-sdk").initWithPattern(arguments[1]);
			break;

			case 2:
				return getWirebox().getInstance("RegularExpression@box-mongodb-sdk").initWithPatternAndOptions(
					arguments[1],
					arguments[2]
				);
			break;
		
			default:
				throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid or missing arguments", detail="");
			break;
		}
	}
}
