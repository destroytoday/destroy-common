package com.destroytoday.object
{
	import org.flexunit.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	
	public class ObjectMapTest
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var map:ObjectMap;
		
		protected var key:Object;
		
		protected var value:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			map = new ObjectMap();
			key = {name: "key"};
			value = {name: "value"};
		}
		
		[After]
		public function tearDown():void
		{
			map = null;
			key = null;
			value = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function can_map_value_with_key():void
		{
			map.mapValue(key, value);
			
			assertThat(value, equalTo(map[key]));
		}
		
		[Test]
		public function can_unmap_value_with_key():void
		{
			map.mapValue(key, value);
			map.unmapValue(key);
			
			assertThat(map[key], nullValue());
		}

		[Test]
		public function mapping_a_value_returns_a_value():void
		{
			assertThat(value, equalTo(map.mapValue(key, value)));
		}
		
		[Test]
		public function unmapping_a_value_returns_a_value():void
		{
			map.mapValue(key, value);
			
			assertThat(value, equalTo(map.unmapValue(key)));
		}
	}
}