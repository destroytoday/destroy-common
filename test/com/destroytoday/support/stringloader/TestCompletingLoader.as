package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestCompletingLoader extends StringLoader
	{
		public function TestCompletingLoader()
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
import flash.events.HTTPStatusEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

class MockURLLoader extends URLLoader
{
	override public function load(request:URLRequest):void
	{
		data = "data";

		dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_RESPONSE_STATUS, false, false, 200));
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	override public function close():void
	{
		
	}
}