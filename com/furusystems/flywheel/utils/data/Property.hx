package com.furusystems.flywheel.utils.data;

/**
 * ...
 * @author Andreas Rønning
 */

@:generic @:remove class Property<T> 
{
	public var dirty:Bool;
	private var _value:T;
	public function new(defaultValue:T) 
	{
		dirty = false;
		_value = defaultValue;
	}
	
	private function get_value():T 
	{
		return _value;
	}
	
	private function set_value(value:T):T 
	{
		_value = value;
		dirty = true;
		return _value;
	}
	
	public var value(get_value, set_value):T;
	
}