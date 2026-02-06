package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreEventParser;
   
   [SecureSWF(rename="true")]
   public class AchievementsScoreEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AchievementsScoreEvent(param1:Function)
      {
         super(param1,AchievementsScoreEventParser);
      }
      
      public function getParser() : AchievementsScoreEventParser
      {
         return var_15 as AchievementsScoreEventParser;
      }
   }
}

