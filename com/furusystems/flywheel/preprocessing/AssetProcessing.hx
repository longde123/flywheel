package com.furusystems.flywheel.preprocessing;
import haxe.io.Bytes;
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr;
import sys.FileSystem;

/**
 * ...
 * @author Andreas Rønning
 */
class AssetProcessing
{
	macro public static function buildMusicPaths(basePath:String):Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();
		var pos:Position = Context.currentPos();
		if (FileSystem.exists(basePath)) {
			var tstring = TPath({ pack : [], name : "String", params : [], sub : null });
			var paths:Array<String> = FileSystem.readDirectory(basePath);
			var trimmed:String = basePath.substring(basePath.indexOf("/")+1, basePath.length);
			for (p in paths) {
				if (!Util.isMusic(p)) continue;
				var name:String = Util.cleanName(p.substring(0, p.lastIndexOf(".")));
				var path:String = trimmed + "/" + p;
				var e = macro $v{path};
				fields.push( { name : "MUSIC_"+name.toUpperCase(), doc : null, meta : [], access : [APublic, AStatic, AInline], kind : FVar(tstring, e), pos : pos } );
			}	
		}else {
			trace("No music files in base path: " + basePath);
		}
		return fields;
	}
	//TODO: Recursive search for fx without the need of a deeper base path
	macro public static function buildSoundPaths(basePath:String):Array<Field> {
		var fields:Array<Field> = Context.getBuildFields();
		var pos:Position = Context.currentPos();
		if (FileSystem.exists(basePath)) {
			var tstring = TPath({ pack : [], name : "String", params : [], sub : null });
			var paths:Array<String> = FileSystem.readDirectory(basePath);
			var trimmed:String = basePath.substring(basePath.indexOf("/")+1, basePath.length);
			for (p in paths) {
				if (!Util.isWav(p)) continue;
				var name:String = Util.cleanName(p.substring(0, p.lastIndexOf(".")));
				var path:String = trimmed + "/" + p;
				var e = macro $v{path};
				fields.push( { name : "FX_"+name.toUpperCase(), doc : null, meta : [], access : [APublic, AStatic, AInline], kind : FVar(tstring, e), pos : pos } );
			}	
		}else {
			trace("No fx files in base path: " + basePath);
		}
		return fields;
	}
	
	macro public static function buildSoundDurations(basePath:String):Array<Field> {
		var fields = Context.getBuildFields();
		var pos = Context.currentPos();
		if (FileSystem.exists(basePath)) {
			var tfloat = TPath({ pack : [], name : "Float", params : [], sub : null });
			var paths = FileSystem.readDirectory(basePath);
			var trimmed:String = basePath.substring(basePath.indexOf("/"), basePath.length);
			for (p in paths) {
				if (!Util.isWav(p)) continue;
				var path:String = basePath +"/"+ p;
				var duration = Util.readWavDuration(path);
				var name:String = Util.cleanName(p.substring(0, p.lastIndexOf(".")));
				//name = name.substring(1);
				var e = macro $v{duration};
				fields.push( { name : name.toUpperCase(), doc : null, meta : [], access : [APublic, AStatic], kind : FVar(tfloat, e), pos : pos } );
			}
		}else {
			trace("No fx files in base path: " + basePath);
		}
		return fields;
	}
	
}