package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.MOTDNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class MOTDNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function MOTDNotificationEvent(param1:Function)
      {
         super(param1,MOTDNotificationEventParser);
      }
      
      public function getParser() : MOTDNotificationEventParser
      {
         return var_15 as MOTDNotificationEventParser;
      }
   }
}

