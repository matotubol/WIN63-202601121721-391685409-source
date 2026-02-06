package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboBroadcastMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HabboBroadcastMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HabboBroadcastMessageEvent(param1:Function)
      {
         super(param1,HabboBroadcastMessageEventParser);
      }
      
      public function get messageText() : String
      {
         return (var_15 as HabboBroadcastMessageEventParser).messageText;
      }
      
      public function getParser() : HabboBroadcastMessageEventParser
      {
         return var_15 as HabboBroadcastMessageEventParser;
      }
   }
}

