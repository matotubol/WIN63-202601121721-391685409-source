package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.AccountSafetyLockStatusChangeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AccountSafetyLockStatusChangeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AccountSafetyLockStatusChangeMessageEvent(param1:Function)
      {
         super(param1,AccountSafetyLockStatusChangeMessageEventParser);
      }
      
      public function getParser() : AccountSafetyLockStatusChangeMessageEventParser
      {
         return var_15 as AccountSafetyLockStatusChangeMessageEventParser;
      }
   }
}

