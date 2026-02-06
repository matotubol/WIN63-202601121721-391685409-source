package com.sulake.habbo.communication.messages.parser.gifts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberResultMessageEventParser implements IMessageParser
   {
      
      private var var_1587:int;
      
      private var var_4864:int;
      
      public function TryPhoneNumberResultMessageEventParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
      
      public function get millisToAllowProcessReset() : int
      {
         return var_4864;
      }
      
      public function flush() : Boolean
      {
         var_1587 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1587 = param1.readInteger();
         var_4864 = param1.readInteger();
         return true;
      }
   }
}

