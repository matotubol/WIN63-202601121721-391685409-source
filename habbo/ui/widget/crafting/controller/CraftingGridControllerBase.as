package com.sulake.habbo.ui.widget.crafting.controller
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   
   public class CraftingGridControllerBase
   {
      
      protected var var_16:CraftingWidget;
      
      public function CraftingGridControllerBase(param1:CraftingWidget)
      {
         super();
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         var_16 = null;
      }
      
      public function get mainWindow() : class_1812
      {
         return var_16.window;
      }
      
      public function getItemTemplate() : class_1812
      {
         return var_16.itemTemplate;
      }
   }
}

