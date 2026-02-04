package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface class_1902 extends class_1901
   {
      
      function set productInfo(param1:IProductDisplayInfo) : *;
      
      function get productInfo() : IProductDisplayInfo;
      
      function clearPreviewer() : void;
      
      function setPlaceholder() : void;
      
      function get pivot() : uint;
      
      function set pivot(param1:uint) : void;
      
      function set blend(param1:Number) : *;
      
      function get blend() : Number;
   }
}

