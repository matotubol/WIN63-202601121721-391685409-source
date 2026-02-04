package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   
   public class ExtraInfoBundlesInfoItem extends ExtraInfoListItem
   {
      
      private var _catalog:HabboCatalog;
      
      private var _window:class_1812;
      
      private var var_16:BundlePurchaseExtraInfoWidget;
      
      public function ExtraInfoBundlesInfoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(param1,param2,param3,2,true);
         _catalog = param4;
         var_16 = param1;
      }
      
      override public function getRenderedWindow() : class_1812
      {
         if(_window == null)
         {
            createWindow();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = class_1812(_catalog.utils.createWindow("bundlesInfoItem"));
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_16.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
         }
      }
   }
}

