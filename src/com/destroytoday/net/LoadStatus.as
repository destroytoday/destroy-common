package com.destroytoday.net
{
	public class LoadStatus implements ILoadStatus
	{
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		
		public static const IDLE:LoadStatus = new LoadStatus("idle");

		public static const PENDING:LoadStatus = new LoadStatus("pending");
		
		public static const COMPLETED:LoadStatus = new LoadStatus("completed");

		public static const FAILED:LoadStatus = new LoadStatus("failed");

		public static const CANCELLED:LoadStatus = new LoadStatus("cancelled");
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _name:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function LoadStatus(name:String)
		{
			_name = name;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String
		{
			return _name;
		}
	}
}