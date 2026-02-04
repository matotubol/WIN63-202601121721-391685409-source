package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.class_2044;
   import com.sulake.habbo.localization.class_27;
   
   public class ClubBuyItem
   {
      
      private var _offer:ClubBuyOfferData;
      
      private var _window:class_1812;
      
      private var var_215:class_2044;
      
      public function ClubBuyItem(param1:ClubBuyOfferData, param2:class_2044)
      {
         super();
         _offer = param1;
         var_215 = param2;
         if(param1.vip)
         {
            var _loc5_:XML = getAssetXML("club_buy_vip_item");
         }
         else
         {
            _loc5_ = getAssetXML("club_buy_hc_item");
         }
         _window = var_215.viewer.catalog.windowManager.buildFromXML(null) as class_1812;
         var _loc4_:class_27 = (param2.viewer.catalog as HabboCatalog).localization;
         _loc4_.registerParameter("catalog.club.item.header","months",String(param1.months));
         var _loc3_:ILocalization = _loc4_.getLocalizationRaw("catalog.club.item.header");
         _window.findChildByName("item_header").caption = null.value;
         _loc4_.registerParameter("catalog.club.price","price",String(param1.priceCredits));
         _loc3_ = _loc4_.getLocalizationRaw("catalog.club.price");
         _window.findChildByName("item_price").caption = null.value;
         var _loc6_:class_1775 = _window.findChildByName("item_buy") as class_1775;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onBuy);
         }
      }
      
      public function dispose() : void
      {
         _window.dispose();
      }
      
      private function onBuy(param1:WindowMouseEvent) : void
      {
         HabboCatalog(var_215.viewer.catalog).showPurchaseConfirmation(_offer,var_215.pageId);
      }
      
      private function getAssetXML(param1:String) : XML
      {
         if(!var_215 || !var_215.viewer || !var_215.viewer.catalog || !var_215.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = var_215.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
   }
}

