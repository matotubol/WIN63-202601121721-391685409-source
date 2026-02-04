package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.renderer.CraftingInventoryItemRenderer;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingInventoryListController extends CraftingGridControllerBase
   {
      
      private var _items:Vector.<CraftingInventoryItemRenderer>;
      
      public function CraftingInventoryListController(param1:CraftingWidget)
      {
         super(param1);
         _items = new Vector.<CraftingInventoryItemRenderer>(0);
      }
      
      override public function dispose() : void
      {
         clearItems();
         super.dispose();
      }
      
      public function clearItems() : void
      {
         if(_items)
         {
            for each(var _loc1_ in _items)
            {
               _loc1_.dispose();
            }
            _items.length = 0;
         }
         if(container)
         {
            container.destroyGridItems();
         }
      }
      
      public function populateInventoryItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:CraftingInventoryItemRenderer = null;
         if(!container)
         {
            return;
         }
         var _loc2_:class_1812 = getItemTemplate();
         container.removeGridItems();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new CraftingInventoryItemRenderer(param1[_loc4_],_loc2_.clone() as class_1812,var_16);
            container.addGridItem(_loc3_.window);
            _items.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function updateItemCounts() : void
      {
         for each(var _loc1_ in _items)
         {
            _loc1_.updateItemCount();
         }
      }
      
      private function get container() : IItemGridWindow
      {
         return mainWindow ? mainWindow.findChildByName("itemgrid_inventory") as IItemGridWindow : null;
      }
   }
}

