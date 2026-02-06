package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IgnoreResultMessageEventParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      private var var_4843:int;
      
      public function IgnoreResultMessageEventParser()
      {
         super();
         var_1122 = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         var_4843 = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get ignoredUserId() : int
      {
         return var_4843;
      }
   }
}

