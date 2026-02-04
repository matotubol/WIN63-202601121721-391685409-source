package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.ui.widget.crafting.*;
   import com.sulake.habbo.ui.widget.crafting.renderer.CraftingMixerItemRenderer;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingMixerController extends CraftingGridControllerBase
   {
      
      private static const MAX_ITEMS:int = 10;
      
      private var _renderers:Vector.<CraftingMixerItemRenderer>;
      
      public function CraftingMixerController(param1:CraftingWidget)
      {
         super(param1);
         _renderers = new Vector.<CraftingMixerItemRenderer>(0);
      }
      
      override public function dispose() : void
      {
         returnItemsToInventory();
         super.dispose();
      }
      
      public function returnItemsToInventory() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CraftingMixerItemRenderer = null;
         _loc2_ = 0;
         while(_loc2_ < _renderers.length)
         {
            _loc1_ = _renderers[_loc2_];
            if(_loc1_)
            {
               _loc1_.returnItemToInventory();
            }
            _loc2_++;
         }
         _renderers.length = 0;
         if(container)
         {
            container.destroyGridItems();
         }
         if(var_16 && var_16.inventoryCtrl)
         {
            var_16.inventoryCtrl.updateItemCounts();
         }
      }
      
      public function clearItems() : void
      {
         returnItemsToInventory();
         if(container)
         {
            container.destroyGridItems();
         }
      }
      
      public function canAdd() : Boolean
      {
         return _renderers.length < 10;
      }
      
      public function addItemToMixer(param1:CraftingFurnitureItem, param2:int) : Boolean
      {
         if(!container)
         {
            return false;
         }
         var _loc3_:class_1812 = getItemTemplate();
         var _loc4_:CraftingMixerItemRenderer = new CraftingMixerItemRenderer(param1,_loc3_.clone() as class_1812,var_16);
         _loc4_.inventoryId = param2;
         container.addGridItem(_loc4_.window);
         _renderers.push(_loc4_);
         if(var_16.inSecretRecipeMode)
         {
            var_16.mixerContentChanged(collectSelectedFurnitureIds());
         }
         return true;
      }
      
      public function removeListItem(param1:CraftingMixerItemRenderer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CraftingMixerItemRenderer = null;
         if(!container)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _renderers.length)
         {
            _loc2_ = _renderers[_loc3_];
            if(_loc2_ == param1)
            {
               _renderers.splice(_loc3_,1);
               if(_loc2_.window)
               {
                  container.removeGridItem(_loc2_.window);
                  container.rebuildGridStructure();
               }
               _loc2_.returnItemToInventory();
               var_16.inventoryCtrl.updateItemCounts();
               var_16.mixerContentChanged(collectSelectedFurnitureIds());
               return;
            }
            _loc3_++;
         }
      }
      
      public function collectSelectedFurnitureIds() : Vector.<int>
      {
         var _loc2_:int = 0;
         var _loc1_:CraftingMixerItemRenderer = null;
         var _loc3_:Vector.<int> = new Vector.<int>(0);
         _loc2_ = 0;
         while(_loc2_ < _renderers.length)
         {
            _loc1_ = _renderers[_loc2_];
            if(_loc1_)
            {
               _loc3_.push(_loc1_.inventoryId);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function get container() : IItemGridWindow
      {
         return mainWindow ? mainWindow.findChildByName("itemgrid_mixer") as IItemGridWindow : null;
      }
   }
}

