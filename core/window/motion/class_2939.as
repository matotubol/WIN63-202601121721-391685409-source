package com.sulake.core.window.motion
{
   import com.sulake.core.class_23;
   import com.sulake.core.window.class_1741;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class class_2939
   {
      
      private static var _IS_UPDATING:Boolean;
      
      private static const const_9:Vector.<Motion> = new Vector.<Motion>();
      
      private static const const_5:Vector.<Motion> = new Vector.<Motion>();
      
      private static const const_26:Vector.<Motion> = new Vector.<Motion>();
      
      private static const _TIMER:Timer = new Timer(1000 / class_23.instance.displayObjectContainer.stage.frameRate,0);
      
      public function class_2939()
      {
         super();
      }
      
      public static function runMotion(param1:Motion) : Motion
      {
         if(const_5.indexOf(param1) == -1 && const_9.indexOf(param1) == -1)
         {
            if(_IS_UPDATING)
            {
               const_9.push(param1);
            }
            else
            {
               const_5.push(param1);
               param1.friend::start();
            }
            startTimer();
         }
         return param1;
      }
      
      public static function removeMotion(param1:Motion) : void
      {
         var _loc2_:int = int(const_5.indexOf(param1));
         if(_loc2_ > -1)
         {
            if(_IS_UPDATING)
            {
               _loc2_ = int(const_26.indexOf(param1));
               if(_loc2_ == -1)
               {
                  const_26.push(param1);
               }
            }
            else
            {
               const_5.splice(_loc2_,1);
               if(param1.running)
               {
                  param1.friend::stop();
               }
               if(const_5.length == 0)
               {
                  stopTimer();
               }
            }
         }
         else
         {
            _loc2_ = int(const_9.indexOf(param1));
            if(_loc2_ > -1)
            {
               const_9.splice(_loc2_,1);
            }
         }
      }
      
      public static function getMotionByTag(param1:String) : Motion
      {
         var _loc2_:* = null;
         for each(_loc2_ in const_5)
         {
            if(_loc2_.tag == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in const_9)
         {
            if(_loc2_.tag == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMotionByTarget(param1:class_1741) : Motion
      {
         var _loc2_:* = null;
         for each(_loc2_ in const_5)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in const_9)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMotionByTagAndTarget(param1:String, param2:class_1741) : Motion
      {
         var _loc3_:* = null;
         for each(_loc3_ in const_5)
         {
            if(_loc3_.tag == param1 && _loc3_.target == param2)
            {
               return _loc3_;
            }
         }
         for each(_loc3_ in const_9)
         {
            if(_loc3_.tag == param1 && _loc3_.target == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function get isRunning() : Boolean
      {
         return _TIMER ? _TIMER.running : false;
      }
      
      public static function get isUpdating() : Boolean
      {
         return _IS_UPDATING;
      }
      
      private static function onTick(param1:TimerEvent) : void
      {
         _IS_UPDATING = true;
         var _loc3_:int = getTimer();
         while(true)
         {
            var _loc2_:Motion = const_9.pop();
            if(_loc2_ == null)
            {
               break;
            }
            const_5.push(null);
         }
         while(true)
         {
            _loc2_ = const_26.pop();
            if(_loc2_ == null)
            {
               break;
            }
            const_5.splice(const_5.indexOf(null),1);
            if(null.running)
            {
               null.friend::stop();
            }
         }
         for each(_loc2_ in const_5)
         {
            if(null.running)
            {
               null.friend::tick(_loc3_);
               if(null.complete)
               {
                  removeMotion(null);
               }
            }
            else
            {
               removeMotion(null);
            }
         }
         if(const_5.length == 0)
         {
            stopTimer();
         }
         _IS_UPDATING = false;
      }
      
      private static function startTimer() : void
      {
         if(!_TIMER.running)
         {
            _TIMER.addEventListener("timer",onTick);
            _TIMER.start();
         }
      }
      
      private static function stopTimer() : void
      {
         if(_TIMER.running)
         {
            _TIMER.removeEventListener("timer",onTick);
            _TIMER.stop();
         }
      }
      
      public function getNumRunningMotions(param1:class_1741) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in const_5)
         {
            if(_loc3_.target == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}

