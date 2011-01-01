package com.destroytoday.support
{
	import com.destroytoday.object.IDisposable;
	
	public class TestDisposableObject implements IDisposable
	{
		public var wasDisposed:Boolean;
		
		public function TestDisposableObject()
		{
		}
		
		public function dispose():void
		{
			wasDisposed = true;
		}
	}
}