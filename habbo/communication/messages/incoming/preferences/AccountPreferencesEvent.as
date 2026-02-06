package com.sulake.habbo.communication.messages.incoming.preferences
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesEventParser;
   
   [SecureSWF(rename="true")]
   public class AccountPreferencesEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AccountPreferencesEvent(param1:Function)
      {
         super(param1,AccountPreferencesEventParser);
      }
      
      public function getParser() : AccountPreferencesEventParser
      {
         return this.var_15 as AccountPreferencesEventParser;
      }
   }
}

