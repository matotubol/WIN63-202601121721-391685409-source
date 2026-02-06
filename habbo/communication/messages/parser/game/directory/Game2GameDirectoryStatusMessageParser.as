package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2GameDirectoryStatusMessageParser implements IMessageParser
   {
      
      public static const const_661:int = 0;
      
      public static const const_950:int = 1;
      
      public static const const_850:int = 2;
      
      public static const const_518:int = 3;
      
      private var _status:int;
      
      private var var_4958:int;
      
      private var var_4533:int;
      
      private var var_3557:int;
      
      public function Game2GameDirectoryStatusMessageParser()
      {
         super();
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get blockLength() : int
      {
         return var_4958;
      }
      
      public function get gamesPlayed() : int
      {
         return var_4533;
      }
      
      public function get freeGamesLeft() : int
      {
         return var_3557;
      }
      
      public function get hasUnlimitedGames() : Boolean
      {
         return var_3557 == -1;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = param1.readInteger();
         var_4958 = param1.readInteger();
         var_4533 = param1.readInteger();
         var_3557 = param1.readInteger();
         return true;
      }
   }
}

