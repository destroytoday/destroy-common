package com.destroytoday.support
{
	import com.destroytoday.display.MeasuredSprite;
	
	public class TestInvalidatesMeasuredSprite extends MeasuredSprite
	{
		public var hasInvalidated:Boolean;
		
		public function TestInvalidatesMeasuredSprite()
		{
		}
		
		override public function invalidate():void
		{
			hasInvalidated = true;
		}
	}
}