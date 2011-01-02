package com.destroytoday.async
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public interface IPromise
	{
		function get completed():Signal;
		function get failed():Signal;
		function get progressChanged():Signal;
		function get statusChanged():Signal;
		
		function get result():*;
		function get error():*;
		function get progress():*;
		function get status():PromiseStatus;
		
		function dispatchResult(value:*):void;
		function dispatchError(value:*):void;
		function dispatchProgress(value:*):void;
		function addResultProcessor(processor:Function):IPromise;
		
		function cancel():void;
	}
}