/**
* Factory object which returns initialized "helper object" representing BSON types
*/

component output="false" accessors="true" {

	property name="Wirebox" inject="wirebox";

	public function init(){
		return this;
	}




	/**
	 * Initializes and returns the Document CF-wrapper object. Simulates java method overloading: initializes object with nothing, key-value or struct.
	 */
	public function Document() {
		
		switch(arguments.len()){
			case 0:
				return getWirebox().getInstance("Document@box-mongodb-sdk");
			break;

			case 1:
				if(isStruct(arguments[1])){
					return getWirebox().getInstance("Document@box-mongodb-sdk").initWithStruct(arguments[1]);
				}
				else if(isNull(arguments[1])){
					return getWirebox().getInstance("Document@box-mongodb-sdk");
				}
				else{
					throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with a struct or null.", detail="");
				}
			break;

			case 2:
				try {
					if(isStruct(arguments[1]) && isObject(arguments[2]) && arguments[2].getName() == "org.bson.Document"){
						return getWirebox().getInstance("Document@box-mongodb-sdk").setMongoDocument(arguments[1]);
					}
					else if(getMetadata(arguments[1]).getName() == "java.lang.String"){
						return getWirebox().getInstance("Document@box-mongodb-sdk").initWithKeyValue(arguments[1], arguments[2]);
					}
					else{
						throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. First argument should be 'java.lang.String'.", detail="");
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
	public function ObjectId() {
		switch(arguments.len()){
			case 0:
				return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initEmpty();
			break;

			case 1:
				try {
					var clazzName=getMetadata(arguments[1]).getName();

					if(clazzName == "java.lang.String"){
						return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithId(arguments[1]);
					}
					else if (clazzName == "org.bson.BsonObjectId") {
						return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithBsonObjectId(arguments[1]);
					}
					else if (clazzName == "org.bson.types.ObjectId") {
						return getWirebox().getInstance("ObjectId@box-mongodb-sdk").initWithObjectId(arguments[1]);
					}
					else{
						throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with 'java.lang.String'.", detail="");
					}
				} 
				catch (any e) {
					rethrow;
				}
			break;

			case 2:
				// In order to avoid double metadata evaluation, first argument is Java ObjectId, and second-its metadata.
				try {
					var clazzName=arguments[2].getName();
					switch(clazzName){
						case "org.bson.types.ObjectId":
							return getWirebox().getInstance("ObjectId@box-mongodb-sdk").setObjectId(arguments[1]);
						break;
					
						default:
							throw(type = "box-mongodb-sdk.invalidArgumentException", message = "Invalid argument [2]. Expected 'org.bson.types.ObjectId'.", detail="");
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
	public function Decimal128() {
		switch(arguments.len()){
			case 1:
				if( isObject( arguments.number ) ){
					try {
						var clazzName=getMetadata(arguments.number).getName();
		
						if(clazzName == "java.math.BigDecimal"){
							return getWirebox().getInstance("Decimal128@box-mongodb-sdk").initWithBigDecimal(arguments.number);
						}
						else{
							throw(type = "box-mongodb-sdk.invalidConstructorException", message = "Invalid argument. Please initialize with 'java.math.BigDecimal'.", detail="");
						}
					} 
					catch (any e) {
						rethrow;
					}
				}
				else{
					return getWirebox().getInstance("Decimal128@box-mongodb-sdk").initWithString(arguments.number);
				}
			break;

			case 2:
				// In order to avoid double metadata evaluation, first argument is Java Decimal128, and second-its metadata.
				try {
					var clazzName=arguments[2].getName();
					switch(clazzName){
						case "org.bson.types.Decimal128":
							return getWirebox().getInstance("Decimal128@box-mongodb-sdk").setDecimal128(arguments[1]);
						break;
					
						default:
							throw(type = "box-mongodb-sdk.invalidArgumentException", message = "Invalid argument [2]. Expected 'org.bson.types.Decimal128'.", detail="");
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
	 * Initializes and returns the Int32 wrapper object.
	 *
	 * @number 
	 */
	public function Int32(required numeric number) {
		return getWirebox().getInstance("Int32@box-mongodb-sdk").initWithNumber(arguments.number);
	}




	/**
	 * Initializes and returns the Int64 wrapper object.
	 *
	 * @number 
	 */
	public function Int64(required numeric number) {
		return getWirebox().getInstance("Int64@box-mongodb-sdk").initWithNumber(arguments.number);
	}




	/**
	 * Initializes and returns the DateTime CF-wrapper object. Simulates java method overloading:
	 * 
	 * DateTime() : (with no arguments) - inits the object with current datetime and system time zone
	 * DateTime(string) : inits the object with ISO-8601 string
	 * DateTime(CFdateTimeObject) : inits the object with CF datetime object and system time zone
	 * DateTime(int year, int month, int dayOfMonth, int hour, int minute, int second, int nanosecond, ZoneId zone): inits the object with year, month (from 1 (January) to 12 (December)), day, hour (from 0 to 23), minute, second, nanosecond (from 0 to 999,999,999) and correctly initialized ZoneId object
	 */
	public function DateTime() {
		
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

			case 2:
				// In order to avoid double metadata evaluation, first argument is Java Date, and second-its metadata.
				try {
					var clazzName=arguments[2].getName();
					switch(clazzName){
						case "java.util.Date":
							return getWirebox().getInstance("DateTime@box-mongodb-sdk").initWithJavaDate(arguments[1]);
						break;
					
						default:
							throw(type = "box-mongodb-sdk.invalidArgumentException", message = "Invalid argument [2]. Expected 'java.util.Date'.", detail="");
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
}
