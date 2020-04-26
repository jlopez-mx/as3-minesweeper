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
	/**
	 * FlagCounter class.
	 * Counts the flags that can be used to put above a square.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class FlagCounter extends Display
	{
		/** Number showed on the display.  **/
		private var _number:int = 0;
		
		/** Constructor. **/
		public function FlagCounter(){}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS & SETTERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * When a number is set, it is rendered too.
		 **/
		public function set number(n):void{
			_number = n;
			this.writeTime(_number);
		}
		/**
		 * @return number on the display.
		 **/
		public function get number():int{
			return _number;
		}
	}
}