package com.sulake.habbo.ui.widget.crafting.utils
{
   import com.sulake.habbo.session.furniture.class_1800;
   import flash.events.EventDispatcher;
   
   public class CraftingFurnitureItem extends EventDispatcher
   {
      
      private var var_4750:String;
      
      private var var_2711:String;
      
      private var var_587:class_1800;
      
      private var var_1728:Vector.<int>;
      
      private var var_2990:Vector.<int>;
      
      public function CraftingFurnitureItem(param1:String, param2:String, param3:class_1800)
      {
         super();
         var_4750 = param1;
         var_2711 = param2;
         var_587 = param3;
         var_1728 = new Vector.<int>(0);
         var_2990 = new Vector.<int>(0);
      }
      
      public function get recipeCode() : String
      {
         return var_4750;
      }
      
      public function get furnitureData() : class_1800
      {
         return var_587;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get typeId() : int
      {
         return var_587 ? var_587.id : -1;
      }
      
      public function get countInInventory() : int
      {
         return var_1728 ? var_1728.length : 0;
      }
      
      public function set inventoryIds(param1:Vector.<int>) : void
      {
         var_1728 = param1;
      }
      
      public function getItemToMixer() : int
      {
         if(countInInventory == 0)
         {
            return 0;
         }
         var _loc1_:int = int(var_1728.shift());
         var_2990.push(_loc1_);
         return _loc1_;
      }
      
      public function returnItemToInventory(param1:int) : void
      {
         var_1728.push(param1);
         var_2990.splice(var_2990.indexOf(param1),1);
      }
   }
}

