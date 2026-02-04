package com.sulake.habbo.catalog.targetedoffers.util
{
   import com.sulake.habbo.catalog.targetedoffers.OfferController;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   import flash.external.ExternalInterface;
   
   public class MallOfferExternalInterfaceHelper
   {
      
      private static const GET_HABBO_SHOP_OFFER_FUNCTION:String = "TargetedWebOffer.checkOffer";
      
      private static const GET_HABBO_SHOP_OFFER_FAILED_CALLBACK:String = "targetedWebOfferCheckFailed";
      
      private static const GET_HABBO_SHOP_OFFER_RESULT_CALLBACK:String = "targetedWebOfferCheckResponse";
      
      private var var_55:OfferController;
      
      public function MallOfferExternalInterfaceHelper(param1:OfferController)
      {
         super();
         var_55 = param1;
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("targetedWebOfferCheckResponse",onShopOfferResult);
            ExternalInterface.addCallback("targetedWebOfferCheckFailed",onShopOfferFailed);
            ExternalInterface.call("TargetedWebOffer.checkOffer");
            return;
         }
      }
      
      public function dispose() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("targetedWebOfferCheckResponse",null);
            ExternalInterface.addCallback("targetedWebOfferCheckFailed",null);
         }
         var_55 = null;
      }
      
      public function onShopOfferResult(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:HabboMallOffer = new HabboMallOffer(param1);
         if(!_loc2_)
         {
            return;
         }
         var_55.onHabboMallOffer(_loc2_);
      }
      
      public function onShopOfferFailed() : void
      {
      }
   }
}

