package com.destroytoday.error
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class LocalErrorTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var error:LocalError;
		
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
		public function error_populates_id_upon_instantiation():void
		{
			const id:int = 1000;
			
			error = new LocalError(id, "Something bad happened");
			
			assertThat(error.id, equalTo(id));
		}
		
		[Test]
		public function error_populates_description_upon_instantiation():void
		{
			const description:String = "Something bad happened";
			
			error = new LocalError(1000, description);
			
			assertThat(error.description, equalTo(description));
		}
		
		[Test]
		public function error_returns_id_and_description():void
		{
			error = new LocalError(1000, "Something bad happened");
			
			assertThat(error.toString(), equalTo("1000 Something bad happened"));
		}
	}
}