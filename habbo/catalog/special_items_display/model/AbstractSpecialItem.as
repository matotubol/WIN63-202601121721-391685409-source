package com.sulake.habbo.catalog.special_items_display.model
{
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsController;
   
   public class AbstractSpecialItem implements class_2451
   {
      
      private var _index:int;
      
      private var _setKey:String;
      
      private var _itemKey:String;
      
      private var _name:String;
      
      private var _desc:String;
      
      public function AbstractSpecialItem(param1:int, param2:String, param3:String, param4:SpecialItemsController)
      {
         super();
         _index = param1;
         _setKey = param2;
         _itemKey = param3;
         _name = param4.localizationManager.getLocalization("special_items." + param2 + ".body." + param3 + ".title");
         _desc = param4.localizationManager.getLocalization("special_items." + param2 + ".body." + param3 + ".desc");
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _desc;
      }
      
      public function get itemKey() : String
      {
         return _itemKey;
      }
      
      public function get productTypeId() : int
      {
         return -1;
      }
      
      public function get itemTypeId() : String
      {
         return "";
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return null;
      }
      
      public function get isValid() : Boolean
      {
         return false;
      }
   }
}

