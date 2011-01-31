package com.destroytoday.data
{
	import org.osflash.signals.Signal;
	
	public class ArrayList implements IDataList
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _changed:Signal;
		
		public function get changed():Signal
		{
			return _changed ||= new Signal();
		}
		
		public function set changed(value:Signal):void
		{
			_changed = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _array:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ArrayList(array:Array)
		{
			_array = array;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get array():Array
		{
			return _array;
		}
		
		public function set array(value:Array):void
		{
			if (value == _array)
				return;
			
			_array = value;
			
			dispatchChanged();
		}
		
		public function get numItems():int
		{
			return _array.length;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function dispatchChanged():void
		{
			if (_changed)
				_changed.dispatch();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function getItemAt(index:int):*
		{
			return _array[index];
		}
		
		public function getItemIndex(item:Object):int
		{
			return _array.indexOf(item);
		}
		
		public function hasItem(item:Object):Boolean
		{
			return _array.indexOf(item) != -1;
		}
		
		public function addItem(item:Object):*
		{
			if (_array.indexOf(item) == -1)
			{
				_array[_array.length] = item;
				
				dispatchChanged();
			}
			
			return item;
		}
		
		public function addItemAt(item:Object, index:int):*
		{
			if (_array.indexOf(item) == -1)
			{
				_array.splice(index, 0, item);
				
				dispatchChanged();
			}
			
			return item;
		}
		
		public function removeItem(item:Object):*
		{
			var index:int = _array.indexOf(item);
			
			if (index != -1)
			{
				_array.splice(index, 1);
				
				dispatchChanged();
			}
			
			return item;
		}
		
		public function removeItemAt(index:int):*
		{
			var item:Object = _array[index];
			
			_array.splice(index, 1);
			
			dispatchChanged();
			
			return item;
		}
		
		public function removeAllItems():void
		{
			if (_array.length == 0)
				return;
			
			_array.length = 0;
			
			dispatchChanged();
		}
	}
}