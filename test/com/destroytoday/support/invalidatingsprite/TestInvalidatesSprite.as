package com.destroytoday.support.invalidatingsprite
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestInvalidatesSprite extends InvalidatingSprite
	{
		public var hasInvalidated:Boolean;
		
		public function TestInvalidatesSprite()
		{
		}
		
		override public function invalidate():void
		{
			super.invalidate();
			
			hasInvalidated = true;
		}
	}
}