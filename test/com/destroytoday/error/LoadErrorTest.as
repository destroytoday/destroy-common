package com.destroytoday.error
{
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import com.destroytoday.net.LoadError;

	public class LoadErrorTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var error:LoadError;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[After]
		public function tearDown():void
		{
			error = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function error_populates_code_upon_instantiation():void
		{
			const code:int = 404;
			
			error = new LoadError(1000, code, "Not found");
			
			assertThat(error.code, equalTo(code));
		}
		
		[Test]
		public function error_returns_id_and_code_and_description():void
		{
			error = new LoadError(1000, 404, "Not found");
			
			assertThat(error.toString(), "1000 404 Not Found");
		}
	}
}