package com.sulake.habbo.utils.animation
{
   import flash.display.DisplayObject;
   
   public class TweenUtils
   {
      
      public static const FAST_ALPHA_TWEEN_TIME:Number = 0.2;
      
      public static const STANDARD_ALPHA_TWEEN_TIME:Number = 0.4;
      
      public static const SLOW_ALPHA_TWEEN_TIME_DOUBLE:Number = 0.8;
      
      public static const REALLY_SLOW_ALPHA_TWEEN_TIME:Number = 1.2;
      
      public static const STANDARD_ANCHOR_TWEEN_TIME:Number = 0.4;
      
      public static var var_2566:Juggler = new Juggler();
      
      public function TweenUtils()
      {
         super();
      }
      
      public static function alphaTweenVisible(param1:DisplayObject, param2:Number, param3:Number, param4:String = "linear") : Tween
      {
         param1.alpha = 0;
         var _loc5_:Tween = new Tween(param1,param3,param4);
         _loc5_.animate("alpha",1);
         _loc5_.delay = param2;
         TweenUtils.var_2566.add(_loc5_);
         return _loc5_;
      }
      
      public static function alphaTweenInvisible(param1:DisplayObject, param2:Number, param3:Number, param4:String = "linear") : Tween
      {
         param1.alpha = 1;
         var _loc5_:Tween = new Tween(param1,param3,param4);
         _loc5_.animate("alpha",0);
         _loc5_.delay = param2;
         TweenUtils.var_2566.add(_loc5_);
         return _loc5_;
      }
      
      public static function alphaTweenBlink(param1:DisplayObject, param2:Number, param3:Number) : Tween
      {
         param1.alpha = 0;
         var _loc4_:Tween = new Tween(param1,param3,"easeOutBack");
         _loc4_.animate("alpha",0.4);
         _loc4_.delay = param2;
         TweenUtils.var_2566.add(_loc4_);
         return _loc4_;
      }
   }
}

