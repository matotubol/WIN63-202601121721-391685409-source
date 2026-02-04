package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2SnowWarGameStats
   {
      
      private var var_4947:int;
      
      private var var_4407:int;
      
      public function Game2SnowWarGameStats(param1:IMessageDataWrapper)
      {
         super();
         var_4947 = param1.readInteger();
         var_4407 = param1.readInteger();
      }
      
      public function get playerWithMostKills() : int
      {
         return var_4947;
      }
      
      public function get playerWithMostHits() : int
      {
         return var_4407;
      }
   }
}

