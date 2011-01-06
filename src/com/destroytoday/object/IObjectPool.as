package com.destroytoday.object
{
	public interface IObjectPool
	{
		function getObject():*;
		function disposeObject(object:Object):void;
	}
}