package com.destroytoday.invalidation
{
	public interface IInvalidatable
	{
		function invalidate():void;
		function validate():void;
	}
}