package com.destroytoday.support
{
	import com.destroytoday.object.ObjectPool;
	
	import flash.utils.Timer;
	
	public class TestTimerPool extends ObjectPool
	{
		public function TestTimerPool(size:int = 0)
		{
			super(Timer);
		}
		
		override protected function createObject():*
		{
			return new Timer(1000.0);
		}
	}
}