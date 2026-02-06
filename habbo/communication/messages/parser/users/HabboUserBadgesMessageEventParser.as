package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboUserBadgesMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_179:Array;
      
      public function HabboUserBadgesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1270 = -1;
         var_179 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var _loc2_:int = param1.readInteger();
            var _loc3_:String = param1.readString();
            var_179.push(null);
            _loc5_++;
         }
         return true;
      }
      
      public function get badges() : Array
      {
         return var_179;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}

