package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestHasClearedOnLoadLoader extends StringLoader
	{
		public var hasCleared:Boolean;
		
		public function TestHasClearedOnLoadLoader()
		{
		}
		
		override protected function createProperties():void
		{
			super.createProperties();
			
			loader = new MockURLLoader();
		}
		
		override public function clear():void
		{
			hasCleared = true;
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
	}
}