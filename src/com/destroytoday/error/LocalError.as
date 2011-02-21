package com.destroytoday.error
{
	public class LocalError
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _id:int;
		
		protected var _description:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function LocalError(id:int, description:String)
		{
			_id = id;
			_description = description;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get id():int
		{
			return _id;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String
		{
			return _id + " " + _description;
		}
	}
}