package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BlockUserUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      private var var_1270:int;
      
      public function BlockUserUpdateMessageEventParser()
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
         var_1270 = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}

