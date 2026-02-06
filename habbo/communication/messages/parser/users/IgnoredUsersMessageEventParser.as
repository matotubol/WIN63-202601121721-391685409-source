package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IgnoredUsersMessageEventParser implements IMessageParser
   {
      
      protected var var_2625:Array = null;
      
      public function IgnoredUsersMessageEventParser()
      {
         super();
         var_2625 = [];
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2625 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2625.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get ignoredUsers() : Array
      {
         return var_2625.slice();
      }
   }
}

