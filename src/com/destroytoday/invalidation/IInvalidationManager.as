package com.destroytoday.invalidation
{
	public interface IInvalidationManager
	{
		function invalidateObject(object:IInvalidatable):IInvalidatable;
		
		function validate():void;
	}
}