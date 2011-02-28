/*
Copyright (c) 2011 Jonnie Hallman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package com.destroytoday.data
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class ArrayList implements IDataList
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _changed:Signal = new Signal();
		
		public function get changed():ISignal
		{
			return _changed;
		}
		
		public function set changed(value:ISignal):void
		{
			_changed = value as Signal;
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