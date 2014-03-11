package com.furusystems.flywheel.sound.ofl;
import com.furusystems.flywheel.sound.ISoundCue;
import flash.events.Event;
import flash.net.URLRequest;
#if openfl
import openfl.Assets;
#end
import flash.media.Sound;

/**
 * ...
 * @author Andreas Rønning
 */

class Cue implements ISoundCue
{

	public var path:String;
	public var sound:Sound;
	public var index:Int;
	public var duration:Float;
	#if !openfl
	public var loaded:Bool = false;
	#end
	public function new(path:String) 
	{
		this.path = path;
		#if openfl
		sound = Assets.getSound(path);
		#else
		sound = new Sound(new URLRequest(path));
		sound.addEventListener(Event.COMPLETE, onSoundLoaded);
		#end
	}
	
	#if !openfl
	private function onSoundLoaded(e:Event):Void 
	{
		sound.removeEventListener(Event.COMPLETE, onSoundLoaded);
		duration = sound.length;
		loaded = true;
	}
	#end
	
	public function release():Void 
	{
		
		#if !openfl
		sound.removeEventListener(Event.COMPLETE, onSoundLoaded);
		#end
		sound = null;
	}
	
}