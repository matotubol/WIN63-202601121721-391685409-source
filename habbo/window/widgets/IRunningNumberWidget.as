package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface IRunningNumberWidget extends class_1901
   {
      
      function get number() : int;
      
      function set number(param1:int) : void;
      
      function set initialNumber(param1:int) : void;
      
      function get digits() : uint;
      
      function set digits(param1:uint) : void;
      
      function get colorStyle() : int;
      
      function set colorStyle(param1:int) : void;
      
      function get updateFrequency() : int;
      
      function set updateFrequency(param1:int) : void;
   }
}

