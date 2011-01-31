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