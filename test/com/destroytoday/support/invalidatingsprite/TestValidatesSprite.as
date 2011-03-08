package com.destroytoday.support.invalidatingsprite
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestValidatesSprite extends InvalidatingSprite
	{
		public var hasValidated:Boolean;
		
		public function TestValidatesSprite()
		{
		}
		
		override public function validate():void
		{
			super.validate();
			
			hasValidated = true;
		}
	}
}