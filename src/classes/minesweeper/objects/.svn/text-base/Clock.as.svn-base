/**
 * VERSION: 1.0
 * DATE: 26-02-2011
 * AS3
 * UPDATES AND DOCS AT: https://code.google.com/p/as3-minesweeper/
 * 
 * Released under GNU GPL v3 License
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
package minesweeper.objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import minesweeper.events.MinefieldEvent;
	
	/**
	 * Clock class.
	 * Creates a clock display object, that counts the seconds transcurred since first click, and dispatches 'Time Up' if it reaches to 999 seconds.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Clock extends Display
	{
		/**
		 * Timer that controls the seconds transcurred.
		 * Dispatches each second transcurred.
		 * Finalizes when it reaches 999 seconds. 
		 **/
		private var timer:Timer = new Timer(1000, 999);
		/**
		 * Constructor.
		 **/
		public function Clock()
		{
			addEventListeners();
		}
		/**
		 * @private
		 * Add event listeners to the timer object.
		 **/
		private function addEventListeners():void
		{
			timer.addEventListener(TimerEvent.TIMER, timer_handler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete_handler);
		}
		
		////////////////////////////////////////////////////////////////
		/* PUBLIC FUNCTIONS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * Starts the timer of this Clock display object.
		 **/
		public function start():void
		{
			timer.start();
		}
		/**
		 * Stops the timer of this Clock display object.
		 **/
		public function stop():void
		{
			timer.stop();
		}
		/**
		 * Stops and resets the timer object that controls the seconds transcurred on this display object.
		 * Renders '000' on this display. 
		 **/
		public function reset():void
		{
			timer.stop();
			timer.reset();
			writeTime(timer.currentCount);
		}
		
		////////////////////////////////////////////////////////////////
		/* HANDLERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * When the timer object reaches 999, this handler function is invoked.
		 * This display object dispatches a 'Time Up' event.
		 **/
		private function timerComplete_handler(event:TimerEvent):void
		{
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.TIME_UP));
		}
		/**
		 * This handler function is invoked each second (1000 ms).
		 * Renders the current count on the timer object.
		 **/
		private function timer_handler(event:TimerEvent):void
		{
			writeTime(timer.currentCount);
		}
	}
}