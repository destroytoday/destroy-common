package com.destroytoday.async
{
	public class PromiseStatus implements IPromiseStatus
	{
		//--------------------------------------------------------------------------
		//
		//  Static Properties
		//
		//--------------------------------------------------------------------------
		
		public static const PENDING:PromiseStatus = new PromiseStatus("pending");

		public static const COMPLETE:PromiseStatus = new PromiseStatus("complete");
		
		public static const FAILED:PromiseStatus = new PromiseStatus("failed");
		
		public static const CANCELLED:PromiseStatus = new PromiseStatus("cancelled");
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _status:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function PromiseStatus(status:String)
		{
			_status = status;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function toString():String
		{
			return _status;
		}
	}
}