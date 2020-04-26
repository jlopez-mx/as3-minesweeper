/**
 * VERSION: 1.0
 * DATE: 24-02-2011
 * AS3
 * UPDATES AND DOCS AT: https://code.google.com/p/as3-minesweeper/
 * 
 * Released under GNU GPL v3 License
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
package minesweeper.utils
{
	/**
	 * MinesweeperState class.
	 * Singleton that contains some variables for being used as global.
	 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
	 **/
	public class MinesweeperState
	{
		/** @private Instance for this singleton  **/
		private static var _instance:MinesweeperState = null;
		/** Boolean value to indicate if the minesweeper is being pressed. **/
		private var _isPressing:Boolean = false;
		/** Boolean value to indicate if the minesweeper is being played. **/
		private var _isPlaying:Boolean = true;
		/** Boolean value to indicate if the user is already a winner. **/
		private var _isWinner:Boolean = false;
		
		/** 
		 * Constructor.
		 * 
		 *  MinesweeperState class is a singleton that contains some variables for being used as global values.
		 **/
		public function MinesweeperState(e:Enforcer){}
		
		/**
		 * Method of the singleton that invokes the creation of an object of this class.
		 * ONLY If there is not any instance of this class in all the project, the instance will be created and returned.
		 * If there is another instance of this class, this method will return the already created instance.
		 **/
		public static function getInstance():MinesweeperState{
			if(_instance == null){
				_instance = new MinesweeperState(new Enforcer());
			}
			return _instance;
		}
		
		////////////////////////////////////////////////////////////////
		/* GETTERS & SETTERS*/
		////////////////////////////////////////////////////////////////
		
		/**
		 * @return Boolean that indicates if the user is a winner. 
		 **/
		public function get isWinner():Boolean
		{
			return _isWinner;
		}
		
		/**
		 * Indicates if the user is winner.
		 **/
		public function set isWinner(value:Boolean):void
		{
			_isWinner = value;
		}
		
		/**
		 * @return Boolean that indicates if the user is still playing the minesweeper (has not lost, or has not won).
		 **/
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		/**
		 * Indicate if the user is still playing the minesweeper (has not lost, or has not won).
		 **/
		public function set isPlaying(value:Boolean):void
		{
			_isPlaying = value;
		}
		
		/**
		 * @return Boolean that indicates if the minesweeper is being pressed.
		 **/
		public function get isPressing():Boolean{
			return _isPressing;
		}
		
		/**
		 * Indicates if the minesweeper is being pressed.
		 **/
		public function set isPressing(newState:Boolean):void{
			_isPressing = newState;
		}
	}
}

/**
 * @private
 * Enforcer class
 * Dummy class for the singleton MinesweeperState
 * @author Jose Heriberto Lopez Ruiz, jlopez@joselopez.com.mx
 **/
class Enforcer{}