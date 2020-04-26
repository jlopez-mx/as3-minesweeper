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
	import minesweeper.events.MinefieldEvent;
	import minesweeper.utils.MinesweeperState;
	
	/**
	 * SunButton class.
	 * Counts the flags that can be used to put above a square.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class SunButton extends Sprite
	{
		/**  @private **/
		private const buttonSize:int = 25;
		/**  @private **/
		private var isPressed:Boolean = false;
		
		public function SunButton()
		{
			initialize();
			addEventListeners();
		}
		
		/**
		 * @private
		 * Initializes the button, drawing a happy face on the button.
		 **/
		private function initialize():void
		{
			drawReleasedHappySunButton();
		}
		
		/**
		 * @private
		 * Adds event listeners to the button.
		 **/
		private function addEventListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, sunButtonMouseDown_handler);
			this.addEventListener(MouseEvent.MOUSE_UP, sunButtonMouseUp_handler);
			this.addEventListener(MouseEvent.MOUSE_OUT, sunButtonMouseOut_handler);
			this.addEventListener(MouseEvent.MOUSE_OVER, sunButtonMouseOver_handler);
		}
		
		////////////////////////////////////////////////////////////////
		/* HANDLERS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * When the mouse is over this button, this handler function is invoked.
		 * If the mouse is pressing, draws a surprised face.
		 **/
		private function sunButtonMouseOver_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing){
				drawPressedSurprisedSunButton();
			}
		}
		
		/**
		 * When the user moves the mouse out if this button, this handler function is invoked.
		 * If user is pressing this button, is still playing (has not lost), and still is not a winner, then draw a happy face on this button.
		 * Or if the user is not playing (has lost), and is not a winner, draw a dead face on this button.
		 * Else, it means that the user has won. So, draws a face with sunglasses on this button. 
		 **/
		private function sunButtonMouseOut_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing){
				if(MinesweeperState.getInstance().isPlaying && !MinesweeperState.getInstance().isWinner){
					drawReleasedHappySunButton();
				}else if(!MinesweeperState.getInstance().isPlaying && !MinesweeperState.getInstance().isWinner){
					drawReleasedDeadSunButton();
				}else{
					drawReleasedSunButtonWithSunglasses();
				}
			}
		}
		
		/**
		 * When the mouse cliks this button, this handler function is invoked.
		 * Draws a happy face on this button and dispatches the event for a new game (MinefieldEvent.NEW_GAME). 
		 **/
		private function sunButtonMouseUp_handler(event:MouseEvent):void
		{
			if(MinesweeperState.getInstance().isPressing){
				MinesweeperState.getInstance().isPressing = false;
				drawReleasedHappySunButton();
				this.dispatchEvent(new MinefieldEvent(MinefieldEvent.NEW_GAME));
			}
		}
		
		/**
		 * When the mouse is pressing this button, this handler function is invoked.
		 * Indicate to the MinesweeperState singleton, that the minesweeper is being pressed.
		 * Draws a surprised face for this button.
		 **/
		private function sunButtonMouseDown_handler(event:MouseEvent):void
		{
			MinesweeperState.getInstance().isPressing = true;
			drawPressedSurprisedSunButton();
		}
		
		////////////////////////////////////////////////////////////////
		/* PUBLIC FUNCTIONS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * Draws a button with a happy face on it.
		 **/
		public function drawReleasedHappySunButton():void
		{
			drawSunButton();
			drawHappySun();
		}
		
		/**
		 * Draws a button with a surprised face on it.
		 **/
		public function drawReleasedSurprisedSunButton():void
		{
			drawSunButton();
			drawSurprisedSun();
		}
		
		/**
		 * Draws a button with a dead face on it.
		 **/
		public function drawReleasedDeadSunButton():void
		{
			drawSunButton();
			drawDeadSun();
		}
		
		/**
		 * Draws a pressed button with a happy face on it.
		 **/
		public function drawPressedHappySunButton():void
		{
			drawPressedSunButton();
			drawHappySun();
		}
		
		/**
		 * Draws a button with a face with sunglasses on it.
		 **/
		public function drawReleasedSunButtonWithSunglasses():void
		{
			drawSunButton();
			drawSunglassesSun();
		}
		
		/**
		 * Draws a pressed button with a surprised face on it.
		 **/
		public function drawPressedSurprisedSunButton():void
		{
			drawPressedSunButton();
			drawSurprisedSun();
		}
		
		////////////////////////////////////////////////////////////////
		/* PRIVATE FUNCTIONS */
		////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 * Draws a happy face.
		 **/
		private function drawHappySun():void
		{
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0xFFFA3C);
			this.graphics.drawCircle(13,13,8);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.drawCircle(10,11,1);
			this.graphics.drawCircle(16,11,1);
			this.graphics.endFill();
			
			this.graphics.moveTo(9,15);
			this.graphics.curveTo(13,19,17,15);
		}
		
		/**
		 * @private
		 * Draws a face with sunglasses.
		 **/
		private function drawSunglassesSun():void
		{
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0xFFFA3C);
			this.graphics.drawCircle(13,13,8);
			this.graphics.endFill();
			
			this.graphics.lineStyle(0,0x000000, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.moveTo(8.5,10);
			this.graphics.curveTo(9.5,16,12.5,10);
			this.graphics.moveTo(13.5,10);
			this.graphics.curveTo(16.5,16,17.5,10);
			this.graphics.endFill();
			
			this.graphics.moveTo(5,13);
			this.graphics.lineTo(8.5, 10);
			this.graphics.lineTo(17.5, 10);
			this.graphics.lineTo(21, 13);
			
			this.graphics.moveTo(9,16);
			this.graphics.curveTo(13,19,17,16);
		}
		
		/**
		 * @private
		 * Draws a dead face.
		 **/
		private function drawDeadSun():void
		{
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0xFFFA3C);
			this.graphics.drawCircle(13,13,8);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.moveTo(8.5,9.5);
			this.graphics.lineTo(11.5, 12.5);
			this.graphics.moveTo(11.5,9.5);
			this.graphics.lineTo(8.5, 12.5);
			
			this.graphics.moveTo(14.5,9.5);
			this.graphics.lineTo(17.5, 12.5);
			this.graphics.moveTo(17.5,9.5);
			this.graphics.lineTo(14.5, 12.5);

			this.graphics.moveTo(9,17.5);
			this.graphics.curveTo(13,13.5,17,17.5);
		}
		
		/**
		 * @private
		 * Draws a surprised face.
		 **/
		private function drawSurprisedSun():void
		{
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0xFFFA3C);
			this.graphics.drawCircle(13,13,8);
			this.graphics.endFill();
			
			this.graphics.lineStyle(1,0x000000, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.drawCircle(10,11,1);
			this.graphics.drawCircle(16,11,1);
			this.graphics.endFill();
			
			this.graphics.moveTo(9,15);
			this.graphics.lineStyle(0,0x000000, 1);
			this.graphics.beginFill(0xFFFA3C);
			this.graphics.drawCircle(13,16,1.5);
			this.graphics.endFill();
		}
		
		/**
		 * @private
		 * Draws released button.
		 **/
		private function drawSunButton():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(buttonSize, 0);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(buttonSize, buttonSize);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(0, buttonSize);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
		/**
		 * @private
		 * Draws pressed button.
		 **/
		private function drawPressedSunButton():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.beginFill(0xC0C0C0);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(buttonSize, 0);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(buttonSize, buttonSize);
			this.graphics.lineStyle(2, 0xFFFFFF, 1);
			this.graphics.lineTo(0, buttonSize);
			this.graphics.lineStyle(2, 0x808080, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
	}
}