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
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import minesweeper.events.BoardEvent;
	import minesweeper.utils.MinesweeperState;
	
	/**
	 * Board class.
	 * Creates a board object that contains a clock and a flag counter displays, and a button with a face on it.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Board extends Sprite
	{
		/**  Clock display. **/
		private var _clock:Clock = new Clock();
		/**  Flag counter display. **/
		private var _flagCounter:FlagCounter = new FlagCounter();
		/**  Button with a face on it. **/
		private var _sunButton:SunButton = new SunButton();
		
		/** Board width specified by the constructor. **/
		private var _boardWidth:int;
		
		/**
		 * Constructor.
		 * 
		 * @param boardWidth Specify the width of the board in pixels.
		 **/
		public function Board(boardWidth:int)
		{
			_boardWidth = boardWidth;
			initialize();
		}
		
		/**
		 * @private
		 * Initializes the board, positioning on it the button, the clock display and the flag counter display, and adding them to the stage.
		 * Also, draws the background of the board (the rectangle that has inside the button, the clock and the flag counter).
		 **/
		private function initialize():void
		{
			_sunButton.x = (_boardWidth/2) - (sunButton.width/2);
			_sunButton.y = 7;
			
			_clock.x = _boardWidth - (flagCounter.width/2) - 10;
			_clock.y = 7;
			
			_flagCounter.x = 8
			_flagCounter.y = 7;
			
			this.addChild(clock);
			this.addChild(flagCounter);
			this.addChild(sunButton);
			
			drawBoard();
		}
		
		/**
		 * @private
		 * Draws the background of the board (the rectangle that has inside the button, the clock and the flag counter).
		 **/
		public function drawBoard():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(3, 0x808080, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(_boardWidth-3, 0);
			this.graphics.lineStyle(3, 0xFFFFFF, 1);
			this.graphics.lineTo(_boardWidth-3, 38);
			this.graphics.lineStyle(3, 0xFFFFFF, 1);
			this.graphics.lineTo(0, 38);
			this.graphics.lineStyle(3, 0x808080, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * @return clock display object on the board.
		 **/
		public function get clock():Clock
		{
			return _clock;
		}
		
		/**
		 * @return flag counter display on the board.
		 **/
		public function get flagCounter():FlagCounter
		{
			return _flagCounter;
		}
		
		/**
		 * @return button with a face on it on the board.
		 **/
		public function get sunButton():SunButton
		{
			return _sunButton;
		}
	}
}