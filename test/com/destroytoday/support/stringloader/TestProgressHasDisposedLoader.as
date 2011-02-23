package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestProgressHasDisposedLoader extends StringLoader
	{
		public function TestProgressHasDisposedLoader()
		{
		}
		
		public function get hasProgressDisposed():Boolean
		{
			return (progress as MockProgress).hasDisposed;
		}
		
		override protected function createProperties():void
		{
			super.createProperties();
			
			_progress = new MockProgress();
		}
	}
}

import com.destroytoday.data.Progress;

class MockProgress extends Progress
{
	public var hasDisposed:Boolean;
	
	override public function dispose():void
	{
		hasDisposed = true;
	}
}