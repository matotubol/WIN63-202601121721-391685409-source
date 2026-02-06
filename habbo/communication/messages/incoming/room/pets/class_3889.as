package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3889
   {
      
      private var var_2779:int;
      
      private var var_2301:Array;
      
      public function class_3889(param1:IMessageDataWrapper)
      {
         super();
         var_2779 = param1.readInteger();
         var_2301 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2301.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var_2779 = -1;
         var_2301 = [];
      }
      
      public function get chance() : int
      {
         return var_2779;
      }
      
      public function get breeds() : Array
      {
         return var_2301;
      }
   }
}

