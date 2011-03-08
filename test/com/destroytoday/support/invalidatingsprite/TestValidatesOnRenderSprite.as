package com.destroytoday.support.invalidatingsprite
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	import flash.events.Event;
	
	public class TestValidatesOnRenderSprite extends InvalidatingSprite
	{
		public var hasValidatedOnRender:Boolean;
		
		public function TestValidatesOnRenderSprite()
		{
		}
		
		override protected function invalidateHandler(event:Event):void
		{
			super.invalidateHandler(event);
			
			if (event.type == Event.RENDER)
				hasValidatedOnRender = true;
		}
	}
}