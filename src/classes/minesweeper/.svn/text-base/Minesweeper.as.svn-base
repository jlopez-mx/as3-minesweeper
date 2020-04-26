/**
 * VERSION: 1.0
 * DATE: 22-02-2011
 * AS3
 * UPDATES AND DOCS AT: https://code.google.com/p/as3-minesweeper/
 * 
 * Released under GNU GPL v3 License
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
package minesweeper 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import minesweeper.events.MinefieldEvent;
	import minesweeper.objects.Board;
	import minesweeper.objects.Minefield;
	import minesweeper.utils.MinesweeperState;
	
	/**
	 * Minesweeper class.
	 * Creates a minesweeper object just specifying the number of squares for width and height, and the numbers of mines on the minefield.
	 * The number of mines must be less than 60% of the total squares, this is controlled by the Minefield object.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Minesweeper extends Sprite
	{
		/** Board of minesweeper. Contains a flag counter display, a clock display, and a button with a face.**/
		private var _board:Board;
		/** Minefield that contains all the squares.**/
		private var _minefield:Minefield;
		
		/**
		 * Constructor.
		 * 
		 * @param xSize specifies the number of squares for width.
		 * @param ySize specifies the number of squares for height.
		 * @param minesNumber specifies the number of mines on the minefield.
		 **/
		public function Minesweeper(xSize,ySize,minesNumber)
		{
			trace("Minesweeper V.1.0");
			try{
				_minefield = new Minefield(xSize, ySize, minesNumber);
				_board = new Board(_minefield.width);
				initialize();
				addEventListeners();
				drawBackground();
			}catch(e:Error){
				trace("ERROR: " + e.message);
			}
		}
		
		/**
		 * @private 
		 * Initializes the flag counter on the board  with the number of mines specified on the constructor.
		 * Position the board and the minefield, and adds it to the stage.
		 **/
		private function initialize():void
		{
			_board.flagCounter.number = _minefield.minesNumber;
			_board.x = 10;
			_board.y = 10;
			_minefield.x = _board.x;
			_minefield.y = _board.height + _board.x + 7;
			this.addChild(_minefield);
			this.addChild(_board);
		}
		
		/**
		 * @private 
		 * Adds the event listeners for the stage and the minefield.
		 * This includes listening for the spacebar, wich is added on the handler function addedToStage_handler .
		 * And also adds event listeners for the subButton and the clock, both on the board.
		 **/
		private function addEventListeners():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown_handler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp_handler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseRollOut_handler, false, 0, true);
			_board.sunButton.addEventListener(MinefieldEvent.NEW_GAME, newGame_handler, false, 0, true);
			_board.clock.addEventListener(MinefieldEvent.TIME_UP, timeUp_handler, false, 0, true);
			_minefield.addEventListener(MinefieldEvent.GAME_OVER, minefieldGameOver_handler, false, 0, true);
			_minefield.addEventListener(MinefieldEvent.WIN_GAME, minefieldWinGame_handler, false, 0, true);
			_minefield.addEventListener(MinefieldEvent.RESTING, minefieldResting_handler, false, 0, true);
			_minefield.addEventListener(MinefieldEvent.SWEEPING, minefieldSweeping_handler, false, 0, true);
			_minefield.addEventListener(MinefieldEvent.START_GAME, minefieldStartGame_handler, false, 0, true);
		}
		
		/**
		 * Draws the background of the minefield
		 * (the rectangle that has inside the board and the minefield).
		 **/
		private function drawBackground():void
		{
			var backgroundWidth:int = (_minefield.xSize * 22) + 14;
			var backgroundHeigth:int = (_minefield.ySize * 22) + 14 + _minefield.y;
			
			this.graphics.clear();
			this.graphics.lineStyle(4, 0xFFFFFF, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(backgroundWidth + 10, 0);
			this.graphics.lineStyle(4, 0x808080, 1);
			this.graphics.lineTo(backgroundWidth + 10, backgroundHeigth);
			this.graphics.lineStyle(4, 0x808080, 1);
			this.graphics.lineTo(0, backgroundHeigth);
			this.graphics.lineStyle(4, 0xFFFFFF, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		////////////////////////////////////////////////////////////////
		/* HANDLERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 * This handler function that is invoked when this object is added to the stage, adds the listener for the spacebar.
		 **/
		private function addedToStage_handler(e:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKey_handler, false, 0, true);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
		}
		
		/**
		 * When a key is pressed, this handler function is invoked.
		 * 
		 * If the spacebar is pressed, puts a flag on the square of the minefield where the mouse is over, and substracts 1 to the flag counter on the board. 
		 * Or if the square already has a flag, removes it and sums 1 to the flag counter display on the board.
		 * But only if it is the first click, starts the clock display on the board.
		 **/
		private function pressKey_handler(keyEvent:KeyboardEvent):void
		{
			var spacebarKey:int = 32;
			
			if(keyEvent.keyCode == spacebarKey){
				if(!_minefield.mouseOverSquareHasFlag && _board.flagCounter.number > 0 && _minefield.isMouseOver){
					if(_minefield.isFirstClick){
						_board.clock.start();
					}
					_board.flagCounter.number--;
					_minefield.putFlagOnCurrentSquare();
				}else if(_minefield.mouseOverSquareHasFlag){
					_board.flagCounter.number++;
					_minefield.deleteFlagOnCurrentSquare();
				}
			}
		}
		
		/**
		 * @private
		 * When the minefield is clicked for the first time, this handler function is invoked.
		 * Starts the clock display on the board.
		 **/
		private function minefieldStartGame_handler(event:MinefieldEvent):void
		{
			_board.clock.start();
		}
		
		/**
		 * @private
		 * When the minefield recognizes that the game is over, because of winning, this handler function is invoked.
		 * Puts flags over all mine squares.
		 * Draws a face with sunglasses on the button on the board.
		 * Stops the clock display on the board.
		 **/
		private function minefieldWinGame_handler(event:MinefieldEvent):void
		{
			MinesweeperState.getInstance().isWinner = true;
			_minefield.putFlags();
			_board.sunButton.drawReleasedSunButtonWithSunglasses();
			_board.clock.stop();
		}
		
		/**
		 * @private
		 * When the mouse just clicked the minefield, or is outside while pressing, the minefield is resting, so this handler function is invoked.
		 * Draws a happy face on the button of the board.
		 **/
		private function minefieldResting_handler(event:MinefieldEvent):void
		{
			if(MinesweeperState.getInstance().isPlaying && !MinesweeperState.getInstance().isWinner){
				_board.sunButton.drawReleasedHappySunButton();
			}
		}
		
		/**
		 * @private
		 * When the mouse is pressing the squares on the minefield, or the button on the board, this handler function is invoked once.
		 * Draws a surprised face on the button on the board.
		 **/
		private function minefieldSweeping_handler(event:MinefieldEvent):void
		{
			_board.sunButton.drawReleasedSurprisedSunButton();
		}
		
		/**
		 * @private
		 * When the the mouse is out of the minesweeper, this handler function is dispatched.
		 * When the mouse is pressing the minesweeper, and the mouse is out of it, assumess that the mouse is not pressing it.
		 * Sets to false the property isPressing on MinesweeperState singleton.
		 **/
		private function mouseRollOut_handler(event:MouseEvent):void
		{
			MinesweeperState.getInstance().isPressing = false;
		}
		
		/**
		 * @private
		 * When the mouse is up, the mouse is not pressing the minesweeper already, so this method is invoked.
		 * Sets to false the property isPressing on MinesweeperState singleton.
		 **/
		private function mouseUp_handler(event:MouseEvent):void
		{
			MinesweeperState.getInstance().isPressing = false;
		}
		
		/**
		 * @private
		 * When the mouse is down, the monesweeper is pressed, so this method is invoked.
		 * Sets to true the property isPressing on MinesweeperState singleton.
		 **/
		private function mouseDown_handler(event:MouseEvent):void
		{
			MinesweeperState.getInstance().isPressing = true;
		}
		
		/**
		 * @private
		 * When the button on the board is pressed, a new game is requested, so this method is invoked.
		 * Sets to true the property isPlaying on MinesweeperState singleton.
		 * Sets to false the property isPlaying on MinesweeperState singleton.
		 * Resets the minefield.
		 * Resets the clock.
		 * The flag counter display on the board is initialized again.
		 **/
		private function newGame_handler(event:MinefieldEvent):void
		{
			MinesweeperState.getInstance().isPlaying = true;
			MinesweeperState.getInstance().isWinner = false;
			_minefield.reset();
			_board.clock.reset();
			_board.flagCounter.number = _minefield.minesNumber;
		}
		
		/**
		 * @private
		 * When the mouse clicks on a mine, the game is over, so this method is invoked.
		 * Sets to false the property isPlaying on MinesweeperState singleton.
		 * Draws a dead face on the button on the board.
		 * Stops the clock display on the board.
		 **/
		private function minefieldGameOver_handler(event:MinefieldEvent):void
		{
			MinesweeperState.getInstance().isPlaying = false;
			_board.sunButton.drawReleasedDeadSunButton();
			_board.clock.stop();
		}
		
		/**
		 * @private
		 * When the time is up (the clock display on the board arrives to 999), this method is invoked.
		 * minefieldGameOver_handler method is called.
		 * All mine squares on the minefield are opened.
		 **/
		private function timeUp_handler(event:MinefieldEvent)
		{
			minefieldGameOver_handler(event);
			_minefield.openAllMines();
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 * @return Number of button squares for width.
		 **/
		public function get xSize():int
		{
			return _minefield.xSize;
		}
		
		/**
		 * @private
		 * @return Number of button squares for height.
		 **/
		public function get ySize():int
		{
			return _minefield.ySize;
		}
		
		/**
		 * @private
		 * @return Number of mines on the minefield.
		 **/
		public function get minesNumber():int
		{
			return _minefield.minesNumber;
		}
	}
}