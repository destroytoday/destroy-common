package com.destroytoday.support
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	import flash.events.Event;
	
	public class TestUpdatingPropertyListSprite extends InvalidatingSprite
	{
		public var hasUpdatedPropertyListOnRender:Boolean;

		public var hasUpdatedPropertyListOnEnterframe:Boolean;
		
		protected var frame:int = -1;
		
		public function TestUpdatingPropertyListSprite()
		{
		}
		
		override protected function updatePropertyList():void
		{
			if (frame == 0)
			{
				hasUpdatedPropertyListOnRender = true;
				
				invalidatePropertyList();
			}
			else if (frame == 1)
			{
				hasUpdatedPropertyListOnEnterframe = true;
			}
			else
			{
				stage.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			}
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, enterframeHandler);
		}
		
		protected function enterframeHandler(event:Event):void
		{
			frame++;
		}
	}
}