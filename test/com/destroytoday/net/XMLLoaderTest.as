package com.destroytoday.net
{
	import com.destroytoday.support.xmlloader.TestCompletingXMLLoader;
	import com.destroytoday.support.xmlloader.TestMalformedXMLXMLLoader;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.Signal;

	public class XMLLoaderTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var loader:XMLLoader;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
		}

		[After]
		public function tearDown():void
		{
			loader = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function loader_implements_interface():void
		{
			loader = new XMLLoader();
			
			assertThat(loader is ILoader);
		}
		
		//--------------------------------------
		// result 
		//--------------------------------------
		
		[Test]
		public function result_data_is_in_xml_format():void
		{
			loader = new TestCompletingXMLLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.result.data is XML);
		}
		
		[Test]
		public function result_data_as_string_matches_returned_string():void
		{
			loader = new TestCompletingXMLLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.result.data.toString(), equalTo(new XML("<tree><branch></branch></tree>").toString()));
		}
		
		//--------------------------------------
		// malformed XML 
		//--------------------------------------
		
		[Test]
		public function malformed_xml_dispatches_failed():void
		{
			loader = new TestMalformedXMLXMLLoader();

			loader.failed = nice(Signal);
			loader.load(new URLRequest("http://example.com"));

			assertThat(loader.failed, received().method('dispatch').once());
		}
		
		[Test]
		public function malformed_xml_does_not_dispatch_completed():void
		{
			loader = new TestMalformedXMLXMLLoader();

			loader.completed = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.completed, received().method('dispatch').never());
		}
	}
}