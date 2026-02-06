package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.messages.parser.users.HabboGroupBadgesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboGroupBadgesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboGroupBadgesMessageEvent(param1:Function)
      {
         super(param1,HabboGroupBadgesMessageEventParser);
      }
      
      public function get badges() : class_55
      {
         return (var_15 as HabboGroupBadgesMessageEventParser).badges;
      }
   }
}

