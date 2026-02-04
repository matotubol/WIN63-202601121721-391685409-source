package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferPurchaseConfirmationView extends OfferView
   {
      
      private var var_1048:int;
      
      public function TargetedOfferPurchaseConfirmationView(param1:OfferController, param2:TargetedOffer, param3:int)
      {
         super(param1,param2);
         var_1048 = param3;
         _window = class_1812(var_55.catalog.windowManager.buildFromXML(XML(var_55.catalog.assets.getAssetByName("targeted_offer_purchase_confirmation_xml").content)));
         var _loc4_:HabboCatalog = var_55.catalog as HabboCatalog;
         if(_loc4_.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            _window.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         ITextWindow(_window.findChildByName("product_name")).text = getLocalization(param2.title);
         var _loc5_:class_1812 = _window.findChildByName("purchase_cost_box") as class_1812;
         _loc4_.utils.showPriceInContainer(_loc5_,param2,param3);
         var _loc6_:ITextWindow = _window.findChildByName("quantity") as ITextWindow;
         if(_loc6_ != null)
         {
            if(param1.catalog.multiplePurchaseEnabled && var_1048 > 1)
            {
               _loc6_.text = "X " + var_1048;
            }
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_1741 = _window.findChildByName("select_button");
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
      
      private function onInput(param1:class_1758, param2:class_1741) : void
      {
         if(!var_55)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "spending_disclaimer":
                  setDisclaimerAccepted(class_1885(param2).isSelected);
                  break;
               case "header_button_close":
               case "cancel_button":
                  var_55.maximizeOffer(_offer);
                  break;
               case "buy_button":
                  var_55.purchaseTargetedOffer(_offer,var_1048);
            }
         }
      }
   }
}

