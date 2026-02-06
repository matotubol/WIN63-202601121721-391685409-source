package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class PetRespectNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetRespectNotificationEvent(param1:Function)
      {
         super(param1,PetRespectNotificationEventParser);
      }
      
      public function getParser() : PetRespectNotificationEventParser
      {
         return var_15 as PetRespectNotificationEventParser;
      }
   }
}

