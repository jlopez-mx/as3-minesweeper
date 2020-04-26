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
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Display class
	 * Counts the flags that can be used to put above a square.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Display extends Sprite
	{
		/**
		 * EMBEBED FONT INFO:
		 * By Sizenko Alexander
		 * http://www.dafont.com/digital-7.font
		 * http://www.styleseven.com
		 * Please read the 'Readme (digital-7).txt' file on 'assets' directory.
		 **/ 
		[Embed(source="../../../assets/digital-7 (mono).TTF", fontName="watchFont_embedded", fontStyle="normal", fontWeight="normal", embedAsCFF="false", unicodeRange="U+0030-U+0039")]
		/** Class registered for the embed font. **/
		private var WatchFont_embedded:Class;
		
		/** Textfield where the numbers of the display are shown. **/
		protected var displayNumbers_txt:TextField = new TextField();
		/** Textfield that shows the number '888', just to simulate a shadow for the numbers of the display. **/
		protected var shadowNumbers_txt:TextField = new TextField();
		/**  TextFormat for the numbers shown on the display. **/
		private var displayTextFormat:TextFormat = new TextFormat();
		/**  TextFormat for the shadow of the numbers of the display. **/
		private var shadowTextFormat:TextFormat = new TextFormat();
		
		/**
		 * Constructor.
		 * 
		 * Draws the display.
		 * Initialize the TextFields and the TextFormats and adds it to the stage.
		 **/
		public function Display()
		{
			drawDisplay();
			initialize();
		}
		/**
		 * Initialize the TextFields and the TextFormats.
		 * Position them.
		 * Adds them to the stage.
		 **/
		private function initialize():void
		{
			displayTextFormat.font = "watchFont_embedded";
			displayTextFormat.color = 0xFF0000;
			displayTextFormat.size = 30;
			displayTextFormat.letterSpacing = 2;
			
			shadowTextFormat.font = displayTextFormat.font;
			shadowTextFormat.color = displayTextFormat.color;
			shadowTextFormat.size = displayTextFormat.size;
			shadowTextFormat.letterSpacing = displayTextFormat.letterSpacing;
			shadowNumbers_txt.alpha = 0.4;
			
			displayNumbers_txt.embedFonts = true;
			displayNumbers_txt.defaultTextFormat = displayTextFormat;
			displayNumbers_txt.height = displayTextFormat.size;
			displayNumbers_txt.selectable = false;
			displayNumbers_txt.x = 1;
			displayNumbers_txt.y = -4;
			displayNumbers_txt.text = "000";
			
			shadowNumbers_txt.embedFonts = displayNumbers_txt.embedFonts;
			shadowNumbers_txt.defaultTextFormat = displayNumbers_txt.defaultTextFormat;
			shadowNumbers_txt.height = displayNumbers_txt.height;
			shadowNumbers_txt.selectable = displayNumbers_txt.selectable;
			shadowNumbers_txt.x = displayNumbers_txt.x;
			shadowNumbers_txt.y = displayNumbers_txt.y;
			shadowNumbers_txt.text = "888";
			
			this.addChild(displayNumbers_txt);
			this.addChild(shadowNumbers_txt);
		}
		/**
		 * Renders on the display the number specified by its parameter.
		 * @param count Number that will be rendered on this display. 
		 **/
		protected function writeTime(count):void
		{
			if(count <= 9){
				this.displayNumbers_txt.text = "00"+ count;
			}else if(count >= 10 && count <= 99){
				this.displayNumbers_txt.text = "0"+ count;
			}else{
				this.displayNumbers_txt.text = count;
			}
		}
		/**
		 * Draws a black rectangle to simulate the display screen.
		 **/
		public function drawDisplay():void
		{
			const displayWidth:int = 50;
			const displayHeigth:int = 25;
			
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x808080, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(displayWidth, 0);
			this.graphics.lineStyle(1, 0xFFFFFF, 1);
			this.graphics.lineTo(displayWidth, displayHeigth);
			this.graphics.lineStyle(1, 0xFFFFFF, 1);
			this.graphics.lineTo(0, displayHeigth);
			this.graphics.lineStyle(1, 0x808080, 1);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
	}
}