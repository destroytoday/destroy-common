package com.destroytoday.net
{
	public class LoadResult
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _code:int;
		
		protected var _data:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function LoadResult(code:int, data:*)
		{
			_code = code;
			_data = data;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get code():int
		{
			return _code;
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}