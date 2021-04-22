/**
* Wrapper for com.mongodb.client.model.IndexOptions.
* Carries the options to apply to the creation of an index.
*/

component output="false" accessors="true" {
	
	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="BsonFactory" inject="BsonFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";
	property name="Wirebox" inject="wirebox";

	// Local properties
	property name="IndexOptions" type="any";

	
	public function init(){
		return this;
	}




	public any function onDIComplete(){
		setIndexOptions(
			getJavaFactory().getJavaObject("com.mongodb.client.model.IndexOptions")
		);

		return this;
	}




	/**
	 * Returns underlying java object. Used in util conversion methods.
	 */
	public any function getBaseJavaObject() {
		return getIndexOptions();
	}




	/**
	 * Sets the collation options 
	 *
	 * @collation The collation options to use
	 */
	public any function collation(required Collation collation){
		getIndexOptions().collation(
			arguments.collation.build()
		);
		return this;
	}




	/**
	 * Returns the collation options
	 */
	public function getCollation(){
		return getWirebox.getInstance("Collation@box-mongodb-sdk").setMongoCollation(
			getIndexOptions().getCollation()
		)
	}




	/**
	 * Should the index should be created in the background
	 *
	 * @background True if should create the index in the background
	 */
	public function background(required boolean background) {
		getIndexOptions().background(
			javaCast("boolean", arguments.background)
		);
		return this;
	}




	/**
	 * Returns true if should create the index in the background
	 */
	public boolean function isBackground() {
		return getIndexOptions().isBackground();
	}




	/**
	 * Sets the number of precision of the stored geohash value of the location data in 2d indexes.
	 *
	 * @bits The number of precision of the stored geohash value
	 */
	public function bits(required numeric bits) {
		getIndexOptions().bits(
			javaCast("int", arguments.bits)
		);
		return this;
	}




	/**
	 * Gets the number of precision of the stored geohash value of the location data in 2d indexes.
	 */
	public numeric function getBits() {
		return getIndexOptions().getBits();
	}




	/**
	 * Sets the specified the number of units within which to group the location values for geoHaystack Indexes
	 *
	 * @bucketSize The specified the number of units within which to group the location values for geoHaystack Indexes
	 */
	public function bucketSize(required numeric bucketSize) {
		getIndexOptions().bucketSize(
			javaCast("double", arguments.bucketSize)
		);
		return this;
	}




	/**
	 * Gets the specified the number of units within which to group the location values for geoHaystack Indexes
	 */
	public numeric function getBucketSize() {
		return getIndexOptions().getBucketSize();
	}




	/**
	 * Sets the language for the text index. 
	 * The language that determines the list of stop words and the rules for the stemmer and tokenizer.
	 *
	 * @defaultLanguage The language for the text index.
	 */
	public function defaultLanguage(required string defaultLanguage) {
		getIndexOptions().defaultLanguage(
			javaCast("string", arguments.defaultLanguage)
		);
		return this;
	}




	/**
	 * Gets the language for a text index. 
	 */
	public string function getDefaultLanguage() {
		return getIndexOptions().getDefaultLanguage();
	}




	/**
	 * Sets the time to live for documents in the collection (TTL)
	 *
	 * @expireAfter Number, the time to live for documents in the collection
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public function expireAfter(required numeric expireAfter, required TimeUnit timeUnit) {
		getIndexOptions().expireAfter(
			javaCast("long", arguments.expireAfter),
			arguments.timeUnit.getTimeUnit()
		);
		return this;
	}




	/**
	 * Gets the time to live for documents in the collection
	 *
	 * @timeUnit Properly initialized TimeUnit object
	 */
	public numeric function getExpireAfter(required TimeUnit timeUnit) {
		return getIndexOptions().getExpireAfter(
			arguments.timeUnit.getTimeUnit()
		);
	}




	/**
	 * Should the index not be used by the query planner when executing operations.
	 *
	 * @hidden true if the index should be hidden
	 */
	public function hidden(required boolean hidden) {
		getIndexOptions().hidden(
			javaCast("boolean", arguments.hidden)
		);
		return this;
	}




	/**
	 * Gets whether the index should not be used by the query planner when executing operations.
	 */
	public boolean function isHidden() {
		return getIndexOptions().isHidden();
	}




	/**
	 * Sets the name of the field that contains the language string.
	 * For text indexes, the name of the field, in the collection's documents, that contains the override language for the document.
	 *
	 * @languageOverride The name of the field that contains the language string.
	 */
	public function languageOverride(required string languageOverride) {
		getIndexOptions().languageOverride(
			javaCast("string", arguments.languageOverride)
		);
		return this;
	}




	/**
	 * Gets the name of the field that contains the language string. 
	 */
	public string function getLanguageOverride() {
		return getIndexOptions().getLanguageOverride();
	}




	/**
	 * Sets the upper inclusive boundary for the longitude and latitude values for 2d indexes.
	 *
	 * @max The upper inclusive boundary for the longitude and latitude values
	 */
	public function max(required numeric max) {
		getIndexOptions().max(
			javaCast("double", arguments.max)
		);
		return this;
	}




	/**
	 * Gets the upper inclusive boundary for the longitude and latitude values for 2d indexes.
	 */
	public numeric function getMax() {
		return getIndexOptions().getMax();
	}




	/**
	 * Sets the lower inclusive boundary for the longitude and latitude values for 2d indexes.
	 *
	 * @min The lower inclusive boundary for the longitude and latitude values
	 */
	public function min(required numeric min) {
		getIndexOptions().min(
			javaCast("double", arguments.min)
		);
		return this;
	}




	/**
	 * Gets the lower inclusive boundary for the longitude and latitude values for 2d indexes.
	 */
	public numeric function getMin() {
		return getIndexOptions().getMin();
	}




	/**
	 * Sets the name of the index.
	 *
	 * @name of the index
	 */
	public function name(required string name) {
		getIndexOptions().name(
			javaCast("string", arguments.name)
		);
		return this;
	}




	/**
	 * Gets the name of the index.
	 */
	public string function getName() {
		return getIndexOptions().getName();
	}




	/**
	 * Sets the filter expression for the documents to be included in the index
	 *
	 * @partialFilterExpression The filter expression for the documents to be included in the index
	 */
	public function partialFilterExpression(required Document partialFilterExpression) {
		getIndexOptions().partialFilterExpression(
			arguments.partialFilterExpression.getMongoDocument()
		);
		return this;
	}




	/**
	 * Get the filter expression for the documents to be included in the index or null if not set
	 */
	public Document function getPartialFilterExpression() {
		return getBsonFactory().Document(
			getIndexOptions().getPartialFilterExpression()
		);
	}




	/**
	 * Should the index only references documents with the specified field
	 *
	 * @sparse If true, the index only references documents with the specified field
	 */
	public function sparse(required boolean sparse) {
		getIndexOptions().sparse(
			javaCast("boolean", arguments.sparse)
		);
		return this;
	}




	/**
	 * If true, the index only references documents with the specified field
	 */
	public boolean function isSparse() {
		return getIndexOptions().isSparse();
	}




	/**
	 * Sets the 2dsphere index version number.
	 *
	 * @sphereVersion The 2dsphere index version number.
	 */
	public function sphereVersion(required numeric sphereVersion) {
		getIndexOptions().sphereVersion(
			javaCast("int", arguments.sphereVersion)
		);
		return this;
	}




	/**
	 * Gets the 2dsphere index version number.
	 */
	public numeric function getSphereVersion() {
		return getIndexOptions().getSphereVersion();
	}




	/**
	 * Sets the storage engine options document for this index.
	 *
	 * @storageEngine The storage engine options
	 */
	public function storageEngine(required Document storageEngine) {
		getIndexOptions().storageEngine(
			arguments.storageEngine.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the storage engine options document for this index.
	 */
	public Document function getStorageEngine() {
		return getBsonFactory().Document(
			getIndexOptions().getStorageEngine()
		);
	}




	/**
	 * Set the text index version number.
	 *
	 * @textVersion The text index version number.
	 */
	public function textVersion(required numeric textVersion) {
		getIndexOptions().textVersion(
			javaCast("int", arguments.textVersion)
		);
		return this;
	}




	/**
	 * Returns the text index version number.
	 */
	public numeric function getTextVersion() {
		return getIndexOptions().getTextVersion();
	}




	/**
	 * Should the index should be unique.
	 *
	 * @unique If the index should be unique
	 */
	public function unique(required boolean unique) {
		getIndexOptions().unique(
			javaCast("boolean", arguments.unique)
		);
		return this;
	}




	/**
	 * Gets if the index should be unique.
	 */
	public boolean function isUnique() {
		return getIndexOptions().isUnique();
	}




	/**
	 * Sets the index version number.
	 *
	 * @version The index version number.
	 */
	public function version(required numeric version) {
		getIndexOptions().version(
			javaCast("int", arguments.version)
		);
		return this;
	}




	/**
	 * Gets the index version number.
	 */
	public numeric function getVersion() {
		return getIndexOptions().getVersion();
	}




	/**
	 * Sets the weighting object for use with a text index.
	 * A document that represents field and weight pairs. The weight is an integer ranging from 1 to 99,999 and denotes the significance of the field relative to the other indexed fields in terms of the score.
	 *
	 * @weights The weighting object
	 */
	public function weights(required Document weights) {
		getIndexOptions().weights(
			arguments.weights.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the weighting object for use with a text index 
	 */
	public Document function getWeights() {
		return getBsonFactory().Document(
			getIndexOptions().getWeights()
		);
	}




	/**
	 * Sets the wildcard projection of a wildcard index
	 *
	 * @wildcardProjection The wildcard projection
	 */
	public function wildcardProjection(required Document wildcardProjection) {
		getIndexOptions().wildcardProjection(
			arguments.wildcardProjection.getMongoDocument()
		);
		return this;
	}




	/**
	 * Gets the wildcard projection of a wildcard index
	 */
	public Document function getWildcardProjection() {
		return getBsonFactory().Document(
			getIndexOptions().getWildcardProjection()
		);
	}




	/**
	 * 
	 */
	public string function toString(){
		return getIndexOptions().toString();
	}





}
