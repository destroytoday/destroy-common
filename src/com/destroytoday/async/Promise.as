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

package com.destroytoday.async
{
	import com.destroytoday.object.IDisposable;
	
	import org.osflash.signals.ISignal;
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
		
		public function get completed():ISignal
		{
			return _completed ||= new Signal(IPromise);
		}
		
		public function set completed(value:ISignal):void
		{
			_completed = value as Signal;
		}
		
		public function get failed():ISignal
		{
			return _failed ||= new Signal(IPromise);
		}
		
		public function set failed(value:ISignal):void
		{
			_failed = value as Signal;
		}
		
		public function get progressChanged():ISignal
		{
			return _progressChanged ||= new Signal(IPromise);
		}
		
		public function set progressChanged(value:ISignal):void
		{
			_progressChanged = value as Signal;
		}

		public function get statusChanged():ISignal
		{
			return _statusChanged ||= new Signal(IPromise);
		}
		
		public function set statusChanged(value:ISignal):void
		{
			_statusChanged = value as Signal;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _resultProcessorList:Vector.<Function>;
		
		protected var _status:IPromiseStatus = PromiseStatus.PENDING;
		
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
		
		protected function setStatus(value:IPromiseStatus):void
		{
			if (value == _status) return;
			
			_status = value;
			
			if (_statusChanged) 
				_statusChanged.dispatch(this);
		}
		
		public function get status():IPromiseStatus
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