package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2408;
   
   [SecureSWF(rename="true")]
   public class MessengerInitEventParser implements IMessageParser
   {
      
      private var var_5187:int;
      
      private var var_5204:int;
      
      private var var_5182:int;
      
      private var var_143:Array;
      
      public function MessengerInitEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_143 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this.var_5187 = param1.readInteger();
         this.var_5204 = param1.readInteger();
         this.var_5182 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_143.push(new class_2408(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get userFriendLimit() : int
      {
         return this.var_5187;
      }
      
      public function get normalFriendLimit() : int
      {
         return this.var_5204;
      }
      
      public function get extendedFriendLimit() : int
      {
         return this.var_5182;
      }
      
      public function get categories() : Array
      {
         return this.var_143;
      }
   }
}

