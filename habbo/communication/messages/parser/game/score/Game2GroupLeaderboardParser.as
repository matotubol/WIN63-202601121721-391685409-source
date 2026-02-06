package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2GroupLeaderboardParser implements IMessageParser
   {
      
      private var var_2912:int;
      
      private var var_2514:Array;
      
      private var var_1770:int;
      
      private var var_2793:int;
      
      public function Game2GroupLeaderboardParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2912 = -1;
         var_2514 = null;
         var_1770 = -1;
         var_2793 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2514 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2514.push(new class_3963(param1));
            _loc3_++;
         }
         var_1770 = param1.readInteger();
         var_2912 = param1.readInteger();
         var_2793 = param1.readInteger();
         return true;
      }
      
      public function get gameTypeId() : int
      {
         return var_2912;
      }
      
      public function get leaderboard() : Array
      {
         return var_2514;
      }
      
      public function get totalListSize() : int
      {
         return var_1770;
      }
      
      public function get favouriteGroupId() : int
      {
         return var_2793;
      }
   }
}

