package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.utils.DefaultAttStruct;
   
   public interface ISkinContainer extends class_13
   {
      
      function getSkinRendererByTypeAndStyle(param1:uint, param2:uint) : ISkinRenderer;
      
      function getDefaultAttributesByTypeAndStyle(param1:uint, param2:uint) : DefaultAttStruct;
      
      function getTheActualState(param1:uint, param2:uint, param3:uint) : uint;
   }
}

