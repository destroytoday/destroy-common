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
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class InvalidatingSprite extends Sprite implements IInvalidatable
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _flagManager:IInvalidationFlagManager;
		
		protected var isInvalidating:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function InvalidatingSprite()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------

		protected function get flagManager():IInvalidationFlagManager
		{
			return _flagManager ||= new InvalidationFlagManager(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function startInvalidating():void
		{
			isInvalidating = true;
				
			addEventListener(Event.RENDER, invalidateHandler);
			addEventListener(Event.ENTER_FRAME, invalidateHandler);
			
			stage.invalidate();
		}
		
		protected function stopInvalidating():void
		{
			isInvalidating = false;
			
			removeEventListener(Event.RENDER, invalidateHandler);
			removeEventListener(Event.ENTER_FRAME, invalidateHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function invalidate():void
		{
			if (stage && !isInvalidating)
				startInvalidating();
		}
		
		public function validate():void
		{
			stopInvalidating();
			flagManager.validate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function addedToStageHandler(event:Event):void
		{
			invalidate();
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			if (isInvalidating)
				stopInvalidating();
		}
		
		protected function invalidateHandler(event:Event):void
		{
			validate();
		}
	}
}