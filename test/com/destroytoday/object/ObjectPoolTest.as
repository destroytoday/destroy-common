package com.destroytoday.object
{
	import com.destroytoday.support.TestDisposableObject;
	import com.destroytoday.support.TestPoolObject;
	import com.destroytoday.support.TestTimerPool;
	
	import flash.utils.Timer;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;

	public class ObjectPoolTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var pool:ObjectPool;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
			pool = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function type_constructor_argument_populates_type():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			assertThat(pool.type, equalTo(TestPoolObject));
		}
		
		[Test]
		public function size_constructor_argument_preallocates_pool():void
		{
			pool = new ObjectPool(TestPoolObject, 20);
			
			assertThat(pool.numObjects, equalTo(20));
		}
		
		[Test]
		public function pool_is_initially_empty():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			assertThat(pool.numObjects, equalTo(0));
		}
		
		[Test]
		public function getting_object_returns_object_of_specified_type():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			assertThat(pool.getObject(), isA(TestPoolObject));
		}
		
		[Test]
		public function pool_stores_disposed_object():void
		{
			pool = new ObjectPool(TestPoolObject);
			var object:TestPoolObject = new TestPoolObject();
			
			pool.disposeObject(object);
			
			assertThat(pool.hasObject(object), equalTo(true));
		}
		
		[Test(expects="TypeError")]
		public function disposing_incorrect_object_type_throws_error():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			pool.disposeObject(new Object());
		}
		
		[Test]
		public function pool_returns_number_of_disposed_objects():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			pool.disposeObject(new TestPoolObject());
			pool.disposeObject(new TestPoolObject());
			pool.disposeObject(new TestPoolObject());
			
			assertThat(pool.numObjects, equalTo(3));
		}
		
		[Test]
		public function pool_recycles_disposed_object():void
		{
			pool = new ObjectPool(TestPoolObject);
			var object:TestPoolObject = new TestPoolObject();
			
			pool.disposeObject(object);
			
			assertThat(pool.getObject(), equalTo(object));
		}
		
		[Test]
		public function pool_removes_object_from_pool_when_getting_object():void
		{
			pool = new ObjectPool(TestPoolObject);
			var object:TestPoolObject = pool.getObject();
			
			pool.disposeObject(object);
			pool.getObject();
			
			assertThat(pool.hasObject(object), equalTo(false));
		}
		
		[Test]
		public function emptying_pool_removes_all_disposed_objects():void
		{
			pool = new ObjectPool(TestPoolObject);
			
			pool.disposeObject(new TestPoolObject());
			pool.disposeObject(new TestPoolObject());
			pool.disposeObject(new TestPoolObject());
			pool.empty();
			
			assertThat(pool.numObjects, equalTo(0));
		}
		
		[Test]
		public function extending_class_can_override_factory_method_for_objects_with_constructor_arguments():void
		{
			pool = new TestTimerPool();
			
			assertThat(pool.getObject(), isA(Timer));
		}
		
		[Test]
		public function pool_calls_dispose_method_upon_disposal():void
		{
			pool = new ObjectPool(TestDisposableObject);
			var object:TestDisposableObject = new TestDisposableObject();
			
			pool.disposeObject(object);
			
			assertThat(object.wasDisposed, equalTo(true));
		}
	}
}