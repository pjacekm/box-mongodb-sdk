/**
* 
* @author pjacekm@gmail.com
* @description CFML representation of com.mongodb.ServerAddress. Represents the location of a Mongo server - i.e. server name and port number.
*
*/

component output="false" accessors="true" {

	// Injected properties (DI)
	property name="JavaFactory" inject="JavaFactory@box-mongodb-sdk";
	property name="Util" inject="Util@box-mongodb-sdk";

	// Local properties
	property name="ServerAddress" type="any";

	public function init(){
		return this;
	}




	ServerAddress function initDefault(){
		setServerAddress(
			getJavaFactory().getJavaObject("com.mongodb.ServerAddress").init()
		);
		return this;
	}




	ServerAddress function initWithServerAddress(required serverAddress){
		setServerAddress(
			arguments.serverAddress
		);
		return this;
	}




	ServerAddress function initWithHost(required string host){
		setServerAddress(
			getJavaFactory().getJavaObject("com.mongodb.ServerAddress").init(
				javaCast("string", arguments.host)
			)
		);
		return this;
	}




	ServerAddress function initWithHostAndPort(required string host, required numeric port){
		setServerAddress(
			getJavaFactory().getJavaObject("com.mongodb.ServerAddress").init(
				javaCast("string", arguments.host),
				javaCast("int", arguments.host)
			)
		);
		return this;
	}




	public string function getHost() {
		return getServerAddress().getHost()
	}




	public string function defaultHost() {
		return getServerAddress().defaultHost()
	}




	public numeric function getPort() {
		return getServerAddress().getPort()
	}




	public numeric function defaultPort() {
		return getServerAddress().defaultPort()
	}




	public any function getSocketAddresses() {
		return getServerAddress().getSocketAddresses()
	}




	public any function getSocketAddress() {
		return getServerAddress().getSocketAddress()
	}
}
