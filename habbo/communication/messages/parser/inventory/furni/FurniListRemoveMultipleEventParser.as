package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FurniListRemoveMultipleEventParser implements IMessageParser
   {
      
      private var var_2384:Vector.<int>;
      
      public function FurniListRemoveMultipleEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2384 = new Vector.<int>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2384.push(param1.readInteger());
            _loc3_ = 0 + 1;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2384 = null;
         return true;
      }
      
      public function get stripIds() : Vector.<int>
      {
         return var_2384;
      }
   }
}

