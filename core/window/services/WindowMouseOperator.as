package com.sulake.core.window.services
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class WindowMouseOperator implements class_13
   {
      
      protected var var_134:DisplayObject;
      
      protected var _window:WindowController;
      
      protected var var_1394:Boolean;
      
      protected var _offset:Point;
      
      protected var _mouse:Point;
      
      protected var var_388:Point;
      
      protected var var_2654:uint;
      
      private var _disposed:Boolean = false;
      
      public function WindowMouseOperator(param1:DisplayObject)
      {
         super();
         var_134 = param1;
         var_388 = new Point();
         _mouse = new Point();
         _offset = new Point();
         var_1394 = false;
         var_2654 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _offset = null;
         _mouse = null;
         var_388 = null;
         var_134 = null;
         _disposed = true;
      }
      
      public function begin(param1:class_1741, param2:uint = 0) : class_1741
      {
         var_2654 = param2;
         var _loc3_:class_1741 = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            var_134.addEventListener("mouseDown",handler,false);
            var_134.addEventListener("mouseUp",handler,false);
            var_134.addEventListener("enterFrame",handler);
            _mouse.x = var_134.mouseX;
            _mouse.y = var_134.mouseY;
            _window = WindowController(param1);
            getMousePositionRelativeTo(param1,_mouse,_offset);
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            var_1394 = true;
         }
         return _loc3_;
      }
      
      public function end(param1:class_1741) : class_1741
      {
         var _loc2_:class_1741 = _window;
         if(var_1394)
         {
            if(_window == param1)
            {
               var_134.removeEventListener("mouseDown",handler,false);
               var_134.removeEventListener("mouseUp",handler,false);
               var_134.removeEventListener("enterFrame",handler);
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
      
      protected function handler(param1:Event) : void
      {
         var _loc2_:MouseEvent = null;
         if(var_1394)
         {
            if(param1.type == "enterFrame")
            {
               if(_window.disposed)
               {
                  end(_window);
               }
               else if(_mouse.x != var_134.mouseX || _mouse.y != var_134.mouseY)
               {
                  operate(var_134.mouseX,var_134.mouseY);
                  _mouse.x = var_134.mouseX;
                  _mouse.y = var_134.mouseY;
               }
               return;
            }
            _loc2_ = param1 as MouseEvent;
            if(_loc2_ != null)
            {
               var _loc3_:* = _loc2_.type;
               if("mouseUp" === _loc3_)
               {
                  end(_window);
               }
            }
         }
      }
      
      public function operate(param1:int, param2:int) : void
      {
         _mouse.x = param1;
         _mouse.y = param2;
         getMousePositionRelativeTo(_window,_mouse,var_388);
         _window.offset(var_388.x - _offset.x,var_388.y - _offset.y);
      }
      
      private function clientWindowDestroyed(param1:class_1758) : void
      {
         end(_window);
      }
      
      protected function getMousePositionRelativeTo(param1:class_1741, param2:Point, param3:Point) : void
      {
         param1.getGlobalPosition(param3);
         param3.x = param2.x - param3.x;
         param3.y = param2.y - param3.y;
      }
   }
}

