package
{
	import com.destroytoday.DestroyCommonSuite;
	
	import flash.display.Sprite;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.runner.notification.async.XMLListener;
	
	public class DestroyCommonRunner extends Sprite
	{
		public var core:FlexUnitCore;
		
		public function DestroyCommonRunner()
		{
			core = new FlexUnitCore();
			
            core.addListener(new TraceListener());
            core.addListener(new CIListener());
            core.addListener(new XMLListener());
			
            core.run(DestroyCommonSuite);
		}
	}
}