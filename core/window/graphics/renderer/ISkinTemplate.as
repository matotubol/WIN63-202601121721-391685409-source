package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.utils.IChildEntityArray;
   import com.sulake.core.window.utils.class_2142;
   
   public interface ISkinTemplate extends IChildEntityArray, class_2142
   {
      
      function get asset() : IAsset;
      
      function dispose() : void;
   }
}

