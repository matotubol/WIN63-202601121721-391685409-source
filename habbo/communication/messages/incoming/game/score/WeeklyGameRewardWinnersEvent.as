package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.class_4032;
   
   public class WeeklyGameRewardWinnersEvent extends MessageEvent
   {
      
      public function WeeklyGameRewardWinnersEvent(param1:Function)
      {
         super(param1,class_4032);
      }
      
      public function getParser() : class_4032
      {
         return this.var_15 as class_4032;
      }
   }
}

