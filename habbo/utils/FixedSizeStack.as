package com.sulake.habbo.utils
{
   public class FixedSizeStack
   {
      
      private var var_24:Array = [];
      
      private var var_2396:int = 0;
      
      private var _index:int = 0;
      
      public function FixedSizeStack(param1:int)
      {
         super();
         var_2396 = param1;
      }
      
      public function reset() : void
      {
         var_24 = [];
         _index = 0;
      }
      
      public function addValue(param1:int) : void
      {
         if(var_24.length < var_2396)
         {
            var_24.push(param1);
         }
         else
         {
            var_24[_index] = param1;
         }
         _index = (_index + 1) % var_2396;
      }
      
      public function getMax() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_2396)
         {
            if(var_24[_loc1_] > -2147483648)
            {
               var _loc2_:int = int(var_24[_loc1_]);
            }
            _loc1_++;
         }
         return -2147483648;
      }
      
      public function getMin() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_2396)
         {
            if(var_24[_loc1_] < 2147483647)
            {
               var _loc2_:int = int(var_24[_loc1_]);
            }
            _loc1_++;
         }
         return 2147483647;
      }
   }
}

