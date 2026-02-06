package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_3180;
   
   [SecureSWF(rename="true")]
   public class HabboSearchResultEventParser implements IMessageParser
   {
      
      private var var_456:Array;
      
      private var _others:Array;
      
      public function HabboSearchResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_456 = [];
         this._others = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_456.push(new class_3180(param1));
            _loc3_++;
         }
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this._others.push(new class_3180(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get friends() : Array
      {
         return this.var_456;
      }
      
      public function get others() : Array
      {
         return this._others;
      }
   }
}

