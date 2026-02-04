package com.sulake.habbo.ui.widget.crafting.renderer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   
   public class CraftingRecipeItemRenderer extends FurniThumbnailRendererBase
   {
      
      public function CraftingRecipeItemRenderer(param1:CraftingFurnitureItem, param2:class_1812, param3:CraftingWidget)
      {
         super(param1,param2,param3);
         hideItemCount();
      }
      
      override protected function onTriggered() : void
      {
         if(!var_16 || !content || var_16.craftingInProgress)
         {
            return;
         }
         var_16.showCraftableProduct(content);
      }
   }
}

