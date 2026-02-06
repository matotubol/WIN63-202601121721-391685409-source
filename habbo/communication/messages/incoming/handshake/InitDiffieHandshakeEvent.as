package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.InitDiffieHandshakeEventParser;
   
   [SecureSWF(rename="true")]
   public class InitDiffieHandshakeEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InitDiffieHandshakeEvent(param1:Function)
      {
         super(param1,InitDiffieHandshakeEventParser);
      }
      
      public function get encryptedPrime() : String
      {
         return (this.var_15 as InitDiffieHandshakeEventParser).encryptedPrime;
      }
      
      public function get encryptedGenerator() : String
      {
         return (this.var_15 as InitDiffieHandshakeEventParser).encryptedGenerator;
      }
   }
}

