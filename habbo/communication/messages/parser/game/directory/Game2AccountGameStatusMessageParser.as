package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2AccountGameStatusMessageParser implements IMessageParser
   {
      
      private var var_2912:int;
      
      private var var_3557:int;
      
      private var var_4083:int;
      
      public function Game2AccountGameStatusMessageParser()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return var_2912;
      }
      
      public function get freeGamesLeft() : int
      {
         return var_3557;
      }
      
      public function get gamesPlayedTotal() : int
      {
         return var_4083;
      }
      
      public function get hasUnlimitedGames() : Boolean
      {
         return var_3557 == -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2912 = param1.readInteger();
         var_3557 = param1.readInteger();
         var_4083 = param1.readInteger();
         return true;
      }
   }
}

