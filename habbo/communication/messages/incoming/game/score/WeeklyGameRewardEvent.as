package com.sulake.habbo.communication.messages.incoming.game.score
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.score.class_3934;
   
   public class WeeklyGameRewardEvent extends MessageEvent
   {
      
      public function WeeklyGameRewardEvent(param1:Function)
      {
         super(param1,class_3934);
      }
      
      public function getParser() : class_3934
      {
         return this.var_15 as class_3934;
      }
   }
}

