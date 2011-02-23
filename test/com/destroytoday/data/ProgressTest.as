package com.destroytoday.data
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class ProgressTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var progress:Progress;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			progress = new Progress();
		}
		
		[After]
		public function tearDown():void
		{
			progress = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function progress_implements_interface():void
		{
			assertThat(progress is IProgress);
		}
		
		[Test]
		public function loaded_is_initially_zero():void
		{
			assertThat(progress.numLoaded, equalTo(0));
		}
		
		[Test]
		public function total_is_initially_zero():void
		{
			assertThat(progress.numTotal, equalTo(0));
		}
		
		[Test]
		public function percent_is_initially_zero():void
		{
			assertThat(progress.percentLoaded, equalTo(0.0));
		}
		
		[Test]
		public function dispose_resets_properties():void
		{
			progress.numLoaded = 1;
			progress.numTotal = 5;
			
			progress.dispose();
			
			assertThat(progress.numLoaded, equalTo(0));
			assertThat(progress.numTotal, equalTo(0));
			assertThat(progress.percentLoaded, equalTo(0.0));
		}
		
		[Test]
		public function percent_returns_loaded_divided_by_total():void
		{
			progress.numLoaded = 1;
			progress.numTotal = 5;
			
			assertThat(progress.percentLoaded, 0.2);
		}
		
		[Test]
		public function progress_returns_loaded_and_total_and_percent():void
		{
			progress.numLoaded = 1;
			progress.numTotal = 5;
			
			assertThat(progress.toString(), equalTo("1 5 0.2"));
		}
	}
}