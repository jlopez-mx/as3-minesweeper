/**
 * VERSION: 1.0
 * DATE: 24-02-2011
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
	import flash.geom.Point;
	import minesweeper.events.MinefieldEvent;
	import minesweeper.objects.squares.BasicSquare;
	import minesweeper.objects.squares.MineSquare;
	import minesweeper.objects.squares.NumberSquare;
	import minesweeper.utils.MinesweeperState;
	
	/**
	 * Minefield class.
	 * Minefield object that contains all the button squares.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Minefield extends Sprite
	{
		/** Number of squares for width. **/
		private var _xSize:int;
		/** Number of squares for heigth. **/
		private var _ySize:int;
		/** Number of mines on the minefield. **/
		private var _minesNumber;
		
		/** Bidimensional array that contains all the button squares that creates the minefield. **/
		private var _minefieldArray:Array;
		/** Array that contains the positions (x and y) of the button squares on the minefield that must have a mine. **/
		private var _minesPositions:Array;
		
		/** Counter of the button squares on the minefield that has not been clicked. **/
		private var _squaresLeft:int;
		/** Current button square that is under the mouse. **/
		private var _mouseOverSquare:BasicSquare;
		/** Indicates if it is the first click on the minefield. **/
		private var _isFisrtClick:Boolean = true;
		
		/** @private **/
		private const _squareSeparation:int = 22;
		/** @private **/
		private const _minefieldSeparation:int = 3;
		
		/**
		 * Constructor.
		 * 
		 * Before create all the button squares on the minefield, assures that the minefield has less than 60% of mines on it.
		 * If the mines are more than that, throws an error and stops all program.
		 * If not, initializes all the minefield.
		 **/
		public function Minefield(xSize:int, ySize:int, minesNumber:int)
		{
			if(minesNumber/(xSize*ySize) > 0.60){
				throw new Error("Too many mines :(!... Try to cover with mines less than 60% of the minefield.");
			}else{
				_xSize = xSize;
				_ySize = ySize;
				_minesNumber = minesNumber;
				
				initializeArrays();
				drawMinefield();
				generateRandomMinesPositions();
				createRandomMines();
				createNumberSquares();
				setNumbersToSquares(_minesPositions, true);
				positionSquares();
				addEventListeners()
				addSquaresEventListeners();
			}
		}
		
		/**
		 * Initializes all the positions of the bidimensional array _minefieldArray for the button squares, and fills it with null value.
		 * Also, initializes the aray that contains the positions of the mines in the minefield.
		 **/
		private function initializeArrays():void
		{
			_minesPositions = new Array(_minesNumber);
			_minefieldArray = new Array(_ySize);
			
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				_minefieldArray[i] = new Array(_xSize);
				for(var j:int = 0; j < _minefieldArray[i].length; j++){
					_minefieldArray[i][j] = null;
				}
			}
		}
		
		/**
		 * Draws the rectangle that is surrounding all the button squares.
		 **/
		private function drawMinefield():void
		{
			const minefieldWidth:int = _xSize * _squareSeparation;
			const minefieldHeigth:int = _ySize * _squareSeparation;
			
			this.graphics.clear();
			this.graphics.lineStyle(3, 0x808080, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(minefieldWidth + _minefieldSeparation + 1, 0);
			this.graphics.lineStyle(3, 0xFFFFFF, 1);
			this.graphics.lineTo(minefieldWidth + _minefieldSeparation + 1, minefieldHeigth + _minefieldSeparation + 1);
			this.graphics.lineStyle(3, 0xFFFFFF, 1);
			this.graphics.lineTo(0, minefieldHeigth + _minefieldSeparation + 1);
			this.graphics.lineStyle(3, 0x808080, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		/**
		 * Fills the _minesPositions array with unique mine positions.
		 * The positions are Objects with xPos and yPos properties.
		 **/
		private function generateRandomMinesPositions():void
		{
			for (var i:int = 0; i < _minesPositions.length; i++)
			{
				_minesPositions[i] = uniqueMinePosition();
			}
		}
		
		/**
		 * Uses the positions saved in _minesPositions array to create MineSquare objects in the bidimensional array _minefieldArray.
		 * The positions are Objects in _minesPositions array, with xPos and yPos properties.
		 **/
		private function createRandomMines():void
		{
			for (var i:int = 0; i < _minesPositions.length; i++)
			{
				var element:Object = _minesPositions[i] as Object;
				_minefieldArray[element.yPos][element.xPos] = new MineSquare();
			}
		}
		
		/**
		 * Fills the bidimensional array _minefieldArray with NumberSquares objects on each position that does not have a MineSquare object (it's null).
		 * And initializes the _squaresLeft number, that indicates how many squares are left to click.
		 **/
		private function createNumberSquares():void
		{
			_squaresLeft = _xSize * _ySize;
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				for (var j:int = 0; j < _minefieldArray[i].length; j++)
				{
					if(_minefieldArray[i][j] == null){
						_minefieldArray[i][j] = new NumberSquare();
					}
				}
			}
		}
		
		/**
		 * Sets the corresponding number that must be surrounding a MineSquare object.
		 * @param minesArray Array that contains the positions of the mineSquares. This helps to calculate all the surrounding button squares of these mineSquares and set the corresponding number to it.
		 * @param sumNumbers Boolean that indicates if all the surrounding button squares of the position indicated in the minesArray parameter, should sum 1 or minus 1. Set true for sum, or false for minus.
		 **/
		private function setNumbersToSquares(minesArray:Array, sumNumbers:Boolean):void
		{
			if(sumNumbers){
				for (var i:int = 0; i < minesArray.length; i++)
				{
					var element:Object = minesArray[i] as Object;
					
					if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos >= 1 && element.xPos <= _xSize-2){
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number++;
					}else if(element.xPos >= 1 && element.xPos <= _xSize-2 && element.yPos == 0){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
					}else if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
					}else if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos == _xSize-1){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
					}else if(element.xPos >= 1 && element.xPos <= _xSize-2 && element.yPos == _ySize-1){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
					}else if(element.xPos == _xSize-1 && element.yPos == 0){
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
					}else if(element.yPos == _ySize-1 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
					}else if(element.yPos == 0 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number++;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number++;
					}else{
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number++;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number++;
					}
				}
			}else{
				for (i = 0; i < minesArray.length; i++)
				{
					element = minesArray[i] as Object;
					
					if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos >= 1 && element.xPos <= _xSize-2){
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number--;
					}else if(element.xPos >= 1 && element.xPos <= _xSize-2 && element.yPos == 0){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
					}else if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number--;
					}else if(element.yPos >= 1 && element.yPos <= _ySize-2 && element.xPos == _xSize-1){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number++;
					}else if(element.xPos >= 1 && element.xPos <= _xSize-2 && element.yPos == _ySize-1){
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
					}else if(element.xPos == _xSize-1 && element.yPos == 0){
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
					}else if(element.yPos == _ySize-1 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
					}else if(element.yPos == 0 && element.xPos == 0){
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos]).number--;
						BasicSquare(_minefieldArray[element.yPos+1][element.xPos+1]).number--;
						BasicSquare(_minefieldArray[element.yPos][element.xPos+1]).number--;
					}else{
						BasicSquare(_minefieldArray[element.yPos][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos-1]).number--;
						BasicSquare(_minefieldArray[element.yPos-1][element.xPos]).number--;
					}
				}
			}
		}
		
		/**
		 * Positions in the stage all the button squares in the bidimensional array _minefieldArray.
		 **/
		private function positionSquares():void
		{
			var xPos:int = _minefieldSeparation;
			var yPos:int = _minefieldSeparation;
			
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				for (var j:int = 0; j < _minefieldArray[i].length; j++)
				{
					if(j != 0){
						xPos += _squareSeparation;
					}
					_minefieldArray[i][j].x = xPos;
					_minefieldArray[i][j].y = yPos;
					this.addChild(_minefieldArray[i][j]);
				}
				xPos = _minefieldSeparation;
				yPos += _squareSeparation;
			}
		}
		
		/**
		 * Adds the event listeners for this minefield.
		 **/
		private function addEventListeners():void
		{			
			this.addEventListener(MouseEvent.MOUSE_DOWN, minefieldMouseDown_handler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, minefieldMouseUp_handler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, minefieldMouseOut_handler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, minefieldMouseOver_handler, false, 0, true);
		}
		
		/**
		 * Adds the event listeners for each button square on the minefield.
		 **/
		private function addSquaresEventListeners():void
		{			
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				for (var j:int = 0; j < _minefieldArray[i].length; j++)
				{
					_minefieldArray[i][j].addEventListener(MouseEvent.MOUSE_DOWN, squareMouseDown_handler, false, 0, true);
					_minefieldArray[i][j].addEventListener(MouseEvent.MOUSE_UP, squareMouseUp_handler, false, 0, true);
					_minefieldArray[i][j].addEventListener(MouseEvent.MOUSE_OUT, squareMouseOut_handler, false, 0, true);
					_minefieldArray[i][j].addEventListener(MouseEvent.MOUSE_OVER, squareMouseOver_handler, false, 0, true);
				}
			}
		}
		
		/**
		 * Removes the event listeners for each button square on the minefield.
		 * Also, removes the button squares from the stage, and sets the space in the bidimensional array for the button squares with null.
		 **/
		private function removeSquaresEventListeners():void
		{		
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				for (var j:int = 0; j < _minefieldArray[i].length; j++)
				{
					this.removeChild(_minefieldArray[i][j]);
					_minefieldArray[i][j].removeEventListener(MouseEvent.MOUSE_DOWN, squareMouseDown_handler);
					_minefieldArray[i][j].removeEventListener(MouseEvent.MOUSE_UP, squareMouseUp_handler);
					_minefieldArray[i][j].removeEventListener(MouseEvent.MOUSE_OUT, squareMouseOut_handler);
					_minefieldArray[i][j].removeEventListener(MouseEvent.MOUSE_OVER, squareMouseOver_handler);
					_minefieldArray[i][j] = null;
				}
			}
		}
		
		/**
		 * Removes event listeners for a single square
		 * @param pos Object with xPos and yPos properties, indicating the position of the button square in the bidimensional array, to remove listeners. 
		 **/
		private function removeSingleSquareEventListeners(pos:Object):void
		{
			this.removeChild(_minefieldArray[pos.yPos][pos.xPos]);
			_minefieldArray[pos.yPos][pos.xPos].removeEventListener(MouseEvent.MOUSE_DOWN, squareMouseDown_handler);
			_minefieldArray[pos.yPos][pos.xPos].removeEventListener(MouseEvent.MOUSE_UP, squareMouseUp_handler);
			_minefieldArray[pos.yPos][pos.xPos].removeEventListener(MouseEvent.MOUSE_OUT, squareMouseOut_handler);
			_minefieldArray[pos.yPos][pos.xPos].removeEventListener(MouseEvent.MOUSE_OVER, squareMouseOver_handler);
			_minefieldArray[pos.yPos][pos.xPos] = null;
		}
		
		/**
		 * Adds event listeners to a single square.
		 * @param pos Object with xPos and yPos properties, indicating the position of the button square in the bidimensional array, to add listeners.
		 **/
		private function addSingleSquareEventListeners(pos:Object):void
		{
			_minefieldArray[pos.yPos][pos.xPos].addEventListener(MouseEvent.MOUSE_DOWN, squareMouseDown_handler, false, 0, true);
			_minefieldArray[pos.yPos][pos.xPos].addEventListener(MouseEvent.MOUSE_UP, squareMouseUp_handler, false, 0, true);
			_minefieldArray[pos.yPos][pos.xPos].addEventListener(MouseEvent.MOUSE_OUT, squareMouseOut_handler, false, 0, true);
			_minefieldArray[pos.yPos][pos.xPos].addEventListener(MouseEvent.MOUSE_OVER, squareMouseOver_handler, false, 0, true);
			this.addChild(_minefieldArray[pos.yPos][pos.xPos]);
		}
		
		/**
		 * Opens all adjacent button squares by simulating a click on it.
		 * This called recursivelly, creates a 'cascade opening' of all the button squares that does not have a number on it.
		 **/
		private function openAdjacentSquares(position:Object):void
		{
			var xPos:int = position.xPos;
			var yPos:int = position.yPos;
			
			if(xPos >= 1 && xPos <= _xSize-2 && yPos >= 1 && yPos <= _ySize-2){//Center
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos+1]).hasFlag){//Bottom right
					BasicSquare(_minefieldArray[yPos+1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();	
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos-1]).hasFlag){//Bottom left
					BasicSquare(_minefieldArray[yPos+1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos-1]).hasFlag){//Upper left
					BasicSquare(_minefieldArray[yPos-1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}	
				if(!BasicSquare(_minefieldArray[yPos-1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos+1]).hasFlag){//Upper right
					BasicSquare(_minefieldArray[yPos-1][xPos+1]).doClick();
				}
			}else if(xPos >= 1 && xPos <= _xSize-2 && yPos == 0){//Top
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();	
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos+1]).hasFlag){//Bottom right
					BasicSquare(_minefieldArray[yPos+1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos-1]).hasFlag){//Bottom left
					BasicSquare(_minefieldArray[yPos+1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
			}else if(xPos >= 1 && xPos <= _xSize-2 && yPos == _ySize-1){//Bottom
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos+1]).hasFlag){//Upper right
					BasicSquare(_minefieldArray[yPos-1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos-1]).hasFlag){//Upper left
					BasicSquare(_minefieldArray[yPos-1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
			}else if(yPos >= 1 && yPos <= _ySize-2 && xPos == 0){//Left
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos+1]).hasFlag){//Upper right
					BasicSquare(_minefieldArray[yPos-1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos+1]).hasFlag){//Bottom right
					BasicSquare(_minefieldArray[yPos+1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();
				}
			}else if(yPos >= 1 && yPos <= _ySize-2 && xPos == _xSize-1){//Right
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos-1]).hasFlag){//Bottom left
					BasicSquare(_minefieldArray[yPos+1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos-1]).hasFlag){//Top left
					BasicSquare(_minefieldArray[yPos-1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}
			}else if(xPos == 0 && yPos == 0){//Upper left corner
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos+1]).hasFlag){//Bottom right
					BasicSquare(_minefieldArray[yPos+1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();
				}
			}else if(xPos == _xSize-1 && yPos == 0){//Upper right corner
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos-1]).hasFlag){//Bottom left
					BasicSquare(_minefieldArray[yPos+1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos+1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos+1][xPos]).hasFlag){//Bottom
					BasicSquare(_minefieldArray[yPos+1][xPos]).doClick();
				}
			}else if(xPos == 0 && yPos == _ySize-1){//Bottom left corner
				if(!BasicSquare(_minefieldArray[yPos][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos+1]).hasFlag){//Right
					BasicSquare(_minefieldArray[yPos][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos+1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos+1]).hasFlag){//Upper right
					BasicSquare(_minefieldArray[yPos-1][xPos+1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}
			}else{//Bottom right corner
				if(!BasicSquare(_minefieldArray[yPos][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos][xPos-1]).hasFlag){//Left
					BasicSquare(_minefieldArray[yPos][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos-1]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos-1]).hasFlag){//Upper left
					BasicSquare(_minefieldArray[yPos-1][xPos-1]).doClick();
				}
				if(!BasicSquare(_minefieldArray[yPos-1][xPos]).isClicked && !BasicSquare(_minefieldArray[yPos-1][xPos]).hasFlag){//Upper
					BasicSquare(_minefieldArray[yPos-1][xPos]).doClick();
				}
			}
		}
		
		/**
		 * This function is to know the position of a certain button square object (BasicSquare) in the bidimensional array _minefieldArray.
		 * @param square BasicSquare object that is passed to know its index in the bidimensional array _minefieldArray.
		 * @return Object with the parameters xPos and yPos, that indicates a position in the bidimensional array _minefieldArray.
		 **/
		private function indexOfSquare(square:BasicSquare):Object
		{
			for (var i:int = 0; i < _minefieldArray.length; i++)
			{
				var n = _minefieldArray[i].indexOf(square);
				if(n >= 0){
					var pos:Object = new Object();
					pos.xPos = n;
					pos.yPos = i;
					return pos;
				}
			}
		}
		
		/**
		 * This function creates and returns a UNIQUE Object with the properties xPos and yPos
		 * @return Object with the properties xPos and yPos, that indicates a UNIQUE position in the bidimensional array _minefieldArray.
		 **/
		private function uniqueMinePosition():Object
		{
			var randomPosition:Object = new Object();
			randomPosition.xPos = Math.round(Math.random()*(_xSize-1));
			randomPosition.yPos = Math.round(Math.random()*(_ySize-1));
			
			var repeats:Boolean = false;
			
			for (var i:int = 0; i < _minesPositions.length; i++)
			{
				var element:Object = _minesPositions[i] as Object;
				if(element != null){
					if(element.xPos == randomPosition.xPos && element.yPos == randomPosition.yPos){
						repeats = true;
					}
				}
			}
			if(repeats){
				return uniqueMinePosition();
			}else{
				return randomPosition;
			}
		}
		
		////////////////////////////////////////////////////////////////
		/* PUBLIC METHODS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * Puts flags on all MineSquares in the minefield.
		 * This method is invoked when the user wins the game. 
		 **/
		public function putFlags():void
		{
			for(var i:int = 0; i < _minesPositions.length; i++){
				var element:Object = _minesPositions[i] as Object;
				BasicSquare(_minefieldArray[element.yPos][element.xPos]).putFlag();
			}
		}
		
		/**
		 * Resets this minefield.
		 * This is invoked when the button with a face on it on the board is clicked to start a new game.
		 **/
		public function reset():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = true;
			removeSquaresEventListeners();
			generateRandomMinesPositions();
			createRandomMines();
			createNumberSquares();
			setNumbersToSquares(_minesPositions, true);
			positionSquares();
			addSquaresEventListeners();
			_isFisrtClick = true;
		}
		
		/**
		 * Puts a flag on the current button square that is under the mouse.
		 **/
		public function putFlagOnCurrentSquare():void{
			if(_mouseOverSquare != null){
				BasicSquare(_mouseOverSquare).putFlag();
			}
		}
		
		/**
		 * Deletes the flag on the current button square that is under the mouse.
		 **/
		public function deleteFlagOnCurrentSquare():void{
			if(_mouseOverSquare != null){
				BasicSquare(_mouseOverSquare).reDrawButton();
			}
		}
		
		/**
		 * An Object with xPos and yPos properties are passed, and returns the position in the _minesPositions where is an equivalent Object (with the same properties values).
		 * @return Number that indicates the position in the _minesPositions where is an equivalent Object (with the same properties values).
		 **/
		public function indexOfMinesArray(posObject:Object):int
		{
			for (var i:int = 0; i < _minesPositions.length; i++)
			{
				if(Object(_minesPositions[i]).xPos == posObject.xPos && Object(_minesPositions[i]).yPos == posObject.yPos){
					return i;
				}
			}
		}
		
		/**
		 * Open all button squares that have a mine.
		 * Disables all mouse events on this minefield.
		 * And also, dispatches a GAME_OVER event, to indicate that the game is over.
		 **/
		public function openAllMines():void
		{
			for (var i:int = 0; i < _minesPositions.length; i++)
			{
				var element:Object = _minesPositions[i] as Object;
				if(!MineSquare(_minefieldArray[element.yPos][element.xPos]).hasFlag){
					MineSquare(_minefieldArray[element.yPos][element.xPos]).openMine();
				}else{
					MineSquare(_minefieldArray[element.yPos][element.xPos]).openMineWithFlag();
				}
			}
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.GAME_OVER));
		}
		
		/**
		 * Disables all mouse interaction with this minefield.
		 * And dispatches a WIN_GAME event, to indicate that the user is already a winner.
		 **/
		public function winGame():void
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.WIN_GAME));
		}
		
		/**
		 * When the user clicks the minefield for the first time in a new game, starts the game.
		 * So, this function is invoked to set _isFisrtClick boolean to false.
		 * And dispatches a START_GAME event, to indicate that the user started playing.
		 **/
		public function startGame():void
		{
			_isFisrtClick = false;
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.START_GAME));
		}
		
		////////////////////////////////////////////////////////////////
		/* HANDLERS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * When the mouse is pressing the minefield, this handler function is invoked.
		 * Dispatches a SWEEPING event, to indicate that the user is sweeping for mines in the minefield.
		 **/
		private function minefieldMouseDown_handler(event:MouseEvent):void
		{
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.SWEEPING));
		}
		
		/**
		 * When the mouse is up, the mouse is not pressing the minefield already, so this handler function is invoked.
		 * Dispatches a RESTING event, to indicate that the mouse is not pressing the minefield already.
		 **/
		private function minefieldMouseUp_handler(event:MouseEvent):void
		{
			this.dispatchEvent(new MinefieldEvent(MinefieldEvent.RESTING));
		}
		
		/**
		 * When the mouse is out of the minefield, this handler function is invoked.
		 * Indicates that the mouse is NOT over the minefield, setting to null _mouseOverSquare (variable that points to the button square that is under the mouse).
		 * Also, if the mouse is still pressing the Minesweeper, but not pressing the minefield, dispatches a RESTING event, to indicate that the mouse is resting of pressing the minefield.
		 * Knowing if is resting or not, is useful to change the face of the button in the board.
		 **/
		private function minefieldMouseOut_handler(event:MouseEvent):void
		{
			_mouseOverSquare = null;
			if(MinesweeperState.getInstance().isPressing){
				this.dispatchEvent(new MinefieldEvent(MinefieldEvent.RESTING));
			}
		}
		
		/**
		 * When the mouse is over the minefield, this handler function is invoked.
		 * If the mouse is over the minefield, and is pressing, it means that the user is sweeping for mines on the minefield.
		 * So, a SWEEPING event is dispatched to indicate it.
		 **/
		private function minefieldMouseOver_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing){
				this.dispatchEvent(new MinefieldEvent(MinefieldEvent.SWEEPING));
			}
		}
		
		/**
		 * When the mouse is over a button square of the minefield, this handler function is invoked.
		 * The current button square that is under the mouse, is indicated in the _mouseOverSquare variable.
		 * If while the current button square under the mouse is being pressed, and has not a flag, then draws the button square being pressed.
		 **/
		private function squareMouseOver_handler(event:MouseEvent):void
		{
			_mouseOverSquare = BasicSquare(event.target);
			if(MinesweeperState.getInstance().isPressing && !BasicSquare(event.target).hasFlag){
				BasicSquare(event.target).pressButton();
			}
		}
		
		/**
		 * When the mouse is out of a button square, this handler function is invoked.
		 * If the mouse is out of a button square, and has no flag while is still pressing the minefield, that button square must be drawn again as not pressed. 
		 **/
		private function squareMouseOut_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing && !BasicSquare(event.target).hasFlag){
				BasicSquare(event.target).reDrawButton();
			}
		}
		
		/**
		 * When the mouse clicks on a button square on the minefield, this handler function is invoked.
		 * If the MinesweeperState isPressing property is set to true, it means that the user made a real click on a button square.
		 * If not, it means, that the click on the current button square, was simulated with the doClick() method of the BasicSquare interface.
		 **/
		private function squareMouseUp_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing){//It means that this is a real click on a button square.
				MinesweeperState.getInstance().isPressing = false;
				if(!BasicSquare(event.target).hasFlag){
					/*
					If this button square has a mine, and it is the first click on the minefield, and do not have a flag,
					moves the mine to another random position, and transforms the current button square, to a number square.
					This is made to prevent loosing at the first click. 
					*/
					if(BasicSquare(event.target).hasMine){
						if(_isFisrtClick){
							
							//Remove MineSquare and convert to NumberSquare
							var minePoint:Point = new Point(MineSquare(event.target).x, MineSquare(event.target).y);
							var mineNumber:int = BasicSquare(event.target).number;
							var arrayPos:Object = indexOfSquare(BasicSquare(event.target));
							var mineArrayPos:int = indexOfMinesArray(arrayPos);
							removeSingleSquareEventListeners(arrayPos);
							_minefieldArray[arrayPos.yPos][arrayPos.xPos] = new NumberSquare();
							NumberSquare(_minefieldArray[arrayPos.yPos][arrayPos.xPos]).x = minePoint.x;
							NumberSquare(_minefieldArray[arrayPos.yPos][arrayPos.xPos]).y = minePoint.y;
							NumberSquare(_minefieldArray[arrayPos.yPos][arrayPos.xPos]).number = mineNumber;
							addSingleSquareEventListeners(arrayPos);
							var newSquare:Array = new Array();
							newSquare[0] = arrayPos;
							setNumbersToSquares(newSquare, false);
							
							//Create a random position for a new MineSquare, remove NumberSquare on that position, and add new MineSquare
							_minesPositions[mineArrayPos] = uniqueMinePosition();
							var newMineSquarePos:Object = _minesPositions[mineArrayPos];
							var oldSquarePoint:Point = new Point(NumberSquare(_minefieldArray[newMineSquarePos.yPos][newMineSquarePos.xPos]).x, NumberSquare(_minefieldArray[newMineSquarePos.yPos][newMineSquarePos.xPos]).y);
							removeSingleSquareEventListeners(newMineSquarePos);
							_minefieldArray[newMineSquarePos.yPos][newMineSquarePos.xPos] = new MineSquare();
							MineSquare(_minefieldArray[newMineSquarePos.yPos][newMineSquarePos.xPos]).x = oldSquarePoint.x;
							MineSquare(_minefieldArray[newMineSquarePos.yPos][newMineSquarePos.xPos]).y = oldSquarePoint.y;
							var newMine:Array = new Array();
							newMine[0] = newMineSquarePos;
							setNumbersToSquares(newMine, true);
							addSingleSquareEventListeners(newMineSquarePos);
							
							var newNumberSquare:BasicSquare = BasicSquare(_minefieldArray[arrayPos.yPos][arrayPos.xPos]);
							startGame();
							newNumberSquare.doClick();
							
							if(newNumberSquare.number == 0){
								openAdjacentSquares(indexOfSquare(newNumberSquare));
							}
							if(_squaresLeft == _minesNumber){
								winGame();
							}
						}else{// If current button square has a mine, and is not the first click.
							_squaresLeft++;
							BasicSquare(event.target).doClick();
							openAllMines();
						}
					}else{// If the current button square has not a mine.
						
						// Simulate a click on it.
						BasicSquare(event.target).doClick();
						
						// If its number is 0, calls recursively openAdjacentSquares function, to open all adjacents button squares, simulating a click on them.
						if(BasicSquare(event.target).number == 0){
							openAdjacentSquares(indexOfSquare(BasicSquare(event.target)));
						}
						
						// If it is first click, just starts the game
						if(_isFisrtClick){
							startGame();
						}
						
						// If the only ones button square left are mines, it means that the user won. 
						if(_squaresLeft == _minesNumber){
							winGame();
						}
					}
				}
			}else{
				//It means, that the click on the current button square, was simulated with the doClick() method of the BasicSquare interface.
				if(!BasicSquare(event.target).hasFlag){
					_squaresLeft--;
					if(BasicSquare(event.target).number == 0 && !BasicSquare(event.target).hasMine){
						openAdjacentSquares(indexOfSquare(BasicSquare(event.target)));
					}
					if(_squaresLeft == _minesNumber){
						winGame();
					}
				}
			}
		}
		
		/**
		 * When the mouse is pressing a button square in the minefield, this handler function is invoked.
		 * If the current button square being pressed has not a flag, indicates that the minesweeper is being pressed, setting to true the property of the MinesweeperState singleton.
		 * And also, draws the current button square as being pressed.
		 **/
		private function squareMouseDown_handler(event:MouseEvent):void
		{
			if(!BasicSquare(event.target).hasFlag){
				MinesweeperState.getInstance().isPressing = true;
				BasicSquare(event.target).pressButton();
			}
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * @return Boolean that indicates if the current button square that is under the mouse, has flag.
		 **/
		public function get mouseOverSquareHasFlag():Boolean{
			if(_mouseOverSquare != null){
				return _mouseOverSquare.hasFlag;
			}else{
				return false;
			}
		}
		
		/**
		 * @return Boolean that indicates if the mouse is over any button square of the minefield.
		 **/
		public function get isMouseOver():Boolean{
			if(_mouseOverSquare != null){
				return true;
			}else{
				return false;
			}
		}
		
		/**
		 * @return Number of button squares for width.
		 **/
		public function get xSize():int{
			return _xSize;
		}
		
		/**
		 * @return Number of button squares for height.
		 **/
		public function get ySize():int{
			return _ySize;
		}
		
		/**
		 * @return Number of mines in the minefield.
		 **/
		public function get minesNumber():int{
			return _minesNumber;
		}
		
		/**
		 * @return Boolean that indicates if it is the first click on the minefield, on the current game.
		 **/
		public function get isFirstClick():Boolean{
			return _isFisrtClick;
		}
	}
}