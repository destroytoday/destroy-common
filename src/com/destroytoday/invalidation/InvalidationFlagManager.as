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

package com.destroytoday.invalidation
{
	import com.destroytoday.object.ObjectMap;

	public class InvalidationFlagManager implements IInvalidationFlagManager
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _target:IInvalidatable;
		
		protected var methodList:Vector.<Function>;
		
		protected var methodMap:ObjectMap;
		
		protected var flagList:Vector.<InvalidationFlag>;
		
		protected var raisedFlagList:Vector.<InvalidationFlag>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function InvalidationFlagManager(target:IInvalidatable)
		{
			this.target = target;
			
			createProperties();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get target():IInvalidatable
		{
			return _target;
		}
		
		public function set target(value:IInvalidatable):void
		{
			_target = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function createProperties():void
		{
			methodList = new Vector.<Function>();
			methodMap = new ObjectMap();
			flagList = new Vector.<InvalidationFlag>();
			raisedFlagList = new Vector.<InvalidationFlag>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function mapMethod(method:Function, ...methodFlagList:Array):void
		{
			if (methodList.indexOf(method) == -1)
			{
				methodList[methodList.length] = method;
				
				methodMap[method] = new Vector.<InvalidationFlag>();
			}
			
			var _methodFlagList:Vector.<InvalidationFlag> = methodMap[method];
			
			for each (var flag:InvalidationFlag in methodFlagList)
			{
				if (flagList.indexOf(flag) == -1)
					flagList[flagList.length] = flag;
				
				_methodFlagList[_methodFlagList.length] = flag;
			}
		}
		
		public function hasMethodMapping(method:Function, flag:InvalidationFlag):Boolean
		{
			return methodList.indexOf(method) != -1 && (methodMap[method] as Vector.<InvalidationFlag>).indexOf(flag) != -1;
		}
		
		public function unmapAllMethodMappings():void
		{
			methodList.length = 0;
			methodMap = new ObjectMap();
			flagList.length = 0;
			raisedFlagList.length = 0;
		}
		
		public function invalidate(flag:InvalidationFlag):void
		{
			if (!flag.isRaised)
			{
				flag.isRaised = true;
			
				_target.invalidate();
			}
		}
		
		public function validate():void
		{
			for each (var flag:InvalidationFlag in flagList)
			{
				if (flag.isRaised)
				{
					flag.isRaised = false;
					
					raisedFlagList[raisedFlagList.length] = flag;
				}
			}
			
			if (raisedFlagList.length > 0)
			{
				for each (var method:Function in methodList)
				{
					var methodFlagList:Vector.<InvalidationFlag> = methodMap[method];
					
					for each (flag in methodFlagList)
					{
						if (raisedFlagList.indexOf(flag) != -1)
						{
							method();
							break;
						}
					}
				}
					
				raisedFlagList.length = 0;
			}
		}
	}
}