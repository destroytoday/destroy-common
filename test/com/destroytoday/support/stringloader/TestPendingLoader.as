package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestPendingLoader extends StringLoader
	{
		public function TestPendingLoader()
		{
		}
		
		override protected function createProperties():void
		{
			super.createProperties();
			
			loader = new MockURLLoader();
		}
	}
}

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

class MockURLLoader extends URLLoader
{
	override public function load(request:URLRequest):void
	{
	}
}