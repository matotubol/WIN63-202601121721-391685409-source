package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
   import com.sulake.habbo.room.class_1829;
   import flash.display.BitmapData;
   
   public class ExtraInfoBonusBadgeItem extends ExtraInfoListItem implements class_1829
   {
      
      private var _catalog:HabboCatalog;
      
      public function ExtraInfoBonusBadgeItem(param1:int, param2:ExtraInfoItemData, param3:HabboCatalog)
      {
         super(null,param1,param2,0);
         _catalog = param3;
      }
      
      override public function getRenderedWindow() : class_1812
      {
         return null;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

