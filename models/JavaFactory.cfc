/**
*
* @author pjacekm@gmail.com
* @description Uses JavaLoader to initialize MongoDB Java Driver classes. Given that all java classes must be delivered by the same JavaLoader instance (ClassLoader), this component should be instantiated as a singleton (see https://github.com/markmandel/JavaLoader/wiki/Switching-the-ThreadContextClassLoader)
*
*/

component output="false" accessors="true" singleton {

	// Injected properties (DI)
	property name="Wirebox" inject="wirebox";
	property name="ModuleSettings" inject="box:moduleSettings:box-mongodb-sdk";
	
	// Local properties
	property name="JavaLoader" default="";

	public function init(){
		return this;
	}




	public function onDIComplete() {
		initializeJavaLoader();

		return this;
	}




	public function initializeJavaLoader() {
		var javaLoader=getWirebox().getInstance("JavaLoader@box-mongodb-sdk");
		var libPaths=getModuleSettings()["libPaths"];
		var jars=[];
		var didx="";
		
		for(var pidx in libPaths){
			var dirList=directoryList( expandPath(pidx), false, "path", "*.jar" );
			if(arrayLen(dirList)){
				cfloop(array="#dirList#", item="didx"){
					arrayAppend(jars, didx);
				}
			}
		}

		javaLoader.init(
			loadPaths=jars
		);

		setJavaLoader(javaLoader);
	}




	public function getJavaObject(required string className) {
		return getJavaLoader().create(arguments.className);
	}




	
}
