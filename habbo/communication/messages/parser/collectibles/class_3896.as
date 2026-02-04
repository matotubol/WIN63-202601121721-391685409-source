package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3896 implements IMessageParser
   {
      
      private var var_2387:Array;
      
      public function class_3896()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2387 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2387 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2387.push(new class_4087(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get nftCollections() : Array
      {
         return var_2387;
      }
   }
}

