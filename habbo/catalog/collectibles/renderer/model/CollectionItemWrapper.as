package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4130;
   
   public class CollectionItemWrapper implements IRenderableCollectibleItem
   {
      
      private var var_1653:class_4130;
      
      public function CollectionItemWrapper(param1:class_4130)
      {
         super();
         var_1653 = param1;
      }
      
      public function get productTypeId() : int
      {
         return var_1653.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return var_1653.itemTypeId;
      }
      
      public function get amount() : int
      {
         return var_1653.amount;
      }
      
      public function get petFigureString() : String
      {
         return var_1653.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_1653.figureSetIds;
      }
      
      public function get collectionItem() : class_4130
      {
         return var_1653;
      }
   }
}

