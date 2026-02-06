package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.PetSupplementedNotificationEventParser;
   
   [SecureSWF(rename="true")]
   public class PetSupplementedNotificationEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PetSupplementedNotificationEvent(param1:Function)
      {
         super(param1,PetSupplementedNotificationEventParser);
      }
      
      public function getParser() : PetSupplementedNotificationEventParser
      {
         return var_15 as PetSupplementedNotificationEventParser;
      }
   }
}

