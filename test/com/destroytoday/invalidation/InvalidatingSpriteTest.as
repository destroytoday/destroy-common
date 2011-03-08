package com.destroytoday.invalidation
{
	import com.destroytoday.support.invalidatingsprite.TestInvalidatesSprite;
	import com.destroytoday.support.invalidatingsprite.TestValidatesOnEnterframeSprite;
	import com.destroytoday.support.invalidatingsprite.TestValidatesOnRenderSprite;
	import com.destroytoday.support.invalidatingsprite.TestValidatesSprite;
	import com.destroytoday.support.invalidatingsprite.TestValidationCountingSprite;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Stage;
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

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
		public function should_implement_invalidatable():void
		{
			sprite = new InvalidatingSprite();
			
			assertThat(sprite is IInvalidatable);
		}
		
		[Test]
		public function should_invalidate_when_added_to_stage():void
		{
			var sprite:TestInvalidatesSprite = stage.addChild(new TestInvalidatesSprite()) as TestInvalidatesSprite;
			
			assertThat(sprite.hasInvalidated);
		}
		
		[Test(async)]
		public function should_validate_when_invalidated():void
		{
			var sprite:TestValidatesSprite = stage.addChild(new TestValidatesSprite()) as TestValidatesSprite;
			
			Async.delayCall(this, function():void
			{
				assertThat(sprite.hasValidated);
			}, 500.0);
		}
		
		[Test(async)]
		public function should_validate_on_render_when_invalidated_on_enterframe():void
		{
			var sprite:TestValidatesOnRenderSprite = stage.addChild(new TestValidatesOnRenderSprite()) as TestValidatesOnRenderSprite;
			
			var enterframeHandler:Function = function(event:Event):void
			{
				stage.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
					
				sprite.invalidate();
			};
			
			stage.addEventListener(Event.ENTER_FRAME, enterframeHandler);
			
			Async.delayCall(this, function():void
			{
				assertThat(sprite.hasValidatedOnRender);
			}, 500.0);
		}
		
		[Test(async)]
		public function should_validate_on_enterframe_when_invalidated_on_render():void
		{
			var sprite:TestValidatesOnEnterframeSprite = stage.addChild(new TestValidatesOnEnterframeSprite()) as TestValidatesOnEnterframeSprite;
			
			var renderHandler:Function = function(event:Event):void
			{
				stage.removeEventListener(Event.RENDER, renderHandler);
				
				sprite.invalidate();
			};
			
			stage.addEventListener(Event.RENDER, renderHandler);
			
			stage.invalidate();
			
			Async.delayCall(this, function():void
			{
				assertThat(sprite.hasValidatedOnEnterframe);
			}, 500.0);
		}
		
		[Test(async)]
		public function should_not_validate_again_when_validated_manually():void
		{
			var sprite:TestValidationCountingSprite = stage.addChild(new TestValidationCountingSprite()) as TestValidationCountingSprite;
			
			sprite.invalidate();
			sprite.validate();
			
			Async.delayCall(this, function():void
			{
				assertThat(sprite.numValidated, equalTo(1));
			}, 500.0);
		}
	}
}