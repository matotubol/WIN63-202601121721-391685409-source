package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1892;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface class_1770 extends class_13
   {
      
      function set debug(param1:Boolean) : void;
      
      function render() : void;
      
      function addToRenderQueue(param1:class_1741, param2:Rectangle, param3:uint) : void;
      
      function flushRenderQueue() : void;
      
      function invalidate(param1:class_1892, param2:Rectangle) : void;
      
      function getDrawBufferForRenderable(param1:class_1741) : BitmapData;
      
      function purge(param1:class_1741 = null, param2:Boolean = true) : void;
   }
}

