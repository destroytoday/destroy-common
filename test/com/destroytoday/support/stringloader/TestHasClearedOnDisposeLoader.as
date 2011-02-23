package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestHasClearedOnDisposeLoader extends StringLoader
	{
		public var hasCleared:Boolean;
		
		public function TestHasClearedOnDisposeLoader()
		{
		}
		
		override public function clear():void
		{
			hasCleared = true;
		}
	}
}
