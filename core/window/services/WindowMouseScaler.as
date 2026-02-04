package com.sulake.core.window.services
{
   import flash.display.DisplayObject;
   
   public class WindowMouseScaler extends WindowMouseOperator implements IMouseScalingService
   {
      
      public function WindowMouseScaler(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function operate(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         if(!_window.disposed)
         {
            _loc3_ = var_2654 & 0x1000 ? param1 - _mouse.x : 0;
            var _loc4_:int = var_2654 & 0x2000 ? param2 - _mouse.y : 0;
            _window.scale(_loc3_,_loc4_);
         }
      }
   }
}

