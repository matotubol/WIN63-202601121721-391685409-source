package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RespectNotificationMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var var_4065:int = 0;
      
      public function RespectNotificationMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_4065 = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get respectTotal() : int
      {
         return var_4065;
      }
   }
}

