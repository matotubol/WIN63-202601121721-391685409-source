package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.renderer.CraftingRecipeItemRenderer;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   import com.sulake.habbo.communication.messages.parser.crafting.class_2347;
   
   public class CraftingRecipeListController extends CraftingGridControllerBase
   {
      
      private var var_2552:CraftingFurnitureItem;
      
      private var _items:Vector.<CraftingRecipeItemRenderer>;
      
      public function CraftingRecipeListController(param1:CraftingWidget)
      {
         super(param1);
         _items = new Vector.<CraftingRecipeItemRenderer>(0);
      }
      
      override public function dispose() : void
      {
         clearItems();
         var_2552 = null;
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
      
      public function populateRecipeItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:CraftingRecipeItemRenderer = null;
         if(!container)
         {
            return;
         }
         var _loc2_:class_1812 = getItemTemplate();
         container.removeGridItems();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new CraftingRecipeItemRenderer(param1[_loc4_],_loc2_.clone() as class_1812,var_16);
            container.addGridItem(_loc3_.window);
            _items.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function showRecipe(param1:CraftingFurnitureItem, param2:Vector.<class_2347>) : void
      {
         var_2552 = param1;
         if(!param2)
         {
            var_16.setInfoState(7);
            return;
         }
         var_16.mixerCtrl.clearItems();
         var _loc10_:Boolean = true;
         var _loc6_:Vector.<String> = new Vector.<String>(0);
         for each(var _loc5_ in param2)
         {
            var _loc7_:Boolean = false;
            var _loc9_:class_1800 = var_16.sessionDataManager.getFloorItemDataByName(_loc5_.furnitureClassName);
            if(!_loc9_)
            {
               _loc9_ = var_16.sessionDataManager.getWallItemDataByName(_loc5_.furnitureClassName);
               _loc7_ = true;
               return;
            }
            var _loc4_:Array = var_16.handler.container.inventory.getNonRentedInventoryIds("furni",null.id,false);
            if(_loc4_ == null || null.length < _loc5_.count)
            {
               _loc10_ = false;
            }
            var _loc8_:int = 0;
            while(0 < _loc5_.count)
            {
               var _loc11_:CraftingFurnitureItem = new CraftingFurnitureItem(null,null,null);
               var _loc3_:int = 0;
               if(_loc6_.indexOf(null.localizedName) == -1)
               {
                  _loc6_.push(null.localizedName);
               }
               var_16.mixerCtrl.addItemToMixer(null,0);
               _loc8_++;
            }
         }
         if(_loc10_)
         {
            var_16.setInfoState(8,var_2552.furnitureData);
         }
         else
         {
            var_16.setInfoState(7,var_2552.furnitureData,_loc6_);
         }
      }
      
      private function get container() : IItemGridWindow
      {
         return mainWindow ? mainWindow.findChildByName("itemgrid_products") as IItemGridWindow : null;
      }
   }
}

