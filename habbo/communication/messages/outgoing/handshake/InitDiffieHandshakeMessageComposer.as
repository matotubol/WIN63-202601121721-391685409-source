package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IPreEncryptionMessage;
   
   [SecureSWF(rename="true")]
   public class InitDiffieHandshakeMessageComposer implements IMessageComposer, IPreEncryptionMessage
   {
      
      public function InitDiffieHandshakeMessageComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
   }
}

