package com.destroytoday.support
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestDirtyPropertyListInvalidatingObject extends InvalidatingSprite
	{
		public var hasInvalidated:Boolean;
		
		public function TestDirtyPropertyListInvalidatingObject()
		{
			isPropertyListDirty = true;
		}
		
		override public function invalidate():void
		{
			hasInvalidated = true;
		}
	}
}