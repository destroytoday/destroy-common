package com.destroytoday.support
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	import flash.events.Event;
	
	public class TestUpdatingDisplayListSprite extends InvalidatingSprite
	{
		public var hasUpdatedDisplayListOnRender:Boolean;

		public var hasUpdatedDisplayListOnEnterframe:Boolean;
		
		protected var frame:int = -1;
		
		public function TestUpdatingDisplayListSprite()
		{
		}
		
		override protected function updateDisplayList():void
		{
			if (frame == 0)
			{
				hasUpdatedDisplayListOnRender = true;
				
				invalidateDisplayList()
			}
			else if (frame == 1)
			{
				hasUpdatedDisplayListOnEnterframe = true;
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