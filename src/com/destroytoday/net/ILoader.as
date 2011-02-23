package com.destroytoday.net
{
	import com.destroytoday.data.IProgress;
	
	import flash.net.URLRequest;
	
	import org.osflash.signals.ISignal;

	public interface ILoader
	{
		function get completed():ISignal;
		function get failed():ISignal;
		function get progressChanged():ISignal;
		function get statusChanged():ISignal;
		
		function get status():ILoadStatus;
		function get progress():IProgress;
		function get result():LoadResult;
		function get error():LoadError;
		
		function load(request:URLRequest):void;
		
		function cancel():void;
	}
}