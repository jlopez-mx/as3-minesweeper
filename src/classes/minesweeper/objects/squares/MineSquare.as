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
	import flash.events.MouseEvent;
	
	/**
	 * MineSquare class.
	 * Creates a button square object that shows a number when is clicked, or dissapear when is clicked if it has not a number to show. 
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class MineSquare extends BasicSquare
	{
		/**
		 * Constructor.
		 * 
		 * Calls the super constructor.
		 **/
		public function MineSquare()
		{
			super();
		}
		
		/**
		 * Draws a red background for this square that has a mine. 
		 **/
		private function drawRedBackground():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(0, 0x808080, 1);
			this.graphics.beginFill(0xFF0000);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(20, 0);
			this.graphics.lineTo(20, 20);
			this.graphics.lineTo(0, 20);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		/**
		 * Draws a red X for this square that has a mine.
		 **/
		private function drawRedX():void
		{
			this.graphics.lineStyle(2, 0xFF0000, 1);
			this.graphics.moveTo(2, 3);
			this.graphics.lineTo(18, 18);
			this.graphics.moveTo(18, 3);
			this.graphics.lineTo(2, 18);
		}
		
		/**
		 * Draws a mine.
		 **/
		private function drawMine():void
		{
			this.graphics.lineStyle(0, 0x000000, 1);
			this.graphics.beginFill(0x000000,1);
			this.graphics.drawCircle(10,10,4);
			
			this.graphics.moveTo(10, 3);
			this.graphics.lineTo(10, 17);
			this.graphics.moveTo(3, 10);
			this.graphics.lineTo(17, 10);
			
			this.graphics.moveTo(5, 6);
			this.graphics.lineTo(15, 15);
			this.graphics.moveTo(15, 6);
			this.graphics.lineTo(5, 15);
			
			this.graphics.moveTo(10,10);
			this.graphics.lineStyle(0, 0xFFFFFF, 1);
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(8, 8, 1, 1);
		}
		
		////////////////////////////////////////////////////////////////
		/* PUBLIC METHODS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * Draws this button square opened with a mine on it.
		 **/
		public function openMine():void
		{
			if(!_isClicked){
				releaseButton();
				drawMine();
			}
		}
		
		/**
		 * Open this square that has a mine and a flag.
		 * So, draws a normal background (dark gray), a mine, and a red X.
		 **/
		public function openMineWithFlag():void
		{
			if(!_isClicked){
				releaseButton();
				drawMine();
				drawRedX();
			}
		}
		
		/**
		 * If this button square is not already clicked, indicates that this button square is clicked and opens it.
		 * So, draws a red background and a mine on it.
		 * Also, dispatches a MOUSE_UP event (simulating that it has been clicked).
		 **/
		public override function doClick():void{
			super.doClick();
			drawRedBackground();
			drawMine();
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS & SETTERS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * @return Boolean value that indicates that this button square has a mine.
		 **/
		public override function get hasMine():Boolean{ return true; }
	}
}