package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import package_111.class_3106;
   
   public class RenderableTradeNftItem implements IProductDisplayInfo
   {
      
      private var var_452:class_3106;
      
      public function RenderableTradeNftItem(param1:class_3106)
      {
         super();
         var_452 = param1;
      }
      
      public function get item() : class_3106
      {
         return var_452;
      }
      
      public function get productTypeId() : int
      {
         return var_452.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return var_452.itemTypeId;
      }
      
      public function get petFigureString() : String
      {
         return var_452.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_452.figureSetIds;
      }
   }
}

