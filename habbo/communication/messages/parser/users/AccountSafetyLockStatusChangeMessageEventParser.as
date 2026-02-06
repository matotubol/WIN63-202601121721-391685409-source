package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AccountSafetyLockStatusChangeMessageEventParser implements IMessageParser
   {
      
      public static const const_395:int = 0;
      
      public static const const_829:int = 1;
      
      private var _status:int;
      
      public function AccountSafetyLockStatusChangeMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = param1.readInteger();
         return true;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}

