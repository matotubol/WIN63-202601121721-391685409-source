package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.class_1741;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CalendarItemWiggle
   {
      
      private static const TIMER_INTERVAL:int = 80;
      
      private static const const_1143:int = 10;
      
      private static const const_498:int = 40;
      
      private static const const_340:int = 7;
      
      private var _window:class_1741;
      
      private var var_323:Timer;
      
      private var var_81:int;
      
      private var var_493:int;
      
      private var var_1696:int;
      
      public function CalendarItemWiggle(param1:class_1741)
      {
         super();
         if(!param1)
         {
            return;
         }
         _window = param1;
         var_1696 = param1.y;
         param1.y -= 10;
         var_81 = 1;
         var_323 = new Timer(80);
         var_323.addEventListener("timer",onTimerEvent);
         var_323.start();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         if(!_window)
         {
            dispose();
         }
         var _loc3_:Number = 10 * ((7 - var_493) / 7);
         var _loc4_:Number = Math.abs(_window.y - var_1696) / _loc3_;
         var _loc2_:Number = Math.max(2,Math.sin(_loc4_) * 40) * var_81;
         _window.y += _loc2_;
         if(var_81 > 0)
         {
            if(_window.y > var_1696)
            {
               var_81 *= -1;
               _window.y = var_1696;
               var_493 = var_493 + 1;
            }
         }
         else if(_window.y <= var_1696 - _loc3_)
         {
            var_81 *= -1;
            _window.y = var_1696 - _loc3_;
            var_493 = var_493 + 1;
         }
         if(var_493 >= 7)
         {
            dispose();
         }
      }
      
      private function dispose() : void
      {
         _window.y = var_1696;
         _window = null;
         var_323.reset();
         var_323 = null;
      }
   }
}

