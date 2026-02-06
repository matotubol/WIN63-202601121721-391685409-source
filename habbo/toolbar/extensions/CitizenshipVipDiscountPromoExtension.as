package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class CitizenshipVipDiscountPromoExtension
   {
      
      private var _toolbar:HabboToolbar;
      
      private var var_18:class_1993;
      
      private var _expanded:Boolean = true;
      
      private var var_4284:int = 216;
      
      private var var_1063:Timer;
      
      public function CitizenshipVipDiscountPromoExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      private function createWindow() : class_1993
      {
         var _loc2_:IAsset = _toolbar.assets.getAssetByName("vip_discount_promotion_v2_xml");
         if(_loc2_)
         {
            var _loc1_:class_1993 = _toolbar.windowManager.buildFromXML(_loc2_.content as XML,1) as class_1993;
         }
         return null;
      }
      
      private function destroyWindow() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         destroyExpirationTimer();
      }
      
      private function get extensionView() : IExtensionView
      {
         return _toolbar.extensionView;
      }
      
      public function dispose() : void
      {
         if(_toolbar == null)
         {
            return;
         }
         if(extensionView != null)
         {
            extensionView.detachExtension("club_promo");
         }
         destroyWindow();
         _toolbar = null;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_toolbar.inventory.clubLevel == 2)
         {
            _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo","citizenshipdiscount","client.club.extend.discount.clicked"));
            _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
         }
      }
      
      private function assignState() : void
      {
         var_18.findChildByName("content_itemlist").visible = _expanded;
         var_18.findChildByName("promo_img").visible = _expanded;
         var_18.height = _expanded ? var_4284 : 33;
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.citizenshipVipIsExpiring && var_18 == null && isExtensionEnabled())
         {
            var_18 = createWindow();
            if(var_1063 != null)
            {
               destroyExpirationTimer();
            }
            if(_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0)
            {
               var_1063 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000,1);
               var_1063.addEventListener("timerComplete",onExtendOfferExpire);
               var_1063.start();
            }
            assignState();
            if(!_toolbar.extensionView.hasExtension("vip_quests"))
            {
               _toolbar.extensionView.attachExtension("club_promo",var_18,10);
            }
         }
         else
         {
            _toolbar.extensionView.detachExtension("vip_quests");
            destroyWindow();
         }
      }
      
      private function destroyExpirationTimer() : void
      {
         if(var_1063)
         {
            var_1063.stop();
            var_1063.removeEventListener("timerComplete",onExtendOfferExpire);
            var_1063 = null;
         }
      }
      
      private function onExtendOfferExpire(param1:TimerEvent) : void
      {
         _toolbar.extensionView.detachExtension("club_promo");
         destroyWindow();
      }
      
      private function isExtensionEnabled() : Boolean
      {
         return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
      }
      
      private function onMinMax(param1:WindowMouseEvent) : void
      {
         _expanded = !_expanded;
         assignState();
      }
   }
}

