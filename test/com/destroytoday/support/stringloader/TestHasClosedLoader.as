package com.destroytoday.support.stringloader
{
	import com.destroytoday.net.StringLoader;
	
	public class TestHasClosedLoader extends StringLoader
	{
		public function TestHasClosedLoader()
		{
		}
		
		public function get hasClosed():Boolean
		{
			return (loader as MockURLLoader).hasClosed;
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
	public var hasClosed:Boolean;
	
	override public function load(request:URLRequest):void
	{
	}
	
	override public function close():void
	{
		hasClosed = true;
	}
}