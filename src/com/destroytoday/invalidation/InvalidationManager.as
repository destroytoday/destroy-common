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

package com.destroytoday.invalidation
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class InvalidationManager implements IInvalidationManager
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var invalidationTimer:Timer = new Timer(20.0, 1);
		
		protected var invalidatingObjectList:Vector.<IInvalidatable> = new Vector.<IInvalidatable>();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function InvalidationManager()
		{
			invalidationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, invalidationTimerCompleteHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function invalidate():void
		{
			if (!invalidationTimer.running)
			{
				invalidationTimer.reset();
				invalidationTimer.start();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		public function invalidateObject(object:IInvalidatable):IInvalidatable
		{
			if (invalidatingObjectList.indexOf(object) == -1)
			{
				invalidatingObjectList[invalidatingObjectList.length] = object;
				
				invalidate();
			}
			
			return object;
		}
		
		public function hasObject(object:IInvalidatable):Boolean
		{
			return invalidatingObjectList.indexOf(object) != -1;
		}
		
		public function validate():void
		{
			if (invalidationTimer.running)
				invalidationTimer.stop();
			
			for each (var object:IInvalidatable in invalidatingObjectList)
				object.validate();
			
			invalidatingObjectList.length = 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function invalidationTimerCompleteHandler(event:TimerEvent):void
		{
			validate();
		}
	}
}