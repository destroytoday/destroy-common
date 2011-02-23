package com.destroytoday.net
{
	import flash.events.Event;

	public class XMLLoader extends StringLoader
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function XMLLoader()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		override protected function parseResult(data:*):*
		{
			try
			{
				data = new XML(loader.data);
			}
			catch(error:Error)
			{
				data = null;
				
				dispatchError(error.errorID, 0, error.message);
			}
			
			return data;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		override protected function loader_completeHandler(event:Event):void
		{
			var parsedResult:* = parseResult(loader.data);
			
			if (parsedResult != null)
				dispatchResult(responseCode, parsedResult);
		}
	}
}