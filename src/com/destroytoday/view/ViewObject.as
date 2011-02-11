package com.destroytoday.view
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class ViewObject extends InvalidatingSprite
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _explicitWidth:Number;
		
		protected var _explicitHeight:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ViewObject()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		override public function get width():Number
		{
			return !isNaN(_explicitWidth) ? _explicitWidth : super.width;
		}
		
		override public function set width(value:Number):void
		{
			if (value == _explicitWidth)
				return;
			
			super.width = _explicitWidth = value;
			
			invalidateDisplayList();
		}
		
		public function get measuredWidth():Number
		{
			return super.width;
		}
		
		override public function get height():Number
		{
			return !isNaN(_explicitHeight) ? _explicitHeight : super.height;
		}
		
		override public function set height(value:Number):void
		{
			if (value == _explicitHeight)
				return;
			
			super.height = _explicitHeight = value;
			
			invalidateDisplayList();
		}
		
		public function get measuredHeight():Number
		{
			return super.height;
		}
	}
}