package com.destroytoday.support
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestDirtyDisplayListInvalidatingObject extends InvalidatingSprite
	{
		public var hasInvalidated:Boolean;
		
		public function TestDirtyDisplayListInvalidatingObject()
		{
			isDisplayListDirty = true;
		}
		
		override public function invalidate():void
		{
			hasInvalidated = true;
		}
	}
}