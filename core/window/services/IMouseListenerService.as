package com.sulake.core.window.services
{
   import com.sulake.core.window.class_1741;
   
   public interface IMouseListenerService
   {
      
      function get eventTypes() : Array;
      
      function get areaLimit() : uint;
      
      function set areaLimit(param1:uint) : void;
      
      function dispose() : void;
      
      function begin(param1:class_1741, param2:uint = 0) : class_1741;
      
      function end(param1:class_1741) : class_1741;
   }
}

