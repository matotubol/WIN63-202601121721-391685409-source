package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UniqueMachineIDEventParser implements IMessageParser
   {
      
      private var var_1986:String;
      
      public function UniqueMachineIDEventParser()
      {
         super();
         var_1986 = "";
      }
      
      public function flush() : Boolean
      {
         var_1986 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1986 = param1.readString();
         return true;
      }
      
      public function get machineID() : String
      {
         return var_1986;
      }
   }
}

