package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4079;
   
   public class MintableItemWrapper implements IRenderableCollectibleItem
   {
      
      private var var_2863:class_4079;
      
      private var _amount:int;
      
      public function MintableItemWrapper(param1:class_4079, param2:int)
      {
         super();
         var_2863 = param1;
         _amount = param2;
      }
      
      public function get productTypeId() : int
      {
         switch(var_2863.itemType)
         {
            case "i":
               return 0;
            case "s":
               return 1;
            case "cl":
               return 11;
            default:
               return -1;
         }
      }
      
      public function get itemTypeId() : String
      {
         return String(var_2863.itemTypeId);
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(param1:int) : void
      {
         _amount = param1;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
      
      public function get productItem() : class_4079
      {
         return var_2863;
      }
   }
}

