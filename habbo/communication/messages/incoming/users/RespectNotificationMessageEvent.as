package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.RespectNotificationMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RespectNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RespectNotificationMessageEvent(param1:Function)
      {
         super(param1,RespectNotificationMessageEventParser);
      }
      
      public function get userId() : int
      {
         return (var_15 as RespectNotificationMessageEventParser).userId;
      }
      
      public function get respectTotal() : int
      {
         return (var_15 as RespectNotificationMessageEventParser).respectTotal;
      }
   }
}

