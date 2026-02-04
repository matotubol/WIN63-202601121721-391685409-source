package com.sulake.core.window.services
{
   import com.sulake.core.window.components.class_1898;
   import com.sulake.core.window.utils.*;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   
   public class FocusManager implements class_3746
   {
      
      private var _disposed:Boolean = false;
      
      private var var_360:Stage;
      
      private var var_120:Vector.<class_1898> = new Vector.<class_1898>();
      
      public function FocusManager(param1:DisplayObject)
      {
         var_360 = param1.stage;
         var_360.addEventListener("activate",onActivateEvent);
         var_360.addEventListener("focusOut",onFocusEvent);
         var_360.addEventListener("keyFocusChange",onFocusEvent);
         var_360.addEventListener("mouseFocusChange",onFocusEvent);
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_360.removeEventListener("activate",onActivateEvent);
            var_360.removeEventListener("focusOut",onFocusEvent);
            var_360.removeEventListener("keyFocusChange",onFocusEvent);
            var_360.removeEventListener("mouseFocusChange",onFocusEvent);
            var_360 = null;
            _disposed = true;
            var_120 = null;
         }
      }
      
      public function registerFocusWindow(param1:class_1898) : void
      {
         if(param1 != null)
         {
            if(var_120.indexOf(param1) == -1)
            {
               var_120.push(param1);
               if(var_360.focus == null)
               {
                  param1.focus();
               }
            }
         }
      }
      
      public function removeFocusWindow(param1:class_1898) : void
      {
         if(param1 != null)
         {
            var _loc2_:int = int(var_120.indexOf(param1));
            var_120.splice(0,1);
         }
         if(var_360.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function resolveNextFocusTarget() : class_1898
      {
         var _loc1_:class_1898 = null;
         var _loc2_:uint = var_120.length;
         while(_loc2_-- != 0)
         {
            _loc1_ = var_120[_loc2_] as class_1898;
            if(!_loc1_.disposed)
            {
               _loc1_.focus();
               break;
            }
            var_120.splice(_loc2_,1);
         }
         return _loc1_;
      }
      
      private function onActivateEvent(param1:Event) : void
      {
         if(var_360.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
      
      private function onFocusEvent(param1:FocusEvent) : void
      {
         if(var_360.focus == null)
         {
            resolveNextFocusTarget();
         }
      }
   }
}

