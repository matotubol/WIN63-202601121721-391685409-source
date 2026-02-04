package com.sulake.core.communication.util
{
   import flash.utils.ByteArray;
   
   public class Short
   {
      
      private var var_1533:ByteArray;
      
      public function Short(param1:int)
      {
         super();
         var_1533 = new ByteArray();
         var_1533.writeShort(param1);
         var_1533.position = 0;
      }
      
      public function get value() : int
      {
         var _loc1_:int = 0;
         var_1533.position = 0;
         if(var_1533.bytesAvailable)
         {
            _loc1_ = var_1533.readShort();
            var_1533.position = 0;
         }
         return _loc1_;
      }
   }
}

