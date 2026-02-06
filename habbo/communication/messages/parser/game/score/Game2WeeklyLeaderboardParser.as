package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2WeeklyLeaderboardParser extends Game2LeaderboardParser
   {
      
      private var var_2828:int;
      
      private var var_2941:int;
      
      private var _maxOffset:int;
      
      private var var_2761:int;
      
      private var var_3195:int;
      
      public function Game2WeeklyLeaderboardParser()
      {
         super();
      }
      
      public function get year() : int
      {
         return var_2828;
      }
      
      public function get week() : int
      {
         return var_2941;
      }
      
      public function get maxOffset() : int
      {
         return _maxOffset;
      }
      
      public function get currentOffset() : int
      {
         return var_2761;
      }
      
      public function get minutesUntilReset() : int
      {
         return var_3195;
      }
      
      override public function flush() : Boolean
      {
         var_2828 = -1;
         var_2941 = -1;
         _maxOffset = -1;
         var_2761 = -1;
         var_3195 = -1;
         return super.flush();
      }
      
      override public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2828 = param1.readInteger();
         var_2941 = param1.readInteger();
         _maxOffset = param1.readInteger();
         var_2761 = param1.readInteger();
         var_3195 = param1.readInteger();
         return super.parse(param1);
      }
   }
}

