package com.sulake.core.window.services
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class WindowMouseListener extends WindowMouseOperator implements IMouseListenerService
   {
      
      private var var_2303:Array = [];
      
      private var var_2014:uint = 0;
      
      public function WindowMouseListener(param1:DisplayObject)
      {
         super(param1);
      }
      
      public function get eventTypes() : Array
      {
         return var_2303;
      }
      
      public function get areaLimit() : uint
      {
         return var_2014;
      }
      
      public function set areaLimit(param1:uint) : void
      {
         var_2014 = param1;
      }
      
      override public function end(param1:class_1741) : class_1741
      {
         var _loc2_:int = 0;
         _loc2_ = int(var_2303.length);
         while(_loc2_ > 0)
         {
            var_2303.pop();
            _loc2_--;
         }
         return super.end(param1);
      }
      
      override protected function handler(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(var_1394 && !_window.disposed)
         {
            if(var_2303.indexOf(param1.type) >= 0)
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc2_ = _window.hitTestGlobalPoint(new Point(WindowMouseEvent(param1).stageX,WindowMouseEvent(param1).stageY));
                  if(var_2014 == 1 && !_loc2_)
                  {
                     return;
                  }
                  if(var_2014 == 3 && _loc2_)
                  {
                     return;
                  }
               }
               _window.update(null,WindowMouseEvent(param1));
            }
         }
      }
      
      override public function operate(param1:int, param2:int) : void
      {
      }
   }
}

