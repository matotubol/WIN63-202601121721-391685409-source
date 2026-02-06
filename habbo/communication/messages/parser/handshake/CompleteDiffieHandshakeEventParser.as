package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompleteDiffieHandshakeEventParser implements IMessageParser
   {
      
      private var var_4919:String;
      
      private var var_3937:Boolean = false;
      
      public function CompleteDiffieHandshakeEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4919 = param1.readString();
         if(param1.bytesAvailable)
         {
            var_3937 = param1.readBoolean();
         }
         return true;
      }
      
      public function get encryptedPublicKey() : String
      {
         return var_4919;
      }
      
      public function get serverClientEncryption() : Boolean
      {
         return var_3937;
      }
   }
}

