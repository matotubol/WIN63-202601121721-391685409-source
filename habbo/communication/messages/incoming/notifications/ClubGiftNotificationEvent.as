package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.ClubGiftNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class ClubGiftNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ClubGiftNotificationEvent(param1:Function)
      {
         super(param1,ClubGiftNotificationEventParser);
      }
      
      public function getParser() : ClubGiftNotificationEventParser
      {
         return var_15 as ClubGiftNotificationEventParser;
      }
   }
}

