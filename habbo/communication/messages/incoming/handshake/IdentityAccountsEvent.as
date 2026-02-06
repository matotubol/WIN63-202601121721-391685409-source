package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.IdentityAccountsEventParser;
   
   [SecureSWF(rename="true")]
   public class IdentityAccountsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IdentityAccountsEvent(param1:Function)
      {
         super(param1,IdentityAccountsEventParser);
      }
      
      public function getParser() : IdentityAccountsEventParser
      {
         return this.var_15 as IdentityAccountsEventParser;
      }
   }
}

