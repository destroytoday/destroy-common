package com.destroytoday.async
{
	import com.destroytoday.support.TestDispatchedSignal;
	import com.destroytoday.support.TestPromiseError;
	import com.destroytoday.support.TestPromiseProgress;
	import com.destroytoday.support.TestPromiseResult;
	import com.destroytoday.support.TestRemovedAllListenersSignal;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.strictlyEqualTo;

	public class PromiseTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var promise:Promise;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			promise = new Promise();
		}
		
		[After]
		public function tearDown():void
		{
			promise = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function promise_implements_promise_interface():void
		{
			assertThat(promise, isA(IPromise));
		}
		
		[Test]
		public function promise_status_is_initially_pending():void
		{
			assertThat(promise.status, equalTo(PromiseStatus.PENDING));
		}
		
		[Test]
		public function dispatching_result_changes_status_to_complete():void
		{
			promise.dispatchResult(new TestPromiseResult());
			
			assertThat(promise.status, equalTo(PromiseStatus.COMPLETE));
		}
		
		[Test]
		public function dispatching_error_changes_status_to_failed():void
		{
			promise.dispatchError(new TestPromiseResult());
			
			assertThat(promise.status, equalTo(PromiseStatus.FAILED));
		}
		
		[Test]
		public function cancelling_changes_status_to_cancelled():void
		{
			promise.cancel();
			
			assertThat(promise.status, equalTo(PromiseStatus.CANCELLED));
		}
		
		[Test]
		public function changing_status_dispatches_status_changed_signal():void
		{
			var statusChanged:TestDispatchedSignal = new TestDispatchedSignal(IPromise);
			promise.statusChanged = statusChanged;
			
			promise.cancel();
			
			assertThat(statusChanged.hasDispatched);
		}
		
		[Test]
		public function dispatching_result_dispatches_completed_signal():void
		{
			var completed:TestDispatchedSignal = new TestDispatchedSignal(IPromise);
			promise.completed = completed;
			
			promise.dispatchResult(new TestPromiseResult());
			
			assertThat(completed.hasDispatched);
		}
		
		[Test]
		public function dispatching_error_dispatches_failed_signal():void
		{
			var failed:TestDispatchedSignal = new TestDispatchedSignal(IPromise);
			promise.failed = failed;
			
			promise.dispatchError(new TestPromiseError());
			
			assertThat(failed.hasDispatched);
		}
		
		[Test]
		public function dispatching_progress_dispatches_progress_changed_signal():void
		{
			var progressChanged:TestDispatchedSignal = new TestDispatchedSignal(IPromise);
			promise.progressChanged = progressChanged;
			
			promise.dispatchProgress(new TestPromiseProgress());
			
			assertThat(progressChanged.hasDispatched);
		}
		
		[Test]
		public function cancelling_removes_all_listeners():void
		{
			var completed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.completed = completed;
			
			var failed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.failed = failed;
			
			var statusChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.statusChanged = statusChanged;
			
			var progressChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.progressChanged = progressChanged;
			
			promise.cancel();
			
			assertThat(completed.hasRemovedAllListeners);
			assertThat(failed.hasRemovedAllListeners);
			assertThat(statusChanged.hasRemovedAllListeners);
			assertThat(progressChanged.hasRemovedAllListeners);
		}
		
		[Test]
		public function dispatching_result_removes_all_listeners():void
		{
			var completed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.completed = completed;
			
			var failed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.failed = failed;
			
			var statusChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.statusChanged = statusChanged;
			
			var progressChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.progressChanged = progressChanged;
			
			promise.dispatchResult(new TestPromiseResult());
			
			assertThat(completed.hasRemovedAllListeners);
			assertThat(failed.hasRemovedAllListeners);
			assertThat(statusChanged.hasRemovedAllListeners);
			assertThat(progressChanged.hasRemovedAllListeners);
		}
		
		[Test]
		public function dispatching_error_removes_all_listeners():void
		{
			var completed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.completed = completed;
			
			var failed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.failed = failed;
			
			var statusChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.statusChanged = statusChanged;
			
			var progressChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.progressChanged = progressChanged;
			
			promise.dispatchError(new TestPromiseError());
			
			assertThat(completed.hasRemovedAllListeners);
			assertThat(failed.hasRemovedAllListeners);
			assertThat(statusChanged.hasRemovedAllListeners);
			assertThat(progressChanged.hasRemovedAllListeners);
		}
		
		[Test]
		public function disposing_promise_removes_all_listeners():void
		{
			var completed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.completed = completed;
			
			var failed:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.failed = failed;
			
			var statusChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.statusChanged = statusChanged;
			
			var progressChanged:TestRemovedAllListenersSignal = new TestRemovedAllListenersSignal(IPromise);
			promise.progressChanged = progressChanged;
			
			promise.dispose();
			
			assertThat(completed.hasRemovedAllListeners);
			assertThat(failed.hasRemovedAllListeners);
			assertThat(statusChanged.hasRemovedAllListeners);
			assertThat(progressChanged.hasRemovedAllListeners);
		}
		
		[Test]
		public function dispatching_result_populates_result():void
		{
			var result:TestPromiseResult = new TestPromiseResult();
			
			promise.dispatchResult(result);
			
			assertThat(promise.result, strictlyEqualTo(result));
		}
		
		[Test]
		public function dispatching_error_populates_error():void
		{
			var error:TestPromiseError = new TestPromiseError();
			
			promise.dispatchError(error);
			
			assertThat(promise.error, strictlyEqualTo(error));
		}
		
		[Test]
		public function promise_returns_num_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			assertThat(promise.numResultProcessors, equalTo(2));
		}
		
		[Test]
		public function dispatching_result_applies_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			promise.dispatchResult(0);
			
			assertThat(promise.result, equalTo(3));
		}
		
		[Test]
		public function dispatching_cancel_removes_all_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			promise.cancel();
			
			assertThat(promise.numResultProcessors, equalTo(0));
		}
		
		[Test]
		public function dispatching_result_removes_all_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			promise.dispatchResult(0);
			
			assertThat(promise.numResultProcessors, equalTo(0));
		}
		
		[Test]
		public function dispatching_error_removes_all_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			promise.dispatchError(new TestPromiseError());
			
			assertThat(promise.numResultProcessors, equalTo(0));
		}
		
		[Test]
		public function disposing_promise_removes_all_result_processors():void
		{
			promise.addResultProcessor(function(result:*):* { return result + 1; });
			promise.addResultProcessor(function(result:*):* { return result + 2; });
			
			promise.dispose();
			
			assertThat(promise.numResultProcessors, equalTo(0));
		}
		
		[Test]
		public function disposing_promise_resets_status_to_pending():void
		{
			promise.dispatchResult(new TestPromiseResult());
			promise.dispose();
			
			assertThat(promise.status, equalTo(PromiseStatus.PENDING));
		}
		
		[Test(expects="Error")]
		public function dispatching_result_when_not_pending_throws_error():void
		{
			promise.dispatchResult(new TestPromiseResult());
			promise.dispatchResult(new TestPromiseResult());
		}
		
		[Test(expects="Error")]
		public function dispatching_error_when_not_pending_throws_error():void
		{
			promise.dispatchError(new TestPromiseError());
			promise.dispatchError(new TestPromiseError());
		}
		
		[Test(expects="Error")]
		public function dispatching_progress_when_not_pending_throws_error():void
		{
			promise.cancel();
			promise.dispatchProgress(new TestPromiseProgress());
		}
		
		[Test(expects="Error")]
		public function canceling_when_not_pending_throws_error():void
		{
			promise.cancel();
			promise.cancel();
		}
		
		[Test(expects="Error")]
		public function adding_result_processor_when_not_pending_throws_error():void
		{
			promise.cancel();
			promise.addResultProcessor(function(result:*):* { return result; });
		}
	}
}