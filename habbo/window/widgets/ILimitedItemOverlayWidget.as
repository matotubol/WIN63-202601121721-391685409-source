package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface ILimitedItemOverlayWidget extends class_1901
   {
      
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
      
      function get serialNumber() : int;
      
      function get seriesSize() : int;
   }
}

