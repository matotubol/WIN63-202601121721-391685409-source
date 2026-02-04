package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RenderableShopNftItem implements IProductDisplayInfo
   {
      
      private var var_452:class_2870;
      
      public function RenderableShopNftItem(param1:class_2870)
      {
         super();
         var_452 = param1;
      }
      
      public function get item() : class_2870
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

