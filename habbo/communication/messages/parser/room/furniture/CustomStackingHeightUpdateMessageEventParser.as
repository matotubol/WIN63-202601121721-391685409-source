package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CustomStackingHeightUpdateMessageEventParser implements IMessageParser
   {
      
      private var var_2536:int;
      
      private var var_385:Number;
      
      public function CustomStackingHeightUpdateMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2536 = -1;
         var_385 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2536 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var_385 = _loc2_ / 100;
         return true;
      }
      
      public function get height() : Number
      {
         return var_385;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
   }
}

