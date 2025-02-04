import funkin.backend.system.macros.DefinesMacro;
import funkin.backend.scripting.HScript;

/*
 * HScript plugin that allows you to add custom preprocessors to your modpack, like:
 * #if TEST
 * 
 * #end
 */
public static var PreprocessorUtil:T = {
	/*
	 * A list of all of your modpack's custom preprocessors.
	 */
	customProcessors: [],

	/*
	 * Internal function to tell whether you ran `setCustomPreprocessors` before.
	 */
	processorsSetup: false,

	/**
	* Sets the custom preprocessors of a modpack from a json file.
	*
	* @param   jsonPath        The json file path, usually in `data` with the name `preprocessors.json`.
	*/
	setCustomPreprocessors: function(jsonPath:String) {
		if(!Assets.exists(jsonPath)) {
			trace('setCustomPreprocessors: Preprocessor json "' + jsonPath + '" does not exist!');
			return false;
		}
		PreprocessorUtil.customProcessors = __structToMap(Json.parse(Assets.getText(jsonPath)));
		PreprocessorUtil.processorsSetup = true;

		trace("setCustomPreprocessors: Processors found! Processor list: " + PreprocessorUtil.customProcessors);
		return true;
	},

	/**
	* Casts the custom processors to a script so that script is able to use them properly.
	*
	* @param   haxeScript        The haxe script to cast to.
	*/
    castProcessorsToScript: function(haxeScript:HScript):Bool {
		if(haxeScript == null) {
			trace('castProcessorsToScript: Haxe script does not exist! There is no script to cast to...');
			return false;
		}

		for(key => value in PreprocessorUtil.customProcessors)
			if(value != false) haxeScript.parser.preprocesorValues.set(key, value);

		return true;
	}
}

//Thanks to my friend Ghostglowdev for this function, I totally forgot Reflect.fields existed
function __structToMap(struct:Dynamic) {
	var map:Map<String, Dynamic> = [];
	for (key in Reflect.fields(struct)) map.set(key, Reflect.field(struct, key));
	return map;
}