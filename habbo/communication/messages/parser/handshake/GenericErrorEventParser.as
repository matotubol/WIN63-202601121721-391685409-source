package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GenericErrorEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      public function GenericErrorEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
   }
}

