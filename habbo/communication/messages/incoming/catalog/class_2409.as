package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2409
   {
      
      private var var_602:Array;
      
      private var var_1473:Array;
      
      public function class_2409(param1:IMessageDataWrapper)
      {
         super();
         var_602 = [];
         var_1473 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_602.push(param1.readString());
            _loc3_++;
         }
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc4_)
         {
            var_1473.push(param1.readString());
            _loc5_++;
         }
      }
      
      public function get images() : Array
      {
         return var_602;
      }
      
      public function get texts() : Array
      {
         return var_1473;
      }
   }
}

