/**
 * VERSION: 1.0
 * DATE: 22-02-2011
 * AS3
 * UPDATES AND DOCS AT: https://code.google.com/p/as3-minesweeper/
 * 
 * Released under GNU GPL v3 License
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
package 
{
	import flash.display.Sprite;
	import minesweeper.Minesweeper;
	/**
	 * Main class
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class Main extends Sprite
	{
		/** Minesweeper object **/
		private var minesweeper:Minesweeper;
		
		/**
		 * Constructor.
		 * 
		 * Creates a Minesweeper object and adds it to the stage.
		 **/
		public function Main()
		{
			minesweeper = new Minesweeper(12, 12, 15);
			Minesweeper(minesweeper).x = 5;
			Minesweeper(minesweeper).y = 5;
			this.addChild(minesweeper);
		}
	}
}