package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   
   public interface class_2253 extends class_13
   {
      
      function get view() : class_1812;
      
      function set view(param1:class_1812) : void;
      
      function set grid(param1:IItemGrid) : void;
      
      function setDraggable(param1:Boolean) : void;
      
      function activate() : void;
      
      function deactivate() : void;
   }
}

