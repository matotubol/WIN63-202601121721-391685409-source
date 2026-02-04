package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2052;
   import flash.geom.Rectangle;
   
   public class WindowToggle implements class_13
   {
      
      public static const RESULT_SHOW:int = 0;
      
      public static const RESULT_ACTIVATE:int = 1;
      
      public static const RESULT_HIDE:int = 2;
      
      private var _window:class_1741;
      
      private var var_22:class_2052;
      
      private var _disposed:Boolean;
      
      private var var_2342:Function;
      
      private var _hideFunction:Function;
      
      public function WindowToggle(param1:class_1741, param2:class_2052, param3:Function = null, param4:Function = null)
      {
         super();
         _window = param1;
         var_22 = param2;
         var_2342 = param3;
         _hideFunction = param4;
      }
      
      public static function isHiddenByOtherWindows(param1:class_1741) : Boolean
      {
         var _loc8_:class_1741 = null;
         var _loc7_:int = 0;
         var _loc3_:class_2052 = param1.desktop;
         var _loc5_:int = int(_loc3_.numChildren);
         var _loc6_:int = int(_loc3_.getChildIndex(param1));
         if(_loc6_ < 0)
         {
            throw new Error("Window must be contained by the desktop!");
         }
         var _loc2_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc2_);
         var _loc4_:Rectangle = new Rectangle();
         _loc7_ = _loc6_ + 1;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc3_.getChildAt(_loc7_);
            if(_loc8_.visible)
            {
               _loc8_.getGlobalRectangle(_loc4_);
               if(_loc2_.intersects(_loc4_))
               {
                  return true;
               }
            }
            _loc7_++;
         }
         return false;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      public function get visible() : Boolean
      {
         return _window && _window.visible && _window.parent;
      }
      
      public function get active() : Boolean
      {
         return visible && _window.getStateFlag(1);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            var_22 = null;
            _disposed = true;
            var_2342 = null;
            _hideFunction = null;
         }
      }
      
      public function show() : void
      {
         if(!_window.disposed)
         {
            if(_window.parent != var_22)
            {
               var_22.addChild(_window);
            }
            if(!_window.visible)
            {
               _window.visible = true;
            }
            _window.activate();
         }
      }
      
      public function hide() : void
      {
         if(!_window.disposed)
         {
            if(_window.parent == var_22)
            {
               var_22.removeChild(_window);
            }
            if(_window.visible)
            {
               _window.visible = false;
            }
            _window.deactivate();
         }
      }
      
      public function toggle() : void
      {
         if(visible)
         {
            if(active)
            {
               _hideFunction == null ? hide() : _hideFunction.call();
            }
            else if(isHiddenByOtherWindows(_window))
            {
               _window.activate();
            }
            else
            {
               _hideFunction == null ? hide() : _hideFunction.call();
            }
         }
         else
         {
            var_2342 == null ? show() : var_2342.call();
         }
      }
   }
}

