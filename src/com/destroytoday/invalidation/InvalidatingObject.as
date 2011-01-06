package com.destroytoday.invalidation
{
	public class InvalidatingObject implements IInvalidatable
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _invalidationManager:IInvalidationManager;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function InvalidatingObject(invalidationManager:IInvalidationManager)
		{
			_invalidationManager = invalidationManager;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get invalidationManager():IInvalidationManager
		{
			return _invalidationManager;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function invalidate():void
		{
			_invalidationManager.invalidateObject(this);
		}
		
		public function validate():void
		{
			
		}
	}
}