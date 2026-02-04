package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingMixerItemRenderer extends FurniThumbnailRendererBase
   {
      
      private var var_2168:int;
      
      public function CraftingMixerItemRenderer(param1:CraftingFurnitureItem, param2:class_1812, param3:CraftingWidget)
      {
         super(param1,param2,param3);
      }
      
      override protected function onTriggered() : void
      {
         if(!var_16 || var_16.craftingInProgress || var_16.inventoryDirty)
         {
            return;
         }
         if(var_2168 == 0)
         {
            var_16.setInfoState(9,furnitureData);
            return;
         }
         if(var_16.inSecretRecipeMode)
         {
            var_16.mixerCtrl.removeListItem(this);
         }
      }
      
      public function returnItemToInventory() : void
      {
         if(var_2168 != 0)
         {
            var_24.returnItemToInventory(var_2168);
         }
         this.dispose();
      }
      
      override public function updateItemCount() : void
      {
         updateBitmapBlend(var_2168 != 0);
      }
      
      public function get inventoryId() : int
      {
         return var_2168;
      }
      
      public function set inventoryId(param1:int) : void
      {
         var_2168 = param1;
         updateItemCount();
      }
   }
}

