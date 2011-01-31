package com.destroytoday.data
{
	import org.osflash.signals.Signal;

	public interface IDataList
	{
		function get changed():Signal;
		
		function get numItems():int;
		
		function getItemAt(index:int):*;
		function getItemIndex(item:Object):int;
		
		function hasItem(item:Object):Boolean;
		
		function addItem(item:Object):*;
		function addItemAt(item:Object, index:int):*;
		
		function removeItem(item:Object):*;
		function removeItemAt(index:int):*;
		function removeAllItems():void;
	}
}