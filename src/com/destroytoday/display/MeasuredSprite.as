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

package com.destroytoday.display
{
	import com.destroytoday.invalidation.InvalidatingSprite;
	
	public class MeasuredSprite extends InvalidatingSprite
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
		
		public function MeasuredSprite()
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