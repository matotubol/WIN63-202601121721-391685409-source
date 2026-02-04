package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Tween extends EventDispatcher implements class_2207
   {
      
      private static const HINT_MARKER:String = "#";
      
      private static var var_3193:Vector.<Tween> = new Vector.<Tween>(0);
      
      private var var_1669:Object;
      
      private var var_1348:Function;
      
      private var mTransitionName:String;
      
      private var var_1376:Vector.<String>;
      
      private var var_1136:Vector.<Number>;
      
      private var var_2189:Vector.<Number>;
      
      private var var_2520:Vector.<Function>;
      
      private var var_1685:Function;
      
      private var mOnUpdate:Function;
      
      private var var_1607:Function;
      
      private var var_2182:Function;
      
      private var var_1907:Array;
      
      private var var_2073:Array;
      
      private var var_2197:Array;
      
      private var var_1942:Array;
      
      private var mTotalTime:Number;
      
      private var mCurrentTime:Number;
      
      private var mProgress:Number;
      
      private var var_2215:Number;
      
      private var var_2602:Boolean;
      
      private var mNextTween:Tween;
      
      private var var_699:int;
      
      private var var_2366:Number;
      
      private var var_2254:Boolean;
      
      private var var_1227:int;
      
      private const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";
      
      public function Tween(param1:Object, param2:Number, param3:Object = "linear")
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function getPropertyHint(param1:String) : String
      {
         if(param1.indexOf("color") != -1 || param1.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var _loc2_:int = int(param1.indexOf("#"));
         if(_loc2_ != -1)
         {
            return param1.substr(_loc2_ + 1);
         }
         return null;
      }
      
      internal static function getPropertyName(param1:String) : String
      {
         var _loc2_:int = int(param1.indexOf("#"));
         if(_loc2_ != -1)
         {
            return param1.substring(0,_loc2_);
         }
         return param1;
      }
      
      internal static function fromPool(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         if(var_3193.length)
         {
            return var_3193.pop().reset(param1,param2,param3);
         }
         return new Tween(param1,param2,param3);
      }
      
      internal static function toPool(param1:Tween) : void
      {
         param1.var_1685 = param1.mOnUpdate = param1.var_1607 = param1.var_2182 = null;
         param1.var_1907 = param1.var_2073 = param1.var_2197 = param1.var_1942 = null;
         param1.var_1669 = null;
         param1.var_1348 = null;
         var_3193.push(param1);
      }
      
      public function reset(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         var_1669 = param1;
         mCurrentTime = 0;
         mTotalTime = Math.max(0.0001,param2);
         mProgress = 0;
         var_2215 = var_2366 = 0;
         var_1685 = mOnUpdate = var_1607 = var_2182 = null;
         var_1907 = var_2073 = var_2197 = var_1942 = null;
         var_2602 = var_2254 = false;
         var_699 = 1;
         var_1227 = -1;
         mNextTween = null;
         if(param3 is String)
         {
            this.transition = param3 as String;
         }
         else
         {
            if(!(param3 is Function))
            {
               throw new ArgumentError("Transition must be either a string or a function");
            }
            this.transitionFunc = param3 as Function;
         }
         if(var_1376)
         {
            var_1376.length = 0;
         }
         else
         {
            var_1376 = new Vector.<String>(0);
         }
         if(var_1136)
         {
            var_1136.length = 0;
         }
         else
         {
            var_1136 = new Vector.<Number>(0);
         }
         if(var_2189)
         {
            var_2189.length = 0;
         }
         else
         {
            var_2189 = new Vector.<Number>(0);
         }
         if(var_2520)
         {
            var_2520.length = 0;
         }
         else
         {
            var_2520 = new Vector.<Function>(0);
         }
         return this;
      }
      
      public function animate(param1:String, param2:Number) : void
      {
         if(var_1669 == null)
         {
            return;
         }
         var _loc3_:int = int(var_1376.length);
         var _loc4_:Function = getUpdateFuncFromProperty(param1);
         var_1376[_loc3_] = getPropertyName(param1);
         var_1136[_loc3_] = NaN;
         var_2189[_loc3_] = param2;
         var_2520[_loc3_] = _loc4_;
      }
      
      public function scaleTo(param1:Number) : void
      {
         animate("scaleX",param1);
         animate("scaleY",param1);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         animate("x",param1);
         animate("y",param2);
      }
      
      public function fadeTo(param1:Number) : void
      {
         animate("alpha",param1);
      }
      
      public function rotateTo(param1:Number, param2:String = "rad") : void
      {
         animate("rotation#" + param2,param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(param1 == 0 || var_699 == 1 && mCurrentTime == mTotalTime)
         {
            return;
         }
         var _loc3_:Number = mCurrentTime;
         var _loc2_:Number = mTotalTime - mCurrentTime;
         var _loc10_:Number = param1 > _loc2_ ? param1 - _loc2_ : 0;
         mCurrentTime += param1;
         if(mCurrentTime <= 0)
         {
            return;
         }
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(var_1227 < 0 && _loc3_ <= 0 && mCurrentTime > 0)
         {
            var_1227 = var_1227 + 1;
            if(var_1685 != null)
            {
               var_1685.apply(this,var_1907);
            }
         }
         var _loc11_:Number = mCurrentTime / mTotalTime;
         var _loc9_:Boolean = var_2254 && var_1227 % 2 == 1;
         var _loc4_:int = int(var_1136.length);
         mProgress = _loc9_ ? var_1348(1 - _loc11_) : var_1348(_loc11_);
         var _loc6_:int = 0;
         while(0 < _loc4_)
         {
            if(var_1136[0] != var_1136[0])
            {
               var_1136[0] = var_1669[var_1376[0]] as Number;
            }
            var _loc7_:Function = var_2520[0] as Function;
            _loc7_(var_1376[0],var_1136[0],var_2189[0]);
            _loc6_++;
         }
         if(mOnUpdate != null)
         {
            mOnUpdate.apply(this,var_2073);
         }
         if(_loc3_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(var_699 == 0 || var_699 > 1)
            {
               mCurrentTime = -var_2366;
               var_1227 = var_1227 + 1;
               if(var_699 > 1)
               {
                  var_699 = var_699 - 1;
               }
               if(var_1607 != null)
               {
                  var_1607.apply(this,var_2197);
               }
            }
            else
            {
               var _loc5_:Function = var_2182;
               var _loc8_:Array = var_1942;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               if(mCurrentTime == 0)
               {
                  _loc10_ = 0;
               }
            }
         }
         if(_loc10_)
         {
            advanceTime(_loc10_);
         }
      }
      
      private function getUpdateFuncFromProperty(param1:String) : Function
      {
         var _loc3_:Function = null;
         var _loc2_:String = getPropertyHint(param1);
         switch(_loc2_)
         {
            case null:
               _loc3_ = updateStandard;
               break;
            case "rgb":
               _loc3_ = updateRgb;
               break;
            case "rad":
               _loc3_ = updateRad;
               break;
            case "deg":
               _loc3_ = updateDeg;
               break;
            default:
               _loc3_ = updateStandard;
         }
         return _loc3_;
      }
      
      private function updateStandard(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param2 + mProgress * (param3 - param2);
         if(var_2602)
         {
            _loc4_ = Math.round(_loc4_);
         }
         var_1669[param1] = _loc4_;
      }
      
      private function updateRgb(param1:String, param2:Number, param3:Number) : void
      {
         var _loc11_:uint = param2;
         var _loc6_:uint = param3;
         var _loc13_:uint = uint(_loc11_ >> 24 & 0xFF);
         var _loc17_:uint = uint(_loc11_ >> 16 & 0xFF);
         var _loc7_:uint = uint(_loc11_ >> 8 & 0xFF);
         var _loc10_:uint = uint(_loc11_ & 0xFF);
         var _loc9_:uint = uint(_loc6_ >> 24 & 0xFF);
         var _loc16_:uint = uint(_loc6_ >> 16 & 0xFF);
         var _loc5_:uint = uint(_loc6_ >> 8 & 0xFF);
         var _loc8_:uint = uint(_loc6_ & 0xFF);
         var _loc14_:uint = _loc13_ + (_loc9_ - _loc13_) * mProgress;
         var _loc4_:uint = _loc17_ + (_loc16_ - _loc17_) * mProgress;
         var _loc15_:uint = _loc7_ + (_loc5_ - _loc7_) * mProgress;
         var _loc12_:uint = _loc10_ + (_loc8_ - _loc10_) * mProgress;
         var_1669[param1] = _loc14_ << 24 | _loc4_ << 16 | _loc15_ << 8 | _loc12_;
      }
      
      private function updateRad(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(3.141592653589793,param1,param2,param3);
      }
      
      private function updateDeg(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(180,param1,param2,param3);
      }
      
      private function updateAngle(param1:Number, param2:String, param3:Number, param4:Number) : void
      {
         while(Math.abs(param4 - param3) > param1)
         {
            if(param3 < param4)
            {
               param4 -= 2 * param1;
            }
            else
            {
               param4 += 2 * param1;
            }
         }
         updateStandard(param2,param3,param4);
      }
      
      public function getEndValue(param1:String) : Number
      {
         var _loc2_:int = int(var_1376.indexOf(param1));
         if(_loc2_ == -1)
         {
            throw new ArgumentError("The property \'" + param1 + "\' is not animated");
         }
         return var_2189[_loc2_] as Number;
      }
      
      public function get isComplete() : Boolean
      {
         return mCurrentTime >= mTotalTime && var_699 == 1;
      }
      
      public function get target() : Object
      {
         return var_1669;
      }
      
      public function get transition() : String
      {
         return mTransitionName;
      }
      
      public function set transition(param1:String) : void
      {
         mTransitionName = param1;
         var_1348 = Transitions.getTransition(param1);
         if(var_1348 == null)
         {
            throw new ArgumentError("Invalid transiton: " + param1);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return var_1348;
      }
      
      public function set transitionFunc(param1:Function) : void
      {
         mTransitionName = "custom";
         var_1348 = param1;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get progress() : Number
      {
         return mProgress;
      }
      
      public function get delay() : Number
      {
         return var_2215;
      }
      
      public function set delay(param1:Number) : void
      {
         mCurrentTime = mCurrentTime + var_2215 - param1;
         var_2215 = param1;
      }
      
      public function get repeatCount() : int
      {
         return var_699;
      }
      
      public function set repeatCount(param1:int) : void
      {
         var_699 = param1;
      }
      
      public function get repeatDelay() : Number
      {
         return var_2366;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         var_2366 = param1;
      }
      
      public function get reverse() : Boolean
      {
         return var_2254;
      }
      
      public function set reverse(param1:Boolean) : void
      {
         var_2254 = param1;
      }
      
      public function get roundToInt() : Boolean
      {
         return var_2602;
      }
      
      public function set roundToInt(param1:Boolean) : void
      {
         var_2602 = param1;
      }
      
      public function get onStart() : Function
      {
         return var_1685;
      }
      
      public function set onStart(param1:Function) : void
      {
         var_1685 = param1;
      }
      
      public function get onUpdate() : Function
      {
         return mOnUpdate;
      }
      
      public function set onUpdate(param1:Function) : void
      {
         mOnUpdate = param1;
      }
      
      public function get onRepeat() : Function
      {
         return var_1607;
      }
      
      public function set onRepeat(param1:Function) : void
      {
         var_1607 = param1;
      }
      
      public function get onComplete() : Function
      {
         return var_2182;
      }
      
      public function set onComplete(param1:Function) : void
      {
         var_2182 = param1;
      }
      
      public function get onStartArgs() : Array
      {
         return var_1907;
      }
      
      public function set onStartArgs(param1:Array) : void
      {
         var_1907 = param1;
      }
      
      public function get onUpdateArgs() : Array
      {
         return var_2073;
      }
      
      public function set onUpdateArgs(param1:Array) : void
      {
         var_2073 = param1;
      }
      
      public function get onRepeatArgs() : Array
      {
         return var_2197;
      }
      
      public function set onRepeatArgs(param1:Array) : void
      {
         var_2197 = param1;
      }
      
      public function get onCompleteArgs() : Array
      {
         return var_1942;
      }
      
      public function set onCompleteArgs(param1:Array) : void
      {
         var_1942 = param1;
      }
      
      public function get nextTween() : Tween
      {
         return mNextTween;
      }
      
      public function set nextTween(param1:Tween) : void
      {
         mNextTween = param1;
      }
   }
}

