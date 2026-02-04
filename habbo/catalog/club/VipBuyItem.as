package com.sulake.habbo.catalog.club
{
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.localization.class_27;
   
   public class VipBuyItem implements class_13
   {
      
      private var _offer:ClubBuyOfferData;
      
      private var _window:class_1812;
      
      private var _catalog:HabboCatalog;
      
      private var _disposed:Boolean = false;
      
      private var var_5206:String;
      
      public function VipBuyItem(param1:ClubBuyOfferData, param2:HabboCatalog, param3:String)
      {
         super();
         _offer = param1;
         _catalog = param2;
         var_5206 = param3;
         _window = _catalog.utils.createWindow("vip_buy_item") as class_1812;
         var _loc5_:class_27 = _catalog.localization;
         if(param1.months > 0)
         {
            _loc5_.registerParameter("catalog.vip.item.header.months","num_months",String(param1.months));
            var _loc4_:ILocalization = _loc5_.getLocalizationRaw("catalog.vip.item.header.months");
         }
         else
         {
            _loc5_.registerParameter("catalog.vip.item.header.days","num_days",String(param1.extraDays));
            _loc4_ = _loc5_.getLocalizationRaw("catalog.vip.item.header.days");
         }
         _window.findChildByName("item_header").caption = "-";
         _catalog.utils.showPriceInContainer(_window.findChildByName("item_price") as class_1812,_offer);
         _window.findChildByName("item_buy").addEventListener("WME_CLICK",onBuy);
         if(param1.giftable)
         {
            _window.findChildByName("item_gift").addEventListener("WME_CLICK",onGift);
         }
         else
         {
            _window.findChildByName("item_gift").visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _window.dispose();
            _window = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onBuy(param1:WindowMouseEvent) : void
      {
         _catalog.purchaseWillBeGift(false);
         _catalog.showPurchaseConfirmation(_offer,_offer.page?.pageId);
      }
      
      private function onGift(param1:WindowMouseEvent) : void
      {
         _catalog.purchaseWillBeGift(true);
         _catalog.showPurchaseConfirmation(_offer,_offer.page?.pageId);
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
   }
}

