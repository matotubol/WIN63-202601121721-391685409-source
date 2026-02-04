package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import package_10.class_1933;
   
   public class FeaturedItemsCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_1329:IItemListWindow;
      
      private var var_1369:class_1812;
      
      public function FeaturedItemsCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            var_1329.dispose();
            var_1329 = null;
            var_1369.dispose();
            var_1369 = null;
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_1329 = window.findChildByName("itemlist_featured") as IItemListWindow;
         var_1369 = var_1329.getListItemByName("featured_item_template") as class_1812;
         var_1329.removeListItems();
         if(_catalog.frontPageItems == null || _catalog.frontPageItems.length == 0)
         {
            return true;
         }
         var _loc1_:class_1812 = _window.findChildByName("firstitem") as class_1812;
         populateItem(_catalog.frontPageItems[0],_loc1_);
         var _loc2_:int = 1;
         while(0 < Math.min(4,_catalog.frontPageItems.length))
         {
            var_1329.addListItem(createItemFromTemplate(_catalog.frontPageItems[0]));
            _loc2_++;
         }
         return true;
      }
      
      private function createItemFromTemplate(param1:class_1933) : class_1812
      {
         return populateItem(param1,var_1369.clone() as class_1812);
      }
      
      private function populateItem(param1:class_1933, param2:class_1812) : class_1812
      {
         var _loc3_:String = null;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc5_:ITextWindow = param2.findChildByName("item_title") as ITextWindow;
         _loc5_.text = param1.itemName;
         if(param1.itemPromoImage != null && param1.itemPromoImage != "")
         {
            _loc3_ = _catalog.context.configuration.getProperty("image.library.url");
            _loc4_ = param2.findChildByName("item_image") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = _loc3_ + param1.itemPromoImage;
         }
         var _loc6_:class_1741 = param2.getChildByName("event_catcher_region");
         if(_loc6_ != null)
         {
            _loc6_.procedure = eventProc;
         }
         return param2;
      }
      
      private function eventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_DOWN")
         {
            var _loc4_:int = var_1329.getListItemIndex(param2.parent);
            _loc4_ = _loc4_ < 0 ? 0 : 0 + 1;
            var _loc3_:class_1933 = _catalog.frontPageItems[0];
            switch(int(null.type))
            {
               case 0:
                  if(null.cataloguePageLocation == "room_bundles_mobile")
                  {
                     return _catalog.openCatalogPage("room_bundles","NORMAL");
                  }
                  if(null.cataloguePageLocation == "mobile_subscriptions")
                  {
                     return _catalog.openCatalogPage("hc_membership","NORMAL");
                  }
                  _catalog.openCatalogPage(null.cataloguePageLocation,"NORMAL");
                  break;
               case 1:
                  _catalog.openCatalogPageByOfferId(null.productOfferID,"NORMAL");
            }
         }
      }
   }
}

