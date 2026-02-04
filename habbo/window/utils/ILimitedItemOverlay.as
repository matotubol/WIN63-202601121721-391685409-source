package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   
   public interface ILimitedItemOverlay extends class_13
   {
      
      function get window() : class_1812;
      
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
   }
}

