package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class FirstProductSelectorCatalogWidget extends CatalogWidget implements class_2612
   {
      
      public function FirstProductSelectorCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         if(page.offers.length == 0)
         {
            return;
         }
         var _loc2_:class_1793 = page.offers[0];
         events.dispatchEvent(new SelectProductEvent(_loc2_));
      }
   }
}

