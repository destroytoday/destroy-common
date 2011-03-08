package com.destroytoday.support.invalidatingsprite
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	import flash.events.Event;
	
	public class TestValidatesOnEnterframeSprite extends InvalidatingSprite
	{
		public var hasValidatedOnEnterframe:Boolean;
		
		public function TestValidatesOnEnterframeSprite()
		{
		}
		
		override protected function invalidateHandler(event:Event):void
		{
			super.invalidateHandler(event);
			
			if (event.type == Event.ENTER_FRAME)
				hasValidatedOnEnterframe = true;
		}
	}
}