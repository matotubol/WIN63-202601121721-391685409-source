package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2TeamScoreData
   {
      
      private var var_808:int;
      
      private var var_3790:int;
      
      private var _players:Array;
      
      public function Game2TeamScoreData(param1:IMessageDataWrapper)
      {
         super();
         var_3790 = param1.readInteger();
         var_808 = param1.readInteger();
         _players = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _players.push(new Game2TeamPlayerData(var_3790,param1));
            _loc3_++;
         }
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get teamReference() : int
      {
         return var_3790;
      }
      
      public function get players() : Array
      {
         return _players;
      }
   }
}

