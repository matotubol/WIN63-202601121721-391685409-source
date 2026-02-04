package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class SimplePriceCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_758:class_1741;
      
      public function SimplePriceCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var_758 = _catalog.utils.showPriceOnProduct(param1.offer,_window as class_1812,var_758,_window.findChildByName("fake_productimage"),0,true,0);
      }
   }
}

