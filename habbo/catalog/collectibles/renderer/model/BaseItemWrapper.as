package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   
   public class BaseItemWrapper implements IRenderableCollectibleItem
   {
      
      private var var_1913:class_2870;
      
      public function BaseItemWrapper(param1:class_2870)
      {
         super();
         var_1913 = param1;
      }
      
      public function get productTypeId() : int
      {
         return var_1913.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return var_1913.itemTypeId;
      }
      
      public function get petFigureString() : String
      {
         return var_1913.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_1913.figureSetIds;
      }
      
      public function get baseItem() : class_2870
      {
         return var_1913;
      }
      
      public function get amount() : int
      {
         return 0;
      }
   }
}

