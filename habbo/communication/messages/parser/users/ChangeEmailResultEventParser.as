package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChangeEmailResultEventParser implements IMessageParser
   {
      
      public static const const_427:int = 0;
      
      private var var_1122:int;
      
      public function ChangeEmailResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
   }
}

