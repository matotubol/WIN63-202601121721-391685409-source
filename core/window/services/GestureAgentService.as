package com.sulake.core.window.services
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GestureAgentService implements class_3838, class_13
   {
      
      private var _disposed:Boolean = false;
      
      protected var var_1394:Boolean;
      
      protected var _window:class_1741;
      
      protected var var_323:Timer;
      
      protected var var_2654:uint = 0;
      
      protected var _callback:Function;
      
      protected var var_1811:int;
      
      protected var var_1846:int;
      
      public function GestureAgentService()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _disposed = true;
      }
      
      public function begin(param1:class_1741, param2:Function, param3:uint, param4:int, param5:int) : class_1741
      {
         var_2654 = param3;
         var _loc6_:class_1741 = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            _window = param1;
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            _callback = param2;
            var_1394 = true;
            var_1811 = param4;
            var_1846 = param5;
            var_323 = new Timer(40,0);
            var_323.addEventListener("timer",operate);
            var_323.start();
         }
         return _loc6_;
      }
      
      protected function operate(param1:TimerEvent) : void
      {
         var_1811 *= 0.75;
         var_1846 *= 0.75;
         if(Math.abs(var_1811) <= 1 && Math.abs(var_1846) <= 1)
         {
            end(_window);
         }
         else if(_callback != null)
         {
            _callback(var_1811,var_1846);
         }
      }
      
      public function end(param1:class_1741) : class_1741
      {
         var _loc2_:class_1741 = _window;
         if(var_323)
         {
            var_323.stop();
            var_323.removeEventListener("timer",operate);
            var_323 = null;
         }
         if(var_1394)
         {
            if(_window == param1)
            {
               if(!_window.disposed)
               {
                  _window.removeEventListener("WE_DESTROYED",clientWindowDestroyed);
               }
               _window = null;
               var_1394 = false;
            }
         }
         return _loc2_;
      }
      
      private function clientWindowDestroyed(param1:class_1758) : void
      {
         end(_window);
      }
   }
}

