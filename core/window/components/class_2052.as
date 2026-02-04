package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import flash.geom.Point;
   
   public interface class_2052 extends class_1812, class_1970
   {
      
      function get mouseX() : int;
      
      function get mouseY() : int;
      
      function getActiveWindow() : class_1741;
      
      function setActiveWindow(param1:class_1741) : class_1741;
      
      function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint = 0) : void;
   }
}

