package com.sulake.habbo.communication.messages.parser.vault
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardStatusMessageEventParser implements IMessageParser
   {
      
      private var var_24:Array = [];
      
      public function IncomeRewardStatusMessageEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_24.push(new class_3206(param1.readByte(),param1.readByte(),param1.readInteger(),param1.readString()));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_24 = [];
         return true;
      }
      
      public function get data() : Array
      {
         return var_24;
      }
      
      public function set data(param1:Array) : void
      {
         var_24 = param1;
      }
   }
}

