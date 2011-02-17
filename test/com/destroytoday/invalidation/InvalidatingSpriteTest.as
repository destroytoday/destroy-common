package com.destroytoday.invalidation
{
	import com.destroytoday.support.TestDirtyDisplayListInvalidatingObject;
	import com.destroytoday.support.TestDirtyPropertyListInvalidatingObject;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Stage;
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;

	public class InvalidatingSpriteTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected static var window:NativeWindow;
		
		protected var sprite:InvalidatingSprite;
		
		protected var stage:Stage;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
			window = new NativeWindow(new NativeWindowInitOptions());
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
			window.close();
			
			window = null;
		}
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			stage = window.stage;
			
			Async.proceedOnEvent(this, prepare(InvalidatingSprite), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			removeAllChildren();
			
			stage = null;
			sprite = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Helpers
		//
		//--------------------------------------------------------------------------
		
		protected function removeAllChildren():void
		{
			const m:int = window.stage.numChildren;
			
			for (var i:int = 0; i < m; i++)
				window.stage.removeChildAt(0);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function sprite_invalidates_when_added_to_stage_if_property_list_is_dirty():void
		{
			var sprite:TestDirtyPropertyListInvalidatingObject = new TestDirtyPropertyListInvalidatingObject();
			
			stage.addChild(sprite);
			
			assertThat(sprite.hasInvalidated);
		}
		
		[Test]
		public function sprite_invalidates_when_added_to_stage_if_display_list_is_dirty():void
		{
			var sprite:TestDirtyDisplayListInvalidatingObject = new TestDirtyDisplayListInvalidatingObject();
			
			stage.addChild(sprite);
			
			assertThat(sprite.hasInvalidated);
		}
	}
}