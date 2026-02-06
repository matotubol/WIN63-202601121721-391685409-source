package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DisconnectReasonEventParser implements IMessageParser
   {
      
      private var var_2352:int;
      
      public function DisconnectReasonEventParser()
      {
         super();
         var_2352 = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1.bytesAvailable)
         {
            var_2352 = param1.readInteger();
         }
         return true;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
   }
}

