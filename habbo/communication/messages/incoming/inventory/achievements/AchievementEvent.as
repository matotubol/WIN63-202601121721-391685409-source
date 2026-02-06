package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementEventParser;
   
   [SecureSWF(rename="true")]
   public class AchievementEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AchievementEvent(param1:Function)
      {
         super(param1,AchievementEventParser);
      }
      
      public function getParser() : AchievementEventParser
      {
         return var_15 as AchievementEventParser;
      }
   }
}

