package com.destroytoday.support
{
	import org.osflash.signals.Signal;
	
	public class TestRemovedAllListenersSignal extends Signal
	{
		public var hasRemovedAllListeners:Boolean;
		
		public function TestRemovedAllListenersSignal(...parameters)
		{
			super(parameters);
		}
		
		override public function removeAll():void
		{
			hasRemovedAllListeners = true;
		}
	}
}