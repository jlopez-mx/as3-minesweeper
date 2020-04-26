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
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * NumberSquare class.
	 * Creates a button square object that shows a number when is clicked, or dissapear when is clicked if it has not a number to show. 
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class NumberSquare extends BasicSquare
	{
		/**
		 * EMBEBED FONT INFO:
		 * By Jayvee D. Enaguas
		 * http://www.dafont.com/retroville-nc.font
		 * http://www.smwcentral.net/?p=profile&id=9069
		 * Please read the 'Readme (Retroville NC).txt' file on 'assets' directory.
		 **/
		[Embed(source="../../../../assets/Retroville NC.TTF", fontName="numberFont_embedded", fontStyle="normal", fontWeight="normal", embedAsCFF="false", unicodeRange="U+0031-U+0038")]
		/** Class registered for the embed font. **/
		private var NumberFont_embedded:Class;
		/** Textfield where the numbers of the square are shown. **/
		private var textFormat:TextFormat = new TextFormat("numberFont_embedded", 14, null, true);
		/**  TextFormat for the numbers of the square that are shown. **/
		private var number_txt:TextField = new TextField();
		
		/**
		 * Constructor.
		 * 
		 * Calls the super constructor (BasicSquare), to draw a button square. 
		 **/
		public function NumberSquare()
		{
			super();
		}
		
		/**
		 * Calls doClick function from the super, and renders the number that contains this button square.
		 **/
		public override function doClick():void
		{
			super.doClick();
			releaseButton();
			numberRender();
		}
		
		/**
		 * Renders the number specified for this button square.
		 * Each number has a different color.
		 **/
		private function numberRender():void
		{
			number_txt.embedFonts = true;
			number_txt.text = this.number;
			number_txt.mouseEnabled = false;
			number_txt.x = 4;
			
			switch (this.number) {
				case 1 :
					textFormat.color = 0x0000FF;
					break;
				case 2 :
					textFormat.color = 0x008000;
					break;
				case 3 :
					textFormat.color = 0xFF0000;
					break;
				case 4 :
					textFormat.color = 0x000080;
					break;
				case 5 :
					textFormat.color = 0x800000;
					break;
				case 6 :
					textFormat.color = 0x008080;
					break;
				case 7 :
					textFormat.color = 0x000000;
					break;
				case 8 :
					textFormat.color = 0x808080;
					break;
				default:
					textFormat.color = 0xC0C0C0;
					break;
			}
			
			number_txt.setTextFormat(textFormat);
			this.addChild(number_txt);
		}
	}
}