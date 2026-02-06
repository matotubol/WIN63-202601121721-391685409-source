package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsEventParser;
   
   [SecureSWF(rename="true")]
   public class AchievementsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AchievementsEvent(param1:Function)
      {
         super(param1,AchievementsEventParser);
      }
      
      public function getParser() : AchievementsEventParser
      {
         return var_15 as AchievementsEventParser;
      }
   }
}

