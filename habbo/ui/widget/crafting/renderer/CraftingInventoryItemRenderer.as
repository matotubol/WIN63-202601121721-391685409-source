package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingInventoryItemRenderer extends FurniThumbnailRendererBase
   {
      
      public function CraftingInventoryItemRenderer(param1:CraftingFurnitureItem, param2:class_1812, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!var_16 || var_16.craftingInProgress || var_16.inventoryDirty)
         {
            return;
         }
         if(!var_16.mixerCtrl.canAdd())
         {
            return;
         }
         var _loc1_:int = content.getItemToMixer();
         if(_loc1_ == 0)
         {
            return;
         }
         var_16.showSecretRecipeView();
         var_16.mixerCtrl.addItemToMixer(content,_loc1_);
         var_16.inventoryCtrl.updateItemCounts();
      }
      
      override public function updateItemCount() : void
      {
         if(content)
         {
            updateGroupItemCount(content.countInInventory);
            updateBitmapBlend(content.countInInventory > 0);
         }
      }
   }
}

