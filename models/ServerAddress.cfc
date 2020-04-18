/**
* 
* @author pjacekm@gmail.com
* @description CFML representation of MongoDB ServerAddress
*
*/

component output="false" accessors="true" {

	// Local properties
	property name="ServerAddress" type="any" default="";

	public function init(){
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
