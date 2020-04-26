/**
 * VERSION: 1.0
 * DATE: 23-02-2011
 * AS3
 * UPDATES AND DOCS AT: https://code.google.com/p/as3-minesweeper/
 * 
 * Released under GNU GPL v3 License
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
package minesweeper.objects.squares
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * BasicSquare class.
	 * This class has all the properties and methods that must have all types of Squares (this includes MineSquares and NumberSquares).
	 * So, this class is inherited by them.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class BasicSquare extends Sprite
	{
		/** @private **/
		private var squareSize:int = 20;
		/** Number shown in this square when is clicked. **/
		private var _number:int = 0;
		/** Indicate if this square has a flag. **/
		protected var _hasFlag:Boolean = false;
		/** Indicate if this square has a mine. **/
		protected var _hasMine:Boolean = false;
		/** Indicate if this square is already clicked. **/
		protected var _isClicked:Boolean = false;
		
		/**
		 * Constructor.
		 * 
		 * Draws a simple button square.
		 **/
		public function BasicSquare()
		{
			reDrawButton();
		}
		
		/**
		 * Draws a flag over this button square.
		 **/
		public function putFlag():void
		{
			reDrawButton();
			this.graphics.lineStyle(0, 0x000000, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.moveTo(7, 16);
			this.graphics.lineTo(15,16);
			this.graphics.lineTo(11,14);
			this.graphics.lineTo(7,16);
			this.graphics.moveTo(11,14);
			this.graphics.lineTo(11,6);
			this.graphics.moveTo(11,6);
			this.graphics.lineStyle(0, 0xFF0000, 1);
			this.graphics.beginFill(0xFF0000);
			this.graphics.lineTo(6,8);
			this.graphics.lineTo(11,10);
			this.graphics.lineTo(11,6);
			this.graphics.endFill();
			_hasFlag = true;
		}
		
		/**
		 * Redraws this button square, so if there is a flag over it, erases it.
		 **/
		public function reDrawButton():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(squareSize, 0);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(squareSize, squareSize);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(0, squareSize);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
			_hasFlag = false;
		}
		
		/**
		 * Draws this button square being pressed.
		 **/
		public function pressButton():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(squareSize, 0);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(squareSize, squareSize);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(0, squareSize);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		/**
		 * Draws this button square opened (when is already clicked).
		 **/
		protected function releaseButton():void
		{
			this.mouseEnabled = false;
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x808080, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(20, 0);
			this.graphics.lineTo(20, 20);
			this.graphics.lineTo(0, 20);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		/**
		 * If this button square is not already clicked, indicates that this button square is clicked and opens it.
		 * Also, dispatches a MOUSE_UP event (simulating that it has been clicked).
		 **/
		public function doClick():void
		{
			_isClicked = true;
			this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS & SETTERS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * Indicate the number that will show this button square when is clicked.
		 **/
		public function set number(value:int):void
		{
			_number = value;
		}
		
		/**
		 * @return Number that will be shown when this button square is clicked if is not a mine.
		 **/
		public function get number():int
		{
			return _number;
		}
		
		/**
		 * @return Boolean that indicates if this button square is already clicked.
		 **/
		public function get isClicked():Boolean
		{
			return _isClicked;
		}
		
		/**
		 * @return Boolean that indicates if this button square has a flag.
		 **/
		public function get hasFlag():Boolean
		{
			return _hasFlag;
		}
		
		/**
		 * @return Boolean value that indicates that this button square has a mine.
		 **/
		public function get hasMine():Boolean{ return false; }
	}
}