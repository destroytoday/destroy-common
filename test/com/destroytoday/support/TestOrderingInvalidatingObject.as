package com.destroytoday.support
{
	import com.destroytoday.invalidation.IInvalidatable;
	import com.destroytoday.invalidation.IInvalidationManager;
	
	public class TestOrderingInvalidatingObject implements IInvalidatable
	{
		protected var orderList:Array;
		
		public function TestOrderingInvalidatingObject(orderList:Array)
		{
			this.orderList = orderList;
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
			orderList.push(this);
		}
	}
}