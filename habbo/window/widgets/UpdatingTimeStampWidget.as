package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class UpdatingTimeStampWidget implements class_3111
   {
      
      public static const TYPE:String = "updating_timestamp";
      
      private static const UPDATE_TIMER:Timer = new Timer(60000);
      
      UPDATE_TIMER.start();
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:ILabelWindow;
      
      private var var_2416:Number;
      
      public function UpdatingTimeStampWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.create("",12,100,16,new Rectangle()) as ILabelWindow;
         var_134.textColor = 5592405;
         var_210.rootWindow = var_134;
         UPDATE_TIMER.addEventListener("timer",onTimerTick);
         reset();
      }
      
      public function reset() : void
      {
         var_2416 = new Date().getTime();
         onTimerTick();
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function set align(param1:String) : void
      {
         var_134.defaultTextFormat.align = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UPDATE_TIMER.removeEventListener("timer",onTimerTick);
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get timeStamp() : Number
      {
         return var_2416;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         var_2416 = param1;
         onTimerTick();
      }
      
      private function onTimerTick(param1:TimerEvent = null) : void
      {
         if(_disposed || !var_134 || !_windowManager || !_windowManager.localization)
         {
            return;
         }
         var_134.caption = FriendlyTime.getFriendlyTime(_windowManager.localization,(new Date().getTime() - Math.abs(var_2416)) / 1000,".ago",1);
      }
   }
}

