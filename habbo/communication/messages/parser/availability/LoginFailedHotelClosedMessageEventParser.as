package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LoginFailedHotelClosedMessageEventParser implements IMessageParser
   {
      
      private var var_2709:int;
      
      private var var_2920:int;
      
      public function LoginFailedHotelClosedMessageEventParser()
      {
         super();
      }
      
      public function get openHour() : int
      {
         return var_2709;
      }
      
      public function get openMinute() : int
      {
         return var_2920;
      }
      
      public function flush() : Boolean
      {
         var_2709 = 0;
         var_2920 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2709 = param1.readInteger();
         var_2920 = param1.readInteger();
         return true;
      }
   }
}

