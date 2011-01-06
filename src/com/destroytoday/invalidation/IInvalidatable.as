package com.destroytoday.invalidation
{
	public interface IInvalidatable
	{
		function get invalidationManager():IInvalidationManager;
		
		function invalidate():void;
		function validate():void;
	}
}