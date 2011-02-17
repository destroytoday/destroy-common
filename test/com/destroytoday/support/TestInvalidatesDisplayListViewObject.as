package com.destroytoday.support
{
	import com.destroytoday.display.MeasuredSprite;
	
	public class TestInvalidatesDisplayListViewObject extends MeasuredSprite
	{
		public var hasInvalidatedDisplayList:Boolean;
		
		public function TestInvalidatesDisplayListViewObject()
		{
		}
		
		override public function invalidateDisplayList():void
		{
			hasInvalidatedDisplayList = true;
		}
	}
}