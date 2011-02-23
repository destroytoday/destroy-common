package com.destroytoday.data
{
	import com.destroytoday.object.IDisposable;

	public class Progress implements IProgress, IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _numLoaded:int;
		
		protected var _numTotal:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Progress()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get numLoaded():int
		{
			return _numLoaded;
		}
		
		public function set numLoaded(value:int):void
		{
			_numLoaded = value;
		}
		
		public function get numTotal():int
		{
			return _numTotal;
		}
		
		public function set numTotal(value:int):void
		{
			_numTotal = value;
		}
		
		public function get percentLoaded():Number
		{
			return _numLoaded / _numTotal || 0.0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function dispose():void
		{
			_numLoaded = 0;
			_numTotal = 0;
		}
		
		public function toString():String
		{
			return _numLoaded + " " + _numTotal + " " + percentLoaded;
		}
	}
}