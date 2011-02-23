package com.destroytoday.net
{
	import com.destroytoday.support.stringloader.TestCancellingLoader;
	import com.destroytoday.support.stringloader.TestCompletingLoader;
	import com.destroytoday.support.stringloader.TestDisposingLoader;
	import com.destroytoday.support.stringloader.TestHasClearedOnDisposeLoader;
	import com.destroytoday.support.stringloader.TestHasClearedOnLoadLoader;
	import com.destroytoday.support.stringloader.TestHasClosedLoader;
	import com.destroytoday.support.stringloader.TestIOFailingLoader;
	import com.destroytoday.support.stringloader.TestPendingLoader;
	import com.destroytoday.support.stringloader.TestProgressHasDisposedLoader;
	import com.destroytoday.support.stringloader.TestProgressingLoader;
	import com.destroytoday.support.stringloader.TestSecurityFailingLoader;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;
	import org.osflash.signals.Signal;

	public class StringLoaderTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var loader:StringLoader;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, timeout=5000)]
		public function setUp():void
		{
			Async.proceedOnEvent(this, prepare(Signal), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			loader = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function loader_implements_interface():void
		{
			loader = new StringLoader();
			
			assertThat(loader is ILoader);
		}
		
		//--------------------------------------
		// status 
		//--------------------------------------
		
		[Test]
		public function status_is_idle_by_default():void
		{
			loader = new StringLoader();
			
			assertThat(loader.status, equalTo(LoadStatus.IDLE));
		}
		
		//--------------------------------------
		// status - pending 
		//--------------------------------------
		
		[Test]
		public function loader_status_is_pending_when_load_starts():void
		{
			loader = new TestPendingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.status, equalTo(LoadStatus.PENDING));
		}
		
		[Test]
		public function loader_notifies_status_change_when_load_begins():void
		{
			loader = new TestPendingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.statusChanged, received().method('dispatch').once());
		}
		
		//--------------------------------------
		// status - completed 
		//--------------------------------------
		
		[Test]
		public function status_is_completed_when_load_completes():void
		{
			loader = new TestCompletingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.status, equalTo(LoadStatus.COMPLETED));
		}
		
		[Test]
		public function loader_notifies_status_change_when_load_fails():void
		{
			loader = new TestCompletingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			// twice - pending, completed
			assertThat(loader.statusChanged, received().method('dispatch').twice());
		}
		
		//--------------------------------------
		// status - io failed 
		//--------------------------------------
		
		[Test]
		public function status_is_failed_when_load_io_fails():void
		{
			loader = new TestIOFailingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.status, equalTo(LoadStatus.FAILED));
		}
		
		[Test]
		public function loader_notifies_status_change_when_load_io_fails():void
		{
			loader = new TestIOFailingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			// twice - pending, failed
			assertThat(loader.statusChanged, received().method('dispatch').twice());
		}
		
		//--------------------------------------
		// status - security failed 
		//--------------------------------------
		
		[Test]
		public function status_is_failed_when_load_security_fails():void
		{
			loader = new TestSecurityFailingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.status, equalTo(LoadStatus.FAILED));
		}
		
		[Test]
		public function loader_notifies_status_change_when_load_security_fails():void
		{
			loader = new TestSecurityFailingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			// twice - pending, failed
			assertThat(loader.statusChanged, received().method('dispatch').twice());
		}
		
		//--------------------------------------
		// status - cancelled 
		//--------------------------------------
		
		[Test]
		public function status_is_cancelled_when_load_cancels():void
		{
			loader = new TestCancellingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.cancel();
			
			assertThat(loader.status, equalTo(LoadStatus.CANCELLED));
		}
		
		[Test]
		public function loader_notifies_status_change_when_load_cancels():void
		{
			loader = new TestCancellingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			loader.cancel();
			
			// twice - pending, cancelled
			assertThat(loader.statusChanged, received().method('dispatch').twice());
		}
		
		//--------------------------------------
		// status - dispose 
		//--------------------------------------
		
		[Test]
		public function status_is_idle_on_dispose():void
		{
			loader = new TestDisposingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.dispose();
			
			assertThat(loader.status, equalTo(LoadStatus.IDLE));
		}
		
		[Test]
		public function loader_does_not_notify_status_change_on_dispose():void
		{
			loader = new TestDisposingLoader();
			
			loader.statusChanged = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			loader.dispose();
			
			// once - pending
			assertThat(loader.statusChanged, received().method('dispatch').once());
		}
		
		//--------------------------------------
		// progress 
		//--------------------------------------
		
		[Test]
		public function progress_is_zero_by_default():void
		{
			loader = new StringLoader();
			
			assertThat(loader.progress.numLoaded, equalTo(0.0));
			assertThat(loader.progress.numTotal, equalTo(0.0));
		}
		
		[Test]
		public function loader_populates_progress_when_load_progresses():void
		{
			loader = new TestProgressingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.progress.numLoaded, equalTo(5000.0));
			assertThat(loader.progress.numTotal, equalTo(50000.0));
		}
		
		//--------------------------------------
		// result 
		//--------------------------------------
		
		[Test]
		public function result_is_null_by_default():void
		{
			loader = new StringLoader();
			
			assertThat(loader.result, nullValue());
		}
		
		[Test]
		public function loader_notifies_when_load_completes():void
		{
			loader = new TestCompletingLoader();
			
			loader.completed = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.completed, received().method('dispatch').once());
		}
		
		[Test]
		public function loader_populates_result_when_load_completes():void
		{
			loader = new TestCompletingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.result.code, 200);
			assertThat(loader.result.data, "data");
		}
		
		//--------------------------------------
		// error 
		//--------------------------------------
		
		[Test]
		public function error_is_null_by_default():void
		{
			loader = new StringLoader();
			
			assertThat(loader.error, nullValue());
		}
		
		[Test]
		public function loader_notifies_when_load_io_fails():void
		{
			loader = new TestIOFailingLoader();
			
			loader.failed = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.failed, received().method('dispatch').once());
		}
		
		[Test]
		public function loader_notifies_when_load_security_fails():void
		{
			loader = new TestSecurityFailingLoader();
			
			loader.failed = nice(Signal);
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.failed, received().method('dispatch').once());
		}
		
		[Test]
		public function loader_populates_error_when_load_io_fails():void
		{
			loader = new TestIOFailingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.error.id, equalTo(1000));
			assertThat(loader.error.code, equalTo(503));
			assertThat(loader.error.description, equalTo("Something bad happened"));
		}
		
		[Test]
		public function loader_populates_error_when_load_security_fails():void
		{
			loader = new TestSecurityFailingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.error.id, equalTo(1000));
			assertThat(loader.error.code, equalTo(503));
			assertThat(loader.error.description, equalTo("Something bad happened"));
		}
		
		//--------------------------------------
		// load 
		//--------------------------------------
		
		[Test]
		public function loader_clears_on_load():void
		{
			var loader:TestHasClearedOnLoadLoader = new TestHasClearedOnLoadLoader();
			
			loader.load(new URLRequest("http://example.com"));
			
			assertThat(loader.hasCleared);
		}
		
		//--------------------------------------
		// cancel 
		//--------------------------------------
		
		[Test]
		public function loader_closes_on_cancel():void
		{
			var loader:TestHasClosedLoader = new TestHasClosedLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.cancel();
			
			assertThat(loader.hasClosed);
		}
		
		//--------------------------------------
		// clear 
		//--------------------------------------
		
		[Test]
		public function loader_closes_on_clear():void
		{
			var loader:TestHasClosedLoader = new TestHasClosedLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.clear();
			
			assertThat(loader.hasClosed);
		}
		
		[Test]
		public function loader_nullifies_result_on_clear():void
		{
			loader = new TestCompletingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.clear();
			
			assertThat(loader.result, nullValue());
		}
		
		[Test]
		public function loader_nullifies_error_on_clear():void
		{
			loader = new TestIOFailingLoader();
			
			loader.load(new URLRequest("http://example.com"));
			loader.clear();
			
			assertThat(loader.error, nullValue());
		}
		
		[Test]
		public function loader_disposes_progress_on_clear():void
		{
			var loader:TestProgressHasDisposedLoader = new TestProgressHasDisposedLoader();
			
			loader.clear();
			
			assertThat(loader.hasProgressDisposed);
		}
		
		//--------------------------------------
		// dispose 
		//--------------------------------------
		
		[Test]
		public function loader_clears_on_dispose():void
		{
			var loader:TestHasClearedOnDisposeLoader = new TestHasClearedOnDisposeLoader();
			
			loader.dispose();
			
			assertThat(loader.hasCleared);
		}
		
		[Test]
		public function loader_removes_all_listeners_on_dispose():void
		{
			loader = new StringLoader();
			
			loader.completed = nice(Signal);
			loader.failed = nice(Signal);
			loader.statusChanged = nice(Signal);
			loader.progressChanged = nice(Signal);
			loader.dispose();
			
			assertThat(loader.completed, received().method('removeAll').once());
			assertThat(loader.failed, received().method('removeAll').once());
			assertThat(loader.statusChanged, received().method('removeAll').once());
			assertThat(loader.progressChanged, received().method('removeAll').once());
		}
	}
}