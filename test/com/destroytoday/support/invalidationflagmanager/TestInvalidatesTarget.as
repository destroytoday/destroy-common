package com.destroytoday.support.invalidationflagmanager
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestInvalidatesTarget extends InvalidatingSprite
	{
		public var hasInvalidated:Boolean;
		
		public function TestInvalidatesTarget()
		{
		}
		
		override public function invalidate():void
		{
			super.invalidate();
			
			hasInvalidated = true;
		}
	}
}