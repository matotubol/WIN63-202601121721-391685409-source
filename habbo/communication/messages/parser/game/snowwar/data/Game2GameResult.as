package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2GameResult
   {
      
      public static const const_455:int = 0;
      
      public static const const_1240:int = 1;
      
      public static const const_576:int = 2;
      
      private var var_3983:Boolean;
      
      private var var_2830:int;
      
      private var var_5091:int;
      
      public function Game2GameResult(param1:IMessageDataWrapper)
      {
         super();
         var_3983 = param1.readBoolean();
         var_2830 = param1.readInteger();
         var_5091 = param1.readInteger();
      }
      
      public function get isDeathMatch() : Boolean
      {
         return var_3983;
      }
      
      public function get resultType() : int
      {
         return var_2830;
      }
      
      public function get winnerId() : int
      {
         return var_5091;
      }
   }
}

