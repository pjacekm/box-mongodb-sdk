/**
*
* @author pjacekm@gmail.com
* @description 
*
*/

component output="false" accessors="true" singleton {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="Buckets" type="struct" setter="false";

	public function init(){
		// Initialize default complex properties
		variables["Buckets"]={};
		return this;
	}




	public GridFSBucket function create(required MongoDatabase database, string bucketName="fs") {
		var buckets=getBuckets();
		var cacheKey=hash(arguments.database.getName() & arguments.bucketName);

		if(!structKeyExists(buckets, cacheKey)){
			lock name="mongoBucketsCache" type="exclusive" throwOnTimeout="true" timeout=30 {
				if(!structKeyExists(buckets, cacheKey)){
					var bucket=getWirebox().getInstance("GridFSBucket@box-mongodb-sdk");
					var mongoBucket=getJavaFactory().getJavaObject("com.mongodb.client.gridfs.GridFSBuckets").create(
						arguments.database.getMongoDatabase(),
						javacast("string", arguments.bucketName)
					);
					bucket.setGridFSBucket(mongoBucket);
					buckets[cacheKey]=bucket;
				}
			}
		}

		return buckets[cacheKey];
	}
}
