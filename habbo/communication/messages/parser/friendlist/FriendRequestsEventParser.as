package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2254;
   
   [SecureSWF(rename="true")]
   public class FriendRequestsEventParser implements IMessageParser
   {
      
      private var var_4411:int;
      
      private var var_4767:Array;
      
      public function FriendRequestsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_4767 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this.var_4411 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         class_21.log("Received friend requests: " + var_4411 + ", " + _loc2_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_4767.push(new class_2254(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get totalReqCount() : int
      {
         return this.var_4411;
      }
      
      public function get reqs() : Array
      {
         return this.var_4767;
      }
   }
}

