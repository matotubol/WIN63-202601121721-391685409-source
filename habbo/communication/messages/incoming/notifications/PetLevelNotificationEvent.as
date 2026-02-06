package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.PetLevelNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class PetLevelNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetLevelNotificationEvent(param1:Function)
      {
         super(param1,PetLevelNotificationEventParser);
      }
      
      public function getParser() : PetLevelNotificationEventParser
      {
         return var_15 as PetLevelNotificationEventParser;
      }
   }
}

