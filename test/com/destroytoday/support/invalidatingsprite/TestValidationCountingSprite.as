package com.destroytoday.support.invalidatingsprite
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class TestValidationCountingSprite extends InvalidatingSprite
	{
		public var numValidated:int;
		
		public function TestValidationCountingSprite()
		{
		}
		
		override public function validate():void
		{
			super.validate();
			
			numValidated++;
		}
	}
}