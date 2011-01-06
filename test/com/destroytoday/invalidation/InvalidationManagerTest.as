package com.destroytoday.invalidation
{
	import com.destroytoday.support.TestInvalidatingObject;
	import com.destroytoday.support.TestOrderingInvalidatingObject;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;

	public class InvalidationManagerTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var manager:InvalidationManager;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(InvalidationManager, TestInvalidatingObject), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Helper Methods
		//
		//--------------------------------------------------------------------------
		
		protected function delayCall(callback:Function, delay:Number):void
		{
			var timer:Timer = new Timer(50.0, 1);
			
			Async.handleEvent(this, timer, TimerEvent.TIMER_COMPLETE, function(event:TimerEvent, object:Object):void
			{
				callback();
			});
			
			timer.start();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function manager_implements_interface():void
		{
			manager = new InvalidationManager();
			
			assertThat(manager, isA(IInvalidationManager));
		}
		
		[Test(async, timeout=1000)]
		public function invalidating_delays_validate_call():void
		{
			manager = nice(InvalidationManager);
			mock(manager).method('invalidateObject').callsSuper();
			
			manager.invalidateObject(new TestInvalidatingObject());
			
			delayCall(function():void
			{
				assertThat(manager, received().method('validate').once());
			}, 500);
		}
		
		[Test(async, timeout=1000)]
		public function forcing_validation_cancels_delayed_validation():void
		{
			manager = nice(InvalidationManager);
			mock(manager).method('invalidateObject').callsSuper();
			mock(manager).method('validate').callsSuper();
			
			manager.invalidateObject(new TestInvalidatingObject());
			manager.validate();
			
			delayCall(function():void
			{
				assertThat(manager, received().method('validate').once());
			}, 500);
		}
		
		[Test]
		public function manager_does_not_have_object_it_is_not_invalidating():void
		{
			manager = new InvalidationManager();
			var object:TestInvalidatingObject = new TestInvalidatingObject();
			
			assertThat(not(manager.hasObject(object)));
		}
		
		[Test]
		public function manager_has_object_it_is_invalidating():void
		{
			manager = new InvalidationManager();
			var object:TestInvalidatingObject = new TestInvalidatingObject();
			
			manager.invalidateObject(object);
			
			assertThat(manager.hasObject(object));
		}
		
		[Test]
		public function invalidating_object_validates_object():void
		{
			manager = new InvalidationManager();
			var object:TestInvalidatingObject = nice(TestInvalidatingObject);
			
			manager.invalidateObject(object);
			manager.validate();
			
			assertThat(object, received().method('validate').once());
		}
		
		[Test]
		public function manager_removes_object_reference_after_validating():void
		{
			manager = new InvalidationManager();
			var object:TestInvalidatingObject = new TestInvalidatingObject();
			
			manager.invalidateObject(object);
			manager.validate();
			
			assertThat(not(manager.hasObject(object)));
		}
		
		[Test]
		public function manager_invalidates_objects_in_order_of_invalidating():void
		{
			manager = new InvalidationManager();
			var orderList:Array = new Array();
			var object0:TestOrderingInvalidatingObject = new TestOrderingInvalidatingObject(orderList);
			var object1:TestOrderingInvalidatingObject = new TestOrderingInvalidatingObject(orderList);
			var object2:TestOrderingInvalidatingObject = new TestOrderingInvalidatingObject(orderList);
			
			manager.invalidateObject(object0);
			manager.invalidateObject(object1);
			manager.invalidateObject(object2);
			manager.validate();
			
			assertThat(orderList, equalTo([object0, object1, object2]));
		}
	}
}