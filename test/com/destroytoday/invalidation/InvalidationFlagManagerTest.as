package com.destroytoday.invalidation
{
	import com.destroytoday.support.invalidationflagmanager.TestInvalidatesTarget;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class InvalidationFlagManagerTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var manager:InvalidationFlagManager;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[After]
		public function tearDown():void
		{
			manager = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function should_implement_interface():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			
			assertThat(manager is IInvalidationFlagManager);
		}
		
		[Test]
		public function should_populate_target_with_constructor_argument():void
		{
			var invalidatable:IInvalidatable = new InvalidatingSprite();
			manager = new InvalidationFlagManager(invalidatable);
			
			assertThat(manager.target, equalTo(invalidatable));
		}
		
		[Test]
		public function should_map_method_with_one_flag():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var method:Function = function():void {};
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, flag);
			
			assertThat(manager.hasMethodMapping(method, flag));
		}
		
		[Test]
		public function should_map_method_with_multiple_flags():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var method:Function = function():void {};
			var sizeFlag:InvalidationFlag = new InvalidationFlag('size');
			var dataFlag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, sizeFlag, dataFlag);
			
			assertThat(manager.hasMethodMapping(method, sizeFlag));
			assertThat(manager.hasMethodMapping(method, dataFlag));
		}
		
		[Test]
		public function should_not_have_method_mapping_when_does_not_exist():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			
			assertThat(!manager.hasMethodMapping(function():void {}, new InvalidationFlag('data')));
		}
		
		[Test]
		public function should_not_have_method_mapping_with_incorrect_method():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(function():void {}, flag);
			
			assertThat(!manager.hasMethodMapping(function():void {}, flag));
		}
		
		[Test]
		public function should_not_have_method_mapping_with_incorrect_flag():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var method:Function = function():void {};
			
			manager.mapMethod(method, new InvalidationFlag('data'));
			
			assertThat(!manager.hasMethodMapping(method, new InvalidationFlag('size')));
		}
		
		[Test]
		public function should_not_have_method_mapping_after_unmapping_all_method_mappings():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var method:Function = function():void {};
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, flag);
			manager.unmapAllMethodMappings();
			
			assertThat(!manager.hasMethodMapping(method, flag));
		}
		
		[Test]
		public function should_invalidate_target_on_invalidate():void
		{
			var target:TestInvalidatesTarget = new TestInvalidatesTarget();
			manager = new InvalidationFlagManager(target);
			
			manager.invalidate(new InvalidationFlag('data'));
			
			assertThat(target.hasInvalidated);
		}
		
		[Test]
		public function should_raise_flag_on_invalidate():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(function():void {}, flag);
			manager.invalidate(flag);
			
			assertThat(flag.isRaised);
		}
		
		[Test]
		public function should_lower_raised_flags_on_validate():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(function():void {}, flag);
			manager.invalidate(flag);
			manager.validate();
			
			assertThat(!flag.isRaised);
		}
		
		[Test]
		public function should_call_method_mapped_to_raised_flag():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var hasCalled:Boolean;
			var method:Function = function():void { hasCalled = true; };
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, flag);
			manager.invalidate(flag);
			manager.validate();
			
			assertThat(hasCalled);
		}
		
		[Test]
		public function should_not_call_method_mapped_to_unraised_flag():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var hasCalled:Boolean;
			var method:Function = function():void { hasCalled = true; };
			var flag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, flag);
			manager.invalidate(new InvalidationFlag('size'));
			manager.validate();
			
			assertThat(!hasCalled);
		}
		
		[Test]
		public function should_call_method_mapped_to_one_raised_flag_and_one_unraised_flag():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var hasCalled:Boolean;
			var method:Function = function():void { hasCalled = true; };
			var sizeFlag:InvalidationFlag = new InvalidationFlag('size');
			var dataFlag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, sizeFlag, dataFlag);
			manager.invalidate(dataFlag);
			manager.validate();
			
			assertThat(hasCalled);
		}
		
		[Test]
		public function should_call_method_mapped_to_multiple_raised_flags():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var hasCalled:Boolean;
			var method:Function = function():void { hasCalled = true; };
			var sizeFlag:InvalidationFlag = new InvalidationFlag('size');
			var dataFlag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, sizeFlag, dataFlag);
			manager.invalidate(sizeFlag);
			manager.invalidate(dataFlag);
			manager.validate();
			
			assertThat(hasCalled);
		}
		
		[Test]
		public function should_call_method_mapped_to_multiple_raised_flags_only_once():void
		{
			manager = new InvalidationFlagManager(new InvalidatingSprite());
			var numCalled:int;
			var method:Function = function():void { numCalled++; };
			var sizeFlag:InvalidationFlag = new InvalidationFlag('size');
			var dataFlag:InvalidationFlag = new InvalidationFlag('data');
			
			manager.mapMethod(method, sizeFlag, dataFlag);
			manager.invalidate(sizeFlag);
			manager.invalidate(dataFlag);
			manager.validate();
			
			assertThat(numCalled, equalTo(1));
		}
	}
}