package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_3449;
   
   [SecureSWF(rename="true")]
   public class ConsoleMessageHistoryEventParser implements IMessageParser
   {
      
      private var var_4642:int;
      
      private var var_3811:Array;
      
      public function ConsoleMessageHistoryEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_4642 = param1.readInteger();
         var_3811 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            this.var_3811.push(new class_3449(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get chatId() : int
      {
         return var_4642;
      }
      
      public function get historyFragment() : Array
      {
         return var_3811;
      }
   }
}

