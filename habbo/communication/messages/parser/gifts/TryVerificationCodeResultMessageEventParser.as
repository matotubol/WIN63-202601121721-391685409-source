package com.sulake.habbo.communication.messages.parser.gifts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TryVerificationCodeResultMessageEventParser implements IMessageParser
   {
      
      private var var_1587:int;
      
      private var var_2948:int;
      
      public function TryVerificationCodeResultMessageEventParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
      
      public function get millisecondsToAllowProcessReset() : int
      {
         return var_2948;
      }
      
      public function flush() : Boolean
      {
         var_1587 = -1;
         var_2948 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1587 = param1.readInteger();
         var_2948 = param1.readInteger();
         return true;
      }
   }
}

