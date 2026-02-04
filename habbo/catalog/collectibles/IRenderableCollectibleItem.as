package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public interface IRenderableCollectibleItem extends IProductDisplayInfo
   {
      
      function get amount() : int;
   }
}

