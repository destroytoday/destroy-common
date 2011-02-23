package com.destroytoday.net
{
	import com.destroytoday.error.LocalError;

	public class LoadError extends LocalError
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _code:int;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function LoadError(id:int, code:int, description:String)
		{
			_code = code;
			
			super(id, description);
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
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		override public function toString():String
		{
			return _id + " " + _code + " " + _description;
		}
	}
}