package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_1936;
   
   [SecureSWF(rename="true")]
   public class AcceptFriendResultEventParser implements IMessageParser
   {
      
      private var var_4022:Array;
      
      public function AcceptFriendResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_4022 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_4022.push(new class_1936(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get failures() : Array
      {
         return this.var_4022;
      }
   }
}

