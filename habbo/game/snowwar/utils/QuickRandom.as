package com.sulake.habbo.game.snowwar.utils
{
   public class QuickRandom
   {
      
      public function QuickRandom()
      {
         super();
      }
      
      public static function iterateSeed(param1:int) : int
      {
         var _loc2_:* = 0;
         if(param1 == 0)
         {
            param1 = -1;
         }
         _loc2_ = param1 << 13;
         param1 ^= _loc2_;
         _loc2_ = param1 >> 17;
         param1 ^= _loc2_;
         _loc2_ = param1 << 5;
         return param1 ^ _loc2_;
      }
      
      public static function getRandomNumber(param1:int, param2:int) : int
      {
         if(param2 == 0)
         {
            return 0;
         }
         return (param1 < 0 ? param1 * -1 : param1) % param2;
      }
      
      protected static function bitPrint(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         _loc2_ = 31;
         while(_loc2_ >= 0)
         {
            _loc3_ += (param1 & 1 << _loc2_) > 0 ? "1" : "0";
            _loc2_--;
         }
         return _loc3_;
      }
   }
}

