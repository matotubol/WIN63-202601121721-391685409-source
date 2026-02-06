package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboActivityPointNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboActivityPointNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboActivityPointNotificationMessageEvent(param1:Function)
      {
         super(param1,HabboActivityPointNotificationMessageEventParser);
      }
      
      public function get amount() : int
      {
         return (var_15 as HabboActivityPointNotificationMessageEventParser).amount;
      }
      
      public function get change() : int
      {
         return (var_15 as HabboActivityPointNotificationMessageEventParser).change;
      }
      
      public function get type() : int
      {
         return (var_15 as HabboActivityPointNotificationMessageEventParser).type;
      }
   }
}

