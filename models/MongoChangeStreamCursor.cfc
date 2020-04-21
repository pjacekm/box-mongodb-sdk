/**
* The Mongo Cursor interface for change streams implementing the iterator protocol. 
*/

component output="false" extends="MongoCursor" accessors="true" {
	
	/**
	 * Returns the resume token.
	 */
	public any function getResumeToken() {
		return getUtil().toCF(
			getMongoCursor().getResumeToken()
		)
	}
}
