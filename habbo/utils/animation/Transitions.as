package com.sulake.habbo.utils.animation
{
   import flash.utils.Dictionary;
   
   public class Transitions
   {
      
      public static const LINEAR:String = "linear";
      
      public static const EASE_IN:String = "easeIn";
      
      public static const const_606:String = "easeOut";
      
      public static const const_986:String = "easeInOut";
      
      public static const EASE_OUT_IN:String = "easeOutIn";
      
      public static const EASE_IN_BACK:String = "easeInBack";
      
      public static const EASE_OUT_BACK:String = "easeOutBack";
      
      public static const EASE_IN_OUT_BACK:String = "easeInOutBack";
      
      public static const EASE_OUT_IN_BACK:String = "easeOutInBack";
      
      public static const const_571:String = "easeInElastic";
      
      public static const const_642:String = "easeOutElastic";
      
      public static const const_908:String = "easeInOutElastic";
      
      public static const const_181:String = "easeOutInElastic";
      
      public static const const_760:String = "easeInBounce";
      
      public static const const_905:String = "easeOutBounce";
      
      public static const const_536:String = "easeInOutBounce";
      
      public static const const_999:String = "easeOutInBounce";
      
      private static var var_2611:Dictionary;
      
      public function Transitions()
      {
         super();
      }
      
      public static function getTransition(param1:String) : Function
      {
         if(var_2611 == null)
         {
            registerDefaults();
         }
         return var_2611[param1];
      }
      
      public static function register(param1:String, param2:Function) : void
      {
         if(var_2611 == null)
         {
            registerDefaults();
         }
         var_2611[param1] = param2;
      }
      
      private static function registerDefaults() : void
      {
         var_2611 = new Dictionary();
         register("linear",linear);
         register("easeIn",easeIn);
         register("easeOut",easeOut);
         register("easeInOut",easeInOut);
         register("easeOutIn",easeOutIn);
         register("easeInBack",easeInBack);
         register("easeOutBack",easeOutBack);
         register("easeInOutBack",easeInOutBack);
         register("easeOutInBack",easeOutInBack);
         register("easeInElastic",easeInElastic);
         register("easeOutElastic",easeOutElastic);
         register("easeInOutElastic",easeInOutElastic);
         register("easeOutInElastic",easeOutInElastic);
         register("easeInBounce",easeInBounce);
         register("easeOutBounce",easeOutBounce);
         register("easeInOutBounce",easeInOutBounce);
         register("easeOutInBounce",easeOutInBounce);
      }
      
      protected static function linear(param1:Number) : Number
      {
         return param1;
      }
      
      protected static function easeIn(param1:Number) : Number
      {
         return param1 * param1 * param1;
      }
      
      protected static function easeOut(param1:Number) : Number
      {
         var _loc2_:Number = param1 - 1;
         return _loc2_ * _loc2_ * _loc2_ + 1;
      }
      
      protected static function easeInOut(param1:Number) : Number
      {
         return easeCombined(easeIn,easeOut,param1);
      }
      
      protected static function easeOutIn(param1:Number) : Number
      {
         return easeCombined(easeOut,easeIn,param1);
      }
      
      protected static function easeInBack(param1:Number) : Number
      {
         return Math.pow(param1,2) * ((1.70158 + 1) * param1 - 1.70158);
      }
      
      protected static function easeOutBack(param1:Number) : Number
      {
         var _loc3_:Number = param1 - 1;
         return Math.pow(_loc3_,2) * ((1.70158 + 1) * _loc3_ + 1.70158) + 1;
      }
      
      protected static function easeInOutBack(param1:Number) : Number
      {
         return easeCombined(easeInBack,easeOutBack,param1);
      }
      
      protected static function easeOutInBack(param1:Number) : Number
      {
         return easeCombined(easeOutBack,easeInBack,param1);
      }
      
      protected static function easeInElastic(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         _loc2_ = 0.3;
         _loc3_ = _loc2_ / 4;
         _loc4_ = param1 - 1;
         return -1 * Math.pow(2,10 * _loc4_) * Math.sin((_loc4_ - _loc3_) * (2 * 3.141592653589793) / _loc2_);
      }
      
      protected static function easeOutElastic(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         _loc2_ = 0.3;
         _loc3_ = _loc2_ / 4;
         return Math.pow(2,-10 * param1) * Math.sin((param1 - _loc3_) * (2 * 3.141592653589793) / _loc2_) + 1;
      }
      
      protected static function easeInOutElastic(param1:Number) : Number
      {
         return easeCombined(easeInElastic,easeOutElastic,param1);
      }
      
      protected static function easeOutInElastic(param1:Number) : Number
      {
         return easeCombined(easeOutElastic,easeInElastic,param1);
      }
      
      protected static function easeInBounce(param1:Number) : Number
      {
         return 1 - easeOutBounce(1 - param1);
      }
      
      protected static function easeOutBounce(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param1 < 1 / 2.75)
         {
            _loc4_ = 7.5625 * Math.pow(param1,2);
         }
         else if(param1 < 2 / 2.75)
         {
            param1 -= 1.5 / 2.75;
            _loc4_ = 7.5625 * Math.pow(param1,2) + 0.75;
         }
         else if(param1 < 2.5 / 2.75)
         {
            param1 -= 2.25 / 2.75;
            _loc4_ = 7.5625 * Math.pow(param1,2) + 0.9375;
         }
         else
         {
            param1 -= 2.625 / 2.75;
            _loc4_ = 7.5625 * Math.pow(param1,2) + 0.984375;
         }
         return _loc4_;
      }
      
      protected static function easeInOutBounce(param1:Number) : Number
      {
         return easeCombined(easeInBounce,easeOutBounce,param1);
      }
      
      protected static function easeOutInBounce(param1:Number) : Number
      {
         return easeCombined(easeOutBounce,easeInBounce,param1);
      }
      
      protected static function easeCombined(param1:Function, param2:Function, param3:Number) : Number
      {
         if(param3 < 0.5)
         {
            return 0.5 * param1(param3 * 2);
         }
         return 0.5 * param2((param3 - 0.5) * 2) + 0.5;
      }
   }
}

