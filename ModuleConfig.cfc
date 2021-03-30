/**
*
* @author pjacekm@gmail.com
* @description CommandBox/Coldbox module config
*
*/

component output="false" {

	// Module properties
	this.autoMapModels = true;
	//this.modelNamespace = "bms";

	function configure(){
		"settings"={
			"libPaths": [
				"#modulemapping#/lib/"
			],
			"mongoDriverVersion": "3.12.8"
		};

	}




	function onLoad(){
		
	}
}
