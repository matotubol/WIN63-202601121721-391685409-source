package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2375;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class ClubExtendController
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_69:ClubExtendConfirmationDialog;
      
      private var _offer:class_2375;
      
      private var _disposed:Boolean = false;
      
      public function ClubExtendController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeConfirmation();
         _offer = null;
         _catalog = null;
         _disposed = true;
      }
      
      public function onOffer(param1:HabboClubExtendOfferMessageEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:HabboClubExtendOfferMessageEventParser = param1.getParser();
         _offer = _loc2_.offer();
         showConfirmation();
         if(_catalog.connection)
         {
            if(_offer.vip)
            {
               _catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","vip.membership.extension.purchase"));
            }
            else
            {
               _catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","basic.membership.extension.purchase"));
            }
         }
      }
      
      public function closeConfirmation() : void
      {
         if(var_69)
         {
            var_69.dispose();
            var_69 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         closeConfirmation();
         var_69 = new ClubExtendConfirmationDialog(this,_offer);
         var_69.showConfirmation();
      }
      
      public function confirmSelection() : void
      {
         if(!_catalog || !_catalog.connection || !_offer)
         {
            return;
         }
         if(_catalog.getPurse().credits < _offer.priceCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_offer.vip)
         {
            _catalog.purchaseVipMembershipExtension(_offer.offerId);
         }
         else
         {
            _catalog.purchaseBasicMembershipExtension(_offer.offerId);
         }
         closeConfirmation();
      }
      
      public function get windowManager() : class_38
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.windowManager;
      }
      
      public function get localization() : class_27
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.localization;
      }
      
      public function get assets() : class_40
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.assets;
      }
      
      public function get config() : class_16
      {
         return _catalog;
      }
   }
}

