package com.destroytoday.view
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	import com.destroytoday.support.TestInvalidatesDisplayListViewObject;
	
	import flash.display.Graphics;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;

	public class ViewObjectTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var view:ViewObject;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			view = new ViewObject();
		}
		
		[After]
		public function tearDown():void
		{
			view = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function view_is_invalidation_sprite():void
		{
			assertThat(view, isA(InvalidatingSprite));
		}
		
		//--------------------------------------
		// width 
		//--------------------------------------
		
		[Test]
		public function width_returns_measured_width_by_default():void
		{
			var graphics:Graphics = view.graphics;
			const lineWidth:Number = 100.0;
			
			graphics.lineStyle(0.0, 0xFF0099);
			graphics.lineTo(lineWidth, 0.0);
			
			assertThat(view.width, equalTo(lineWidth));
		}
		
		[Test]
		public function width_returns_explicit_width_when_width_is_set():void
		{
			const explicitWidth:Number = 100.0;
			view.width = explicitWidth;
			
			assertThat(view.width, equalTo(explicitWidth));
		}
		
		[Test]
		public function setting_width_invalidates_display_list():void
		{
			var view:TestInvalidatesDisplayListViewObject = new TestInvalidatesDisplayListViewObject();
			
			view.width = 100.0;
			
			assertThat(view.hasInvalidatedDisplayList);
		}
		
		//--------------------------------------
		// height 
		//--------------------------------------
		
		[Test]
		public function height_returns_measured_height_by_default():void
		{
			var graphics:Graphics = view.graphics;
			const lineHeight:Number = 100.0;
			
			graphics.lineStyle(0.0, 0xFF0099);
			graphics.lineTo(0.0, lineHeight);
			
			assertThat(view.height, equalTo(lineHeight));
		}
		
		[Test]
		public function height_returns_explicit_height_when_height_is_set():void
		{
			const explicitHeight:Number = 100.0;
			view.height = explicitHeight;
			
			assertThat(view.height, equalTo(explicitHeight));
		}
		
		[Test]
		public function setting_height_invalidates_display_list():void
		{
			var view:TestInvalidatesDisplayListViewObject = new TestInvalidatesDisplayListViewObject();
			
			view.height = 100.0;
			
			assertThat(view.hasInvalidatedDisplayList);
		}
		
		//--------------------------------------
		// measuredWidth
		//--------------------------------------
		
		[Test]
		public function measured_width_is_zero_by_default():void
		{
			assertThat(view.measuredWidth, equalTo(0.0));
		}
		
		[Test]
		public function measured_width_returns_width_of_contents():void
		{
			var graphics:Graphics = view.graphics;
			const lineWidth:Number = 100.0;
			
			graphics.lineStyle(0.0, 0xFF0099);
			graphics.lineTo(lineWidth, 0.0);
			
			assertThat(view.measuredWidth, equalTo(lineWidth));
		}
		
		[Test]
		public function measured_width_returns_width_of_contents_when_explicit_width_is_set():void
		{
			view.width = 200.0;
			
			assertThat(view.measuredWidth, equalTo(0.0));
		}
		
		//--------------------------------------
		// measuredHeight
		//--------------------------------------
		
		[Test]
		public function measured_height_is_zero_by_default():void
		{
			assertThat(view.measuredHeight, equalTo(0.0));
		}
		
		[Test]
		public function measured_height_returns_height_of_contents():void
		{
			var graphics:Graphics = view.graphics;
			const lineHeight:Number = 100.0;
			
			graphics.lineStyle(0.0, 0xFF0099);
			graphics.lineTo(0.0, lineHeight);
			
			assertThat(view.measuredHeight, equalTo(lineHeight));
		}
		
		[Test]
		public function measured_height_returns_height_of_contents_when_explicit_height_is_set():void
		{
			view.height = 200.0;
			
			assertThat(view.measuredHeight, equalTo(0.0));
		}
	}
}