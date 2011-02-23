package com.destroytoday.data
{
	public interface IProgress
	{
		function get numLoaded():int;
		function set numLoaded(value:int):void;
		
		function get numTotal():int;
		function set numTotal(value:int):void;
		
		function get percentLoaded():Number;
	}
}