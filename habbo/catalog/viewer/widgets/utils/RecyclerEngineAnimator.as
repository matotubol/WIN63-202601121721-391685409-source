package com.sulake.habbo.catalog.viewer.widgets.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RecyclerEngineAnimator implements class_13
   {
      
      private static const const_644:int = -88;
      
      private static const MAX_ANGLE:int = 88;
      
      private static const const_520:int = 82;
      
      private static const const_952:int = 68;
      
      private static const ANGLE_BUFFER:int = 5;
      
      private static const const_1235:Number = 0.00008;
      
      private static const BASE_BIAS:Number = 0.35;
      
      private static const FIRST_BIAS:Number = 0.2;
      
      private static const const_1063:int = 16;
      
      private static const RESET_TIME:int = 250;
      
      private static const SHAKE_TIMEOUT:int = 50;
      
      private static const SHAKE_PIXELS:int = 3;
      
      private static const MIN_TIME_ACTIVE:Number = 3000;
      
      private static const SHAKE_PIXELS_E:int = 24;
      
      private static const STEP_SIZE_E:int = 70;
      
      private static const STEP_DURATION_E:int = 20;
      
      private static const TOTAL_DURATION_E:int = 5000;
      
      private static const STEP_DURATION_MIN:int = 400;
      
      private static const STEP_DURATION_MAX:int = 200;
      
      private static const STEP_SIZE_MIN:int = 20;
      
      private static const STEP_SIZE_MAX:int = 55;
      
      private var _arrow:IStaticBitmapWrapperWindow;
      
      private var var_3736:IStaticBitmapWrapperWindow;
      
      private var _onFinish:Function;
      
      private var _startTime:int;
      
      private var _stepBeginTime:int;
      
      private var var_883:int;
      
      private var var_1256:int;
      
      private var _animationTime:int;
      
      private var _shakeLastTime:int;
      
      private var var_323:Timer;
      
      private var var_1056:Boolean = false;
      
      private var var_4325:int;
      
      private var var_4241:int;
      
      private var var_1638:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function RecyclerEngineAnimator(param1:IStaticBitmapWrapperWindow, param2:IStaticBitmapWrapperWindow, param3:Function)
      {
         super();
         _arrow = param1;
         var_3736 = param2;
         var_4325 = param2.x;
         var_4241 = param2.y;
         _onFinish = param3;
         setRotation(0);
      }
      
      private static function rand(param1:int, param2:int) : int
      {
         return param1 + Math.random() * (param2 - param1);
      }
      
      public function start(param1:Boolean = false) : void
      {
         stopTimer();
         var_1056 = false;
         var_1638 = param1;
         _startTime = getTimer();
         setRotation(0);
         setShake(0,0);
         nextStep(false,true);
         startTimer();
      }
      
      public function stop() : void
      {
         stopTimer();
         setShake(0,0);
         var_1056 = false;
      }
      
      public function reset() : void
      {
         stopTimer();
         var_1056 = true;
         var_883 = _arrow.rotation;
         setRotation(var_883 % 360);
         var_1256 = 0;
         _stepBeginTime = getTimer();
         _animationTime = 250;
         setShake(0,0);
         startTimer();
      }
      
      private function startTimer() : void
      {
         var_323 = new Timer(16);
         var_323.addEventListener("timer",onTimerTick);
         var_323.start();
      }
      
      private function stopTimer() : void
      {
         if(var_323)
         {
            var_323.stop();
            var_323.removeEventListener("timer",onTimerTick);
            var_323 = null;
         }
      }
      
      private function setRotation(param1:int) : void
      {
         _arrow.rotation = param1;
         _arrow.invalidate();
      }
      
      private function setShake(param1:int, param2:int) : void
      {
         var_3736.x = var_4325 + param1;
         var_3736.y = var_4241 + param2;
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer();
         var _loc6_:int = _loc2_ - _stepBeginTime;
         var _loc5_:Number = Math.max(0,Math.min(1,_loc6_ / _animationTime));
         var _loc4_:int = (var_1256 - var_883) * _loc5_ + var_883;
         setRotation(_loc4_);
         if(isBusy() && _loc2_ > _shakeLastTime + 50)
         {
            _shakeLastTime = _loc2_;
            var _loc3_:int = var_1638 ? 24 : 3;
            setShake(rand(-0,0),rand(-0,0));
         }
         if(_loc6_ >= _animationTime)
         {
            if(var_1056)
            {
               stopTimer();
               var_1056 = false;
            }
            else if(_loc4_ >= 82 && !var_1638 && _loc2_ - _startTime > 3000 || var_1638 && _loc2_ - _startTime > 5000)
            {
               stopTimer();
               setShake(0,0);
               _onFinish();
            }
            else
            {
               nextStep(_loc4_ >= 68 && _loc2_ - _startTime > 3000 - 300 && !var_1638);
            }
         }
      }
      
      private function nextStep(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc6_:Number = NaN;
         var_883 = _arrow.rotation;
         _stepBeginTime = getTimer();
         if(param1)
         {
            var_1256 = 88;
         }
         else if(var_1638)
         {
            var_1256 = var_883 - 70;
         }
         else
         {
            var _loc4_:int = getTimer() - _startTime;
            if(var_883 <= -88 + 5)
            {
               var _loc3_:* = false;
            }
            else if(var_883 >= 88 - 5)
            {
               _loc3_ = true;
            }
            else
            {
               _loc6_ = param2 ? 0.2 : 0.35 + 0 * 0.00008;
               _loc3_ = Math.random() > _loc6_;
            }
            var _loc5_:int = 1 * rand(20,55);
            var_1256 = Math.max(-88,Math.min(88,var_883 + 0));
         }
         _animationTime = var_1638 ? 20 : rand(400,200);
      }
      
      public function isBusy() : Boolean
      {
         return var_323 != null && !var_1056;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         stopTimer();
         _arrow = null;
         _onFinish = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

