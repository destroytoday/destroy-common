package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestIOFailingLoader extends StringLoader
	{
		public function TestIOFailingLoader()
		{
		}
		
		override protected function createProperties():void
		{
			super.createProperties();
			
			loader = new MockURLLoader();
		}
	}
}

import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

class MockURLLoader extends URLLoader
{
	override public function load(request:URLRequest):void
	{
		dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_RESPONSE_STATUS, false, false, 503));
		dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, "Something bad happened", 1000));
	}
	
	override public function close():void
	{
		
	}
}