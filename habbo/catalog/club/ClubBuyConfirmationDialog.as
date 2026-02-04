package com.sulake.habbo.catalog.club
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.purse.class_1831;
   import com.sulake.habbo.localization.class_27;
   
   public class ClubBuyConfirmationDialog
   {
      
      private var _offer:ClubBuyOfferData;
      
      private var var_55:ClubBuyController;
      
      private var var_18:class_2250;
      
      private var var_2228:int;
      
      public function ClubBuyConfirmationDialog(param1:ClubBuyController, param2:ClubBuyOfferData, param3:int)
      {
         super();
         _offer = param2;
         var_55 = param1;
         var_2228 = param3;
         showConfirmation();
      }
      
      public function dispose() : void
      {
         var_55 = null;
         _offer = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !var_55)
         {
            return;
         }
         var_18 = var_55.catalog.utils.createWindow("club_buy_confirmation") as class_2250;
         if(!var_18)
         {
            return;
         }
         var_18.procedure = windowEventHandler;
         var_18.center();
         if(var_55.catalog.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            var_18.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         var _loc1_:class_27 = var_55.localization;
         var _loc4_:class_1831 = var_55.getPurse();
         var _loc5_:String = _loc4_.hasClubLeft && _loc4_.isVIP ? "extension." : "subscription.";
         var _loc3_:String = _offer.months == 0 ? "days" : "months";
         var _loc2_:String = "catalog.vip.buy.confirm." + _loc5_ + _loc3_;
         _loc1_.registerParameter(_loc2_,"num_" + _loc3_,String(_offer.months == 0 ? _offer.extraDays : _offer.months));
         var_18.findChildByName("subscription_name").caption = _loc1_.getLocalization(_loc2_);
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","day",String(_offer.day));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","month",String(_offer.month));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","year",String(_offer.year));
         var_55.catalog.utils.showPriceInContainer(var_18.findChildByName("purchase_cost_box") as class_1812,_offer);
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(var_18 == null)
         {
            return;
         }
         var _loc2_:class_1741 = var_18.findChildByName("select_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2 || !var_55 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOUBLE_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "spending_disclaimer":
               setDisclaimerAccepted(class_1885(param2).isSelected);
               break;
            case "select_button":
               var_55.catalog.doNotCloseAfterVipPurchase();
               var_55.confirmSelection(_offer,var_2228);
               break;
            case "header_button_close":
            case "cancel_button":
               var_55.catalog.forgetPageDuringVipPurchase();
               var_55.closeConfirmation();
         }
      }
   }
}

