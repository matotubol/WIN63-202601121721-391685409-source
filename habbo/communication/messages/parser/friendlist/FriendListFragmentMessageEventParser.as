package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2083;
   
   [SecureSWF(rename="true")]
   public class FriendListFragmentMessageEventParser implements IMessageParser
   {
      
      protected var var_4631:int;
      
      protected var var_4298:int;
      
      private var var_2316:Array;
      
      public function FriendListFragmentMessageEventParser()
      {
         super();
      }
      
      public function get totalFragments() : int
      {
         return var_4631;
      }
      
      public function get fragmentNo() : int
      {
         return var_4298;
      }
      
      public function get friendFragment() : Array
      {
         return var_2316;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4631 = param1.readInteger();
         var_4298 = param1.readInteger();
         var_2316 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            this.var_2316.push(new class_2083(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2316 = [];
         return true;
      }
   }
}

