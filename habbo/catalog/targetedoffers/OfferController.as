package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import com.sulake.habbo.catalog.targetedoffers.util.MallOfferExternalInterfaceHelper;
   import com.sulake.habbo.session.product.class_59;
   import package_10.class_2310;
   import package_10.class_3198;
   import package_13.class_2831;
   import package_13.class_3103;
   import package_13.class_3369;
   import package_13.class_3376;
   import package_6.class_3055;
   import package_71.class_2196;
   
   public class OfferController implements class_59
   {
      
      private var _offerDialog:TargetedOfferDialogView;
      
      private var var_2076:MallOfferDialogView;
      
      private var var_1714:class_13;
      
      private var var_2083:TargetedOfferPurchaseConfirmationView;
      
      private var var_2309:MallOfferExternalInterfaceHelper;
      
      private var _catalog:HabboCatalog;
      
      private var _disposed:Boolean;
      
      public function OfferController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _catalog.connection.addMessageEvent(new class_2310(onTargetedOffer));
         _catalog.connection.addMessageEvent(new class_3198(onTargetedOfferNotFound));
         _catalog.events.addEventListener("catalog_purse_update",onPurseUpdate);
         _catalog.sessionDataManager.addProductsReadyEventListener(this);
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         destroyView();
         if(var_2309)
         {
            var_2309.dispose();
            var_2309 = null;
         }
      }
      
      public function productDataReady() : void
      {
         _catalog.connection.send(new class_3369());
      }
      
      private function onTargetedOffer(param1:class_2310) : void
      {
         var _loc3_:class_3055 = param1.getParser();
         var _loc2_:TargetedOffer = new TargetedOffer(_loc3_.data);
         if(_loc2_.trackingState == 4)
         {
            minimizeOffer(_loc2_);
         }
         else
         {
            maximizeOffer(_loc2_);
         }
      }
      
      private function onTargetedOfferNotFound(param1:class_3198) : void
      {
         var_2309 = new MallOfferExternalInterfaceHelper(this);
      }
      
      public function onHabboMallOffer(param1:HabboMallOffer) : void
      {
         if(param1.trackingState == 2)
         {
            return;
         }
         switch(param1.trackingState)
         {
            case 0:
            case 5:
            case 6:
               maximizeMallOffer(param1);
               break;
            case 2:
               return;
            default:
               minimizeMallOffer(param1);
         }
      }
      
      public function maximizeMallOffer(param1:HabboMallOffer) : void
      {
         if(var_2076)
         {
            return;
         }
         destroyView();
         var_2076 = new MallOfferDialogView(this,param1);
         _catalog.connection.send(new class_2831(param1.targetedOfferId,6));
      }
      
      public function minimizeMallOffer(param1:HabboMallOffer, param2:Boolean = false) : void
      {
         destroyView();
         var_1714 = new MallOfferMinimizedView(this,param1);
      }
      
      public function onHabboMallOfferOpened(param1:HabboMallOffer) : void
      {
         _catalog.connection.send(new class_2831(param1.targetedOfferId,1));
         _catalog.openCreditsHabblet();
         minimizeMallOffer(param1);
      }
      
      public function onHabboMallOfferClosed(param1:HabboMallOffer) : void
      {
         _catalog.connection.send(new class_2831(param1.targetedOfferId,4));
         minimizeMallOffer(param1);
      }
      
      public function minimizeOffer(param1:TargetedOffer) : void
      {
         destroyView();
         var_1714 = new TargetedOfferMinimizedView(this,param1);
         _catalog.connection.send(new class_3103(param1.id,4));
      }
      
      public function maximizeOffer(param1:TargetedOffer) : void
      {
         if(_offerDialog)
         {
            return;
         }
         destroyView();
         if(!param1.isExpired())
         {
            var _loc2_:String = getLayoutOverride(param1);
            _offerDialog = new TargetedOfferDialogView(this,param1);
            _offerDialog.buildWindow("targeted_offer_dialog_xml");
            _catalog.connection.send(new class_3103(param1.id,1));
         }
      }
      
      public function purchaseTargetedOffer(param1:TargetedOffer, param2:int) : void
      {
         _catalog.connection.send(new class_3376(param1.id,param2));
         param1.purchased(param2);
         if(param1.purchaseLimit > 0)
         {
            minimizeOffer(param1);
         }
         else
         {
            destroyView();
         }
      }
      
      public function sendLogEvent(param1:String, param2:String = "") : void
      {
         if(!_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new class_2196("TargetedOffers","FLASH.UNKNOWN",param1,param2));
      }
      
      public function purchaseCredits(param1:TargetedOffer) : void
      {
         sendLogEvent("targeted.offer.open.credits.page.clicked",param1.identifier);
         _catalog.openCreditsHabblet();
      }
      
      public function attachExtension(param1:class_1741) : void
      {
         _catalog.toolbar.extensionView.attachExtension("targeted_offer",param1,13);
      }
      
      public function showConfirmation(param1:TargetedOffer, param2:int) : void
      {
         if(var_2083)
         {
            return;
         }
         destroyView();
         var_2083 = new TargetedOfferPurchaseConfirmationView(this,param1,param2);
      }
      
      private function onPurseUpdate(param1:PurseUpdateEvent) : void
      {
         if(_offerDialog)
         {
            _offerDialog.updateButtonStates();
         }
      }
      
      public function destroyView() : void
      {
         if(_offerDialog)
         {
            _offerDialog.dispose();
            _offerDialog = null;
         }
         if(var_2076)
         {
            var_2076.dispose();
            var_2076 = null;
         }
         if(var_1714)
         {
            _catalog.toolbar.extensionView.detachExtension("targeted_offer");
            var_1714.dispose();
            var_1714 = null;
         }
         if(var_2083)
         {
            var_2083.dispose();
            var_2083 = null;
         }
      }
      
      private function getLayoutOverride(param1:TargetedOffer) : String
      {
         return _catalog.getProperty("targeted.offer.override.layout." + param1.id);
      }
   }
}

