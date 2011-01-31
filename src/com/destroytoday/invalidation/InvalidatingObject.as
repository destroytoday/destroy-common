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
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get invalidationManager():IInvalidationManager
		{
			return _invalidationManager;
		}
		
		public function set invalidationManager(value:IInvalidationManager):void
		{
			_invalidationManager = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function invalidate():void
		{
			invalidationManager.invalidateObject(this);
		}
		
		public function validate():void
		{
			
		}
	}
}