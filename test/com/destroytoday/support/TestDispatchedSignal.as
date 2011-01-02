package com.destroytoday.support
{
	import org.osflash.signals.Signal;
	
	public class TestDispatchedSignal extends Signal
	{
		public var hasDispatched:Boolean;
		
		public function TestDispatchedSignal(...parameters)
		{
			super(parameters);
		}
		
		override public function dispatch(...parameters):void
		{
			hasDispatched = true;
		}
	}
}