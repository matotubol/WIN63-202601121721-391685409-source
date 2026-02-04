package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import flash.display.BitmapData;
   
   public interface class_1857 extends class_1829, class_13
   {
      
      function get productType() : String;
      
      function get productClassId() : int;
      
      function set extraParam(param1:String) : void;
      
      function get extraParam() : String;
      
      function get productCount() : int;
      
      function get productData() : class_1949;
      
      function get furnitureData() : class_1800;
      
      function get isUniqueLimitedItem() : Boolean;
      
      function get isColorable() : Boolean;
      
      function get uniqueLimitedItemSeriesSize() : int;
      
      function get uniqueLimitedItemsLeft() : int;
      
      function set uniqueLimitedItemsLeft(param1:int) : void;
      
      function initIcon(param1:class_2557, param2:class_1829 = null, param3:class_259 = null, param4:class_1793 = null, param5:class_2251 = null, param6:IStuffData = null, param7:Function = null) : BitmapData;
      
      function set view(param1:class_1812) : void;
      
      function set grid(param1:IItemGrid) : void;
   }
}

