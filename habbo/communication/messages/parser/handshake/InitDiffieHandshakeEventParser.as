package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InitDiffieHandshakeEventParser implements IMessageParser
   {
      
      private var var_3985:String;
      
      private var var_4333:String;
      
      public function InitDiffieHandshakeEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3985 = param1.readString();
         var_4333 = param1.readString();
         return true;
      }
      
      public function get encryptedPrime() : String
      {
         return var_3985;
      }
      
      public function get encryptedGenerator() : String
      {
         return var_4333;
      }
   }
}

