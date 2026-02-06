package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BlockListMessageEventParser implements IMessageParser
   {
      
      protected var var_2549:Array = null;
      
      public function BlockListMessageEventParser()
      {
         super();
         var_2549 = [];
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2549 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2549.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get blockedUsers() : Array
      {
         return var_2549.slice();
      }
   }
}

