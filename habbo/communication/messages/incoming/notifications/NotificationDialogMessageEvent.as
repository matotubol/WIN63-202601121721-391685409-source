package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.NotificationDialogMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NotificationDialogMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NotificationDialogMessageEvent(param1:Function)
      {
         super(param1,NotificationDialogMessageEventParser);
      }
      
      public function getParser() : NotificationDialogMessageEventParser
      {
         return var_15 as NotificationDialogMessageEventParser;
      }
   }
}

