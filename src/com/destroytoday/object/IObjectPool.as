package com.destroytoday.object
{
	public interface IObjectPool
	{
		function hasObject(object:Object):Boolean;
		function getObject():*;
		function disposeObject(object:Object):void;
		function empty():void;
	}
}