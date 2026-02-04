package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.class_13;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class DeBouncer implements class_13
   {
      
      private var var_3222:int = 0;
      
      private var _tolerateImmediateTimeout:int;
      
      private var _disposed:Boolean;
      
      private var var_323:Timer;
      
      private var _callback:Function;
      
      public function DeBouncer(param1:int, param2:int, param3:Function)
      {
         super();
         _tolerateImmediateTimeout = param2;
         this._callback = param3;
         var_323 = new Timer(param1,1);
         var_323.addEventListener("timerComplete",onTimerComplete);
      }
      
      public function trigger() : void
      {
         if(var_3222 < getTimer() - _tolerateImmediateTimeout)
         {
            var_323.reset();
            execute();
            return;
         }
         var_323.reset();
         var_323.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         execute();
      }
      
      private function execute() : void
      {
         var_3222 = getTimer();
         _callback();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_323.stop();
         var_323.removeEventListener("timerComplete",execute);
         var_323 = null;
         _callback = null;
         _tolerateImmediateTimeout = 0;
         var_3222 = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

