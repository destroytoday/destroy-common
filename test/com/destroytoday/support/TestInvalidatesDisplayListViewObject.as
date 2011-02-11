package com.destroytoday.support
{
	import com.destroytoday.view.ViewObject;
	
	public class TestInvalidatesDisplayListViewObject extends ViewObject
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