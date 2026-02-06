package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboAchievementNotificationMessageEvent(param1:Function)
      {
         super(param1,HabboAchievementNotificationMessageEventParser);
      }
      
      public function getParser() : HabboAchievementNotificationMessageEventParser
      {
         return var_15 as HabboAchievementNotificationMessageEventParser;
      }
   }
}

