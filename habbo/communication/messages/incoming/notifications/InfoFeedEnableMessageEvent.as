package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.InfoFeedEnableMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class InfoFeedEnableMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InfoFeedEnableMessageEvent(param1:Function)
      {
         super(param1,InfoFeedEnableMessageEventParser);
      }
      
      public function get enabled() : Boolean
      {
         return (var_15 as InfoFeedEnableMessageEventParser).enabled;
      }
   }
}

