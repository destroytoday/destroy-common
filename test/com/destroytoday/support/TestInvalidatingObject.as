package com.destroytoday.support
{
	import com.destroytoday.invalidation.IInvalidatable;
	import com.destroytoday.invalidation.IInvalidationManager;
	
	public class TestInvalidatingObject implements IInvalidatable
	{
		public function TestInvalidatingObject()
		{
		}
		
		public function get invalidationManager():IInvalidationManager
		{
			return null;
		}
		
		public function invalidate():void
		{
		}
		
		public function validate():void
		{
		}
	}
}