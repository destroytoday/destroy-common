package com.destroytoday.async
{
	import com.destroytoday.object.IDisposable;
	
	import org.osflash.signals.Signal;

	public class Promise implements IPromise, IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _completed:Signal;
		
		protected var _failed:Signal;
		
		protected var _progressChanged:Signal;
		
		protected var _statusChanged:Signal;
		
		public function get completed():Signal
		{
			return _completed ||= new Signal(IPromise);
		}
		
		public function set completed(value:Signal):void
		{
			_completed = value;
		}
		
		public function get failed():Signal
		{
			return _failed ||= new Signal(IPromise);
		}
		
		public function set failed(value:Signal):void
		{
			_failed = value;
		}
		
		public function get progressChanged():Signal
		{
			return _progressChanged ||= new Signal(IPromise);
		}
		
		public function set progressChanged(value:Signal):void
		{
			_progressChanged = value;
		}

		public function get statusChanged():Signal
		{
			return _statusChanged ||= new Signal(IPromise);
		}
		
		public function set statusChanged(value:Signal):void
		{
			_statusChanged = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _resultProcessorList:Vector.<Function>;
		
		protected var _status:PromiseStatus = PromiseStatus.PENDING;
		
		protected var _result:*;
		
		protected var _error:*;
		
		protected var _progress:*;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Promise()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------

		protected function get resultProcessorList():Vector.<Function>
		{
			return _resultProcessorList ||= new Vector.<Function>();
		}
		
		protected function setStatus(value:PromiseStatus):void
		{
			if (value == _status) return;
			
			_status = value;
			
			if (_statusChanged) 
				_statusChanged.dispatch(this);
		}
		
		public function get status():PromiseStatus
		{
			return _status;
		}
		
		public function get result():*
		{
			return _result;
		}
		
		public function get error():*
		{
			return _error;
		}
		
		public function get progress():*
		{
			return _progress;
		}
		
		public function get numResultProcessors():int
		{
			return (_resultProcessorList) ? _resultProcessorList.length : 0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function assertPending():void
		{
			if (_status != PromiseStatus.PENDING)
				throw new Error("Promise is no longer pending. Status is <" + _status + ">");
		}
		
		protected function removeAllListeners():void
		{
			if (_completed)
				_completed.removeAll();
			
			if (_failed)
				_failed.removeAll();
			
			if (_progressChanged)
				_progressChanged.removeAll();
			
			if (_statusChanged)
				_statusChanged.removeAll();
			
			if (_resultProcessorList)
				_resultProcessorList.length = 0;
		}
		
		protected function processResult(result:*):*
		{
			if (_resultProcessorList)
			{
				for each (var processor:Function in resultProcessorList)
				{
					result = processor(result);
				}
			}
			
			return result;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addResultProcessor(processor:Function):IPromise
		{
			assertPending();
			
			resultProcessorList[resultProcessorList.length] = processor;
			
			return this;
		}
		
		public function dispatchResult(value:*):void
		{
			assertPending();
			
			value = processResult(value);
			_result = value;
			
			setStatus(PromiseStatus.COMPLETE);
			
			if (_completed) 
				_completed.dispatch(this);
			
			removeAllListeners();
		}
		
		public function dispatchError(value:*):void
		{
			assertPending();
			
			_error = value;
			
			setStatus(PromiseStatus.FAILED);
			
			if (_failed) 
				_failed.dispatch(this);
			
			removeAllListeners();
		}
		
		public function dispatchProgress(value:*):void
		{
			assertPending();
			
			_progress = value;
			
			if (_progressChanged) 
				_progressChanged.dispatch(this);
		}
		
		public function cancel():void
		{
			assertPending();
			
			setStatus(PromiseStatus.CANCELLED);
			removeAllListeners();
		}
		
		public function dispose():void
		{
			_status = PromiseStatus.PENDING;
			_result = null;
			_error = null;
			_progress = null;
			
			removeAllListeners();
		}
	}
}