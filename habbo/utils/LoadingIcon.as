package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.IIconWindow;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class LoadingIcon implements class_13
   {
      
      private static const FRAMES:Array = [23,24,25,26];
      
      private var var_323:Timer = new Timer(160);
      
      private var _icon:IIconWindow;
      
      private var var_1567:int;
      
      public function LoadingIcon()
      {
         super();
         var_323.addEventListener("timer",onTimer);
      }
      
      public function dispose() : void
      {
         if(var_323)
         {
            var_323.removeEventListener("timer",onTimer);
            var_323.stop();
            var_323 = null;
         }
         _icon = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_323 == null;
      }
      
      public function setVisible(param1:IIconWindow, param2:Boolean) : void
      {
         _icon = param1;
         if(_icon == null)
         {
            return;
         }
         _icon.visible = param2;
         if(param2)
         {
            _icon.style = FRAMES[var_1567];
            var_323.start();
         }
         else
         {
            var_323.stop();
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         if(_icon == null)
         {
            return;
         }
         var_1567 = var_1567 + 1;
         if(var_1567 >= FRAMES.length)
         {
            var_1567 = 0;
         }
         _icon.style = FRAMES[var_1567];
      }
   }
}

