package com.sulake.habbo.toolbar.abstractsubmenu
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import flash.geom.Rectangle;
   
   public interface class_2372 extends class_13
   {
      
      function getIconPosition(param1:String) : Rectangle;
      
      function getIcon(param1:String) : class_1741;
      
      function getUnseenItemCounter(param1:String) : class_1812;
      
      function setUnseenItemCount(param1:String, param2:int) : void;
      
      function toggleVisibility() : void;
      
      function reposition() : void;
   }
}

