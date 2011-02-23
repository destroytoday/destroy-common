package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestProgressingLoader extends StringLoader
	{
		public function TestProgressingLoader()
		{
		}
		
		override protected function createProperties():void
		{
			super.createProperties();
			
			loader = new MockURLLoader();
		}
	}
}

import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

class MockURLLoader extends URLLoader
{
	override public function load(request:URLRequest):void
	{
		dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, 5000.0, 50000.0));
	}
	
	override public function close():void
	{
		
	}
}