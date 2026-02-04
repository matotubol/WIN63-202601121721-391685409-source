package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Juggler implements class_2207
   {
      
      public static const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";
      
      private var var_180:Vector.<class_2207>;
      
      private var mElapsedTime:Number;
      
      public function Juggler()
      {
         super();
         mElapsedTime = 0;
         var_180 = new Vector.<class_2207>(0);
      }
      
      public function add(param1:class_2207) : void
      {
         var _loc2_:EventDispatcher = null;
         if(param1 && var_180.indexOf(param1) == -1)
         {
            var_180[var_180.length] = param1;
            _loc2_ = param1 as EventDispatcher;
            if(_loc2_)
            {
               _loc2_.addEventListener("REMOVE_FROM_JUGGLER",onRemove);
            }
         }
      }
      
      public function contains(param1:class_2207) : Boolean
      {
         return var_180.indexOf(param1) != -1;
      }
      
      public function remove(param1:class_2207) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:EventDispatcher = param1 as EventDispatcher;
         if(_loc3_)
         {
            _loc3_.removeEventListener("REMOVE_FROM_JUGGLER",onRemove);
         }
         var _loc2_:int = int(var_180.indexOf(param1));
         if(_loc2_ != -1)
         {
            var_180[_loc2_] = null;
         }
      }
      
      public function removeTweens(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Tween = null;
         if(param1 == null)
         {
            return;
         }
         _loc3_ = var_180.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_180[_loc3_] as Tween;
            if(_loc2_ && _loc2_.target == param1)
            {
               _loc2_.removeEventListener("REMOVE_FROM_JUGGLER",onRemove);
               var_180[_loc3_] = null;
            }
            _loc3_--;
         }
      }
      
      public function containsTweens(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Tween = null;
         if(param1 == null)
         {
            return false;
         }
         _loc3_ = var_180.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_180[_loc3_] as Tween;
            if(_loc2_ && _loc2_.target == param1)
            {
               return true;
            }
            _loc3_--;
         }
         return false;
      }
      
      public function purge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:EventDispatcher = null;
         _loc1_ = var_180.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = var_180[_loc1_] as EventDispatcher;
            if(_loc2_)
            {
               _loc2_.removeEventListener("REMOVE_FROM_JUGGLER",onRemove);
            }
            var_180[_loc1_] = null;
            _loc1_--;
         }
      }
      
      public function delayCall(param1:Function, param2:Number, ... rest) : class_2207
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:DelayedCall = DelayedCall.fromPool(param1,param2,rest);
         _loc4_.addEventListener("REMOVE_FROM_JUGGLER",onPooledDelayedCallComplete);
         add(_loc4_);
         return _loc4_;
      }
      
      public function repeatCall(param1:Function, param2:Number, param3:int = 0, ... rest) : class_2207
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc5_:DelayedCall = DelayedCall.fromPool(param1,param2,rest);
         _loc5_.repeatCount = param3;
         _loc5_.addEventListener("REMOVE_FROM_JUGGLER",onPooledDelayedCallComplete);
         add(_loc5_);
         return _loc5_;
      }
      
      private function onPooledDelayedCallComplete(param1:Event) : void
      {
         DelayedCall.toPool(param1.target as DelayedCall);
      }
      
      public function tween(param1:Object, param2:Number, param3:Object) : class_2207
      {
         var _loc6_:Object = null;
         if(param1 == null)
         {
            throw new ArgumentError("target must not be null");
         }
         var _loc4_:Tween = Tween.fromPool(param1,param2);
         for(var _loc5_ in param3)
         {
            _loc6_ = param3[_loc5_];
            if(_loc4_.hasOwnProperty(_loc5_))
            {
               _loc4_[_loc5_] = _loc6_;
            }
            else
            {
               if(!param1.hasOwnProperty(Tween.getPropertyName(_loc5_)))
               {
                  throw new ArgumentError("Invalid property: " + _loc5_);
               }
               _loc4_.animate(_loc5_,_loc6_ as Number);
            }
         }
         _loc4_.addEventListener("REMOVE_FROM_JUGGLER",onPooledTweenComplete);
         add(_loc4_);
         return _loc4_;
      }
      
      private function onPooledTweenComplete(param1:Event) : void
      {
         Tween.toPool(param1.target as Tween);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc5_:class_2207 = null;
         var _loc4_:int = int(var_180.length);
         mElapsedTime += param1;
         if(_loc4_ == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc5_ = var_180[_loc2_];
            if(_loc5_)
            {
               if(0 != _loc2_)
               {
                  var_180[0] = _loc5_;
                  var_180[_loc2_] = null;
               }
               _loc5_.advanceTime(param1);
               _loc3_++;
            }
            _loc2_++;
         }
         if(0 != _loc2_)
         {
            _loc4_ = int(var_180.length);
            while(_loc2_ < _loc4_)
            {
               var _temp_4:* = var_180;
               var _temp_3:* = 0;
               _loc3_++;
               _temp_4[_temp_3] = var_180[_loc2_++];
            }
            var_180.length = 0;
         }
      }
      
      private function onRemove(param1:Event) : void
      {
         remove(param1.target as class_2207);
         var _loc2_:Tween = param1.target as Tween;
         if(_loc2_ && _loc2_.isComplete)
         {
            add(_loc2_.nextTween);
         }
      }
      
      public function get elapsedTime() : Number
      {
         return mElapsedTime;
      }
      
      protected function get objects() : Vector.<class_2207>
      {
         return var_180;
      }
   }
}

