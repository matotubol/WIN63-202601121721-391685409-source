package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DelayedCall extends EventDispatcher implements class_2207
   {
      
      private static var var_3317:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);
      
      private var mCurrentTime:Number;
      
      private var mTotalTime:Number;
      
      private var var_2884:Function;
      
      private var var_3285:Array;
      
      private var var_699:int;
      
      public function DelayedCall(param1:Function, param2:Number, param3:Array = null)
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function fromPool(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         if(var_3317.length)
         {
            return var_3317.pop().reset(param1,param2,param3);
         }
         return new DelayedCall(param1,param2,param3);
      }
      
      internal static function toPool(param1:DelayedCall) : void
      {
         param1.var_2884 = null;
         param1.var_3285 = null;
         param1.removeEventListeners();
         var_3317.push(param1);
      }
      
      public function reset(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         mCurrentTime = 0;
         mTotalTime = Math.max(param2,0.0001);
         var_2884 = param1;
         var_3285 = param3;
         var_699 = 1;
         return this;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         var _loc4_:Number = mCurrentTime;
         mCurrentTime += param1;
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(_loc4_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(var_699 == 0 || var_699 > 1)
            {
               var_2884.apply(null,var_3285);
               if(var_699 > 0)
               {
                  var_699 -= 1;
               }
               mCurrentTime = 0;
               advanceTime(_loc4_ + param1 - mTotalTime);
            }
            else
            {
               _loc2_ = var_2884;
               _loc3_ = var_3285;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               _loc2_.apply(null,_loc3_);
            }
         }
      }
      
      public function complete() : void
      {
         var _loc1_:Number = mTotalTime - mCurrentTime;
         if(_loc1_ > 0)
         {
            advanceTime(_loc1_);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return var_699 == 1 && mCurrentTime >= mTotalTime;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get repeatCount() : int
      {
         return var_699;
      }
      
      public function set repeatCount(param1:int) : void
      {
         var_699 = param1;
      }
      
      private function removeEventListeners() : void
      {
      }
   }
}

