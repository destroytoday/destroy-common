package com.destroytoday.data
{
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.Signal;

	public class ArrayListTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var list:ArrayList;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			list = new ArrayList(new Array());
			
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			list = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------		
		
		[Test]
		public function passing_array_constructor_argument_populates_array_property():void
		{
			var array:Array = new Array();
			list = new ArrayList(array);
			
			assertThat(list.array, equalTo(array));
		}
		
		[Test]
		public function item_count_is_initially_zero():void
		{
			assertThat(list.numItems, equalTo(0));
		}
		
		[Test]
		public function list_can_add_item():void
		{
			var item:Object = new Object();
			
			list.addItem(item);
			
			assertThat(list.hasItem(item));
		}
		
		[Test]
		public function adding_item_notifies_change():void
		{
			list.changed = nice(Signal);
			
			list.addItem(new Object());
			
			assertThat(list.changed, received().method('dispatch').once());
		}
		
		[Test]
		public function adding_item_appends_item_to_end_of_list():void
		{
			var item0:Object = list.addItem(new Object());
			var item1:Object = list.addItem(new Object());
			var item2:Object = list.addItem(new Object());
			
			assertThat(list.getItemAt(0), equalTo(item0));
			assertThat(list.getItemAt(1), equalTo(item1));
			assertThat(list.getItemAt(2), equalTo(item2));
		}
		
		[Test]
		public function item_count_reflects_number_of_items_in_list():void
		{
			list.addItem(new Object());
			list.addItem(new Object());
			list.addItem(new Object());
			
			assertThat(list.numItems, equalTo(3));
		}
		
		[Test]
		public function adding_item_returns_item():void
		{
			var item:Object = new Object();
			
			assertThat(list.addItem(item), equalTo(item));
		}
		
		[Test]
		public function list_can_get_item_at_index():void
		{
			var item:Object = list.addItem(new Object());
			
			assertThat(list.getItemAt(0), equalTo(item));
		}
		
		[Test]
		public function list_ignores_multiple_adds_of_same_item():void
		{
			var item:Object = new Object();
			
			list.addItem(item);
			list.addItem(item);
			
			assertThat(list.numItems, equalTo(1));
		}
		
		[Test]
		public function list_can_add_item_at_index():void
		{
			list.addItem(new Object());
			list.addItem(new Object());
			
			var item:Object = new Object();
			
			list.addItemAt(item, 1);
			
			assertThat(list.getItemAt(1), equalTo(item));
		}
		
		[Test]
		public function adding_item_at_index_notifies_change():void
		{
			list.changed = nice(Signal);
			
			list.addItemAt(new Object(), 0);
			
			assertThat(list.changed, received().method('dispatch').once());
		}
		
		[Test]
		public function adding_item_at_index_returns_item():void
		{
			var item:Object = new Object();
			
			assertThat(list.addItemAt(item, 0), equalTo(item));
		}
		
		[Test]
		public function list_can_get_item_index():void
		{
			var item0:Object = list.addItem(new Object());
			var item1:Object = list.addItem(new Object());
			var item2:Object = list.addItem(new Object());
			
			assertThat(list.getItemIndex(item0), equalTo(0));
			assertThat(list.getItemIndex(item1), equalTo(1));
			assertThat(list.getItemIndex(item2), equalTo(2));
		}
		
		[Test]
		public function list_can_remove_item():void
		{
			var item:Object = list.addItem(new Object());
			
			list.removeItem(item);
			
			assertThat(list.hasItem(item), not(true));
		}
		
		[Test]
		public function removing_item_notifies_change():void
		{
			var item:Object = list.addItem(new Object());
			
			list.changed = nice(Signal);
			
			list.removeItem(item);
			
			assertThat(list.changed, received().method('dispatch').once());
		}
		
		[Test]
		public function removing_item_returns_item():void
		{
			var item:Object = list.addItem(new Object());
			
			assertThat(list.removeItem(item), equalTo(item));
		}
		
		[Test]
		public function list_can_remove_item_at_index():void
		{
			var item:Object = list.addItem(new Object());
			
			list.removeItemAt(0);
			
			assertThat(list.hasItem(item), not(true));
		}
		
		[Test]
		public function removing_item_at_index_notifies_change():void
		{
			list.addItem(new Object());
			
			list.changed = nice(Signal);
			
			list.removeItemAt(0);
			
			assertThat(list.changed, received().method('dispatch').once());
		}
		
		[Test]
		public function removing_item_at_index_returns_item():void
		{
			var item:Object = list.addItem(new Object());
			
			assertThat(list.removeItemAt(0), equalTo(item));
		}
		
		[Test]
		public function list_can_remove_all_items():void
		{
			var item0:Object = list.addItem(new Object());
			var item1:Object = list.addItem(new Object());
			var item2:Object = list.addItem(new Object());

			list.removeAllItems();
			
			assertThat(list.hasItem(item0), not(true));
			assertThat(list.hasItem(item1), not(true));
			assertThat(list.hasItem(item2), not(true));
		}
		
		[Test]
		public function removing_all_items_notifies_change():void
		{
			list.addItem(new Object());
			list.addItem(new Object());
			list.addItem(new Object());
			
			list.changed = nice(Signal);
			
			list.removeAllItems();
			
			assertThat(list.changed, received().method('dispatch').once());
		}
		
		[Test]
		public function removing_all_items_when_no_items_exist_does_not_notify_change():void
		{
			list.changed = nice(Signal);
			
			list.removeAllItems();
			
			assertThat(list.changed, received().method('dispatch').never());
		}
	}
}