package com.destroytoday.invalidation
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class InvalidatingSprite extends Sprite implements IInvalidatable
	{
		//--------------------------------------------------------------------------
		//
		//  Flags
		//
		//--------------------------------------------------------------------------
		
		protected var isInvalidating:Boolean;
		
		protected var isPropertyListDirty:Boolean;
		
		protected var isDisplayListDirty:Boolean;
		
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
		
		public function invalidatePropertyList():void
		{
			isPropertyListDirty = true;
			
			invalidate();
		}
		
		public function invalidateDisplayList():void
		{
			isDisplayListDirty = true;
			
			invalidate();
		}
		
		public function invalidate():void
		{
			if (stage && !isInvalidating)
				startInvalidating();
		}
		
		public function validate():void
		{
			stopInvalidating();
			
			if (isPropertyListDirty)
			{
				isPropertyListDirty = false;
				
				updatePropertyList();
			}
			
			if (isDisplayListDirty)
			{
				isDisplayListDirty = false;
				
				updateDisplayList();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Invalidation
		//
		//--------------------------------------------------------------------------
		
		protected function updatePropertyList():void
		{
			
		}
		
		protected function updateDisplayList():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function addedToStageHandler(event:Event):void
		{
			if (isPropertyListDirty || isDisplayListDirty)
				invalidate();
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			stopInvalidating();
		}
		
		protected function invalidateHandler(event:Event):void
		{
			validate();
		}
	}
}