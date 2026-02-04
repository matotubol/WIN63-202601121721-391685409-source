package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import flash.text.StyleSheet;
   
   public class TargetedOfferDialogView extends OfferView
   {
      
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default.png";
      
      private var var_1048:int = 1;
      
      public function TargetedOfferDialogView(param1:OfferController, param2:TargetedOffer)
      {
         super(param1,param2);
      }
      
      public function buildWindow(param1:String) : void
      {
         if(!var_55.catalog || !var_55.catalog.windowManager)
         {
            return;
         }
         _window = class_1812(var_55.catalog.windowManager.buildFromXML(XML(var_55.catalog.assets.getAssetByName(param1).content)));
         if(class_2250(_window))
         {
            class_2250(_window).title.text = getLocalization(_offer.title);
         }
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(_offer.title);
         }
         _loc5_ = ITextWindow(_window.findChildByName("txt_description"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(_offer.description);
            setLinkStyle(_loc5_);
         }
         _loc5_ = ITextWindow(_window.findChildByName("txt_price_label"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization("targeted.offer.price.label");
         }
         var _loc6_:class_55 = var_55.catalog.utils.getPriceMap(_offer,var_1048);
         renderPrice(_window,_loc6_);
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration"));
         if(_loc3_)
         {
            var _loc2_:String = (var_55.catalog as class_16).getProperty("image.library.url");
            var _loc4_:String = getPreviewImageOverride(_offer);
            if(_loc4_ == null || null.length == 0)
            {
               _loc4_ = _offer.imageUrl && _offer.imageUrl.length > 0 ? _offer.imageUrl : "targetedoffers/offer_default.png";
            }
            _loc3_.assetUri = null + null;
         }
         var_929 = getLocalization("targeted.offer.timeleft","");
         if(_offer.expirationTime == 0)
         {
            if(_window.findChildByName("cnt_time_left"))
            {
               _window.findChildByName("cnt_time_left").visible = false;
            }
         }
         else
         {
            startUpdateTimer();
         }
         var _loc7_:ITextFieldWindow = _window.findChildByName("quantity_input") as ITextFieldWindow;
         if(_loc7_)
         {
            _loc7_.addEventListener("WKE_KEY_UP",onQuantityInputEvent);
         }
         _window.procedure = onInput;
         _window.center();
         updatePriceText();
         updateButtonStates();
      }
      
      private function renderPrice(param1:class_1812, param2:class_55) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:* = param2.getValue("credit");
         param1.findChildByName("txt_price_credits").caption = _loc3_.amount;
         var _loc4_:* = param2.getValue("activityPoint");
         if(_loc4_ != null)
         {
            param1.findChildByName("txt_price_activityPoints").caption = _loc4_.amount;
            setActivityPointIconStyle("activityPoints_icon",param1,_loc4_.activityPointType);
         }
         else
         {
            param1.findChildByName("txt_price_activityPoints").caption = "0";
            setActivityPointIconStyle("activityPoints_icon",param1,5);
         }
      }
      
      private function setActivityPointIconStyle(param1:String, param2:class_1812, param3:int) : void
      {
         var _loc4_:class_1741 = param2.findChildByName(param1);
         _loc4_.style = class_2085.getIconStyleFor(param3,var_55.catalog,true);
      }
      
      override protected function setTimeLeft(param1:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
         if(!_loc3_)
         {
            return;
         }
         _loc3_.text = param1;
         if(!var_929)
         {
            return;
         }
         var _loc4_:int = Math.max(var_929.indexOf("%timeleft%"),0);
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left_label_1"));
         if(_loc2_)
         {
            _loc2_.text = var_929.substr(0,_loc4_ - 1);
         }
         _loc2_ = ITextWindow(_window.findChildByName("txt_time_left_label_2"));
         if(_loc2_)
         {
            _loc2_.text = var_929.substr(_loc4_ + 10,var_929.length);
         }
      }
      
      public function updateButtonStates() : void
      {
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("txt_status"));
         if(!_loc4_)
         {
            return;
         }
         var _loc1_:Boolean = _offer.checkPurseBalance(var_55.catalog.getPurse(),var_1048);
         if(_loc1_)
         {
            _loc4_.text = "";
         }
         else if(_window.findChildByName("btn_buy"))
         {
            _window.findChildByName("btn_buy").disable();
         }
         if(_window.findChildByName("cnt_quantity"))
         {
            _window.findChildByName("cnt_quantity").visible = _offer.purchaseLimit > 1;
         }
         if(_window.findChildByName("btn_get_credits"))
         {
            _window.findChildByName("btn_get_credits").visible = !_loc1_;
         }
         var _loc2_:class_1741 = _window.findChildByName("btn_buy");
         if(_loc2_)
         {
            if(_loc1_ && isQuantityValid())
            {
               _loc2_.enable();
            }
            else
            {
               _loc2_.disable();
            }
         }
         var _loc3_:IItemListWindow = IItemListWindow(_window.findChildByName("itemlist_buttonbar"));
         if(_loc3_)
         {
            _loc3_.arrangeListItems();
            _loc3_.arrangeListItems();
         }
      }
      
      private function updatePriceText() : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_price_credits"));
         if(_loc2_)
         {
            _loc2_.text = var_1048 * _offer.priceInCredits + "";
         }
         var _loc1_:ITextWindow = ITextWindow(_window.findChildByName("txt_price_activityPoints"));
         if(_loc1_)
         {
            _loc1_.text = var_1048 * _offer.priceInActivityPoints + "";
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
               case "header_button_close":
                  var_55.minimizeOffer(_offer);
                  break;
               case "btn_get_credits":
                  var_55.purchaseCredits(_offer);
                  break;
               case "btn_buy":
                  if(!isQuantityValid())
                  {
                     return;
                  }
                  var_55.showConfirmation(_offer,var_1048);
            }
         }
      }
      
      private function isQuantityValid() : Boolean
      {
         return var_1048 >= 1 && var_1048 <= _offer.purchaseLimit;
      }
      
      private function onQuantityInputEvent(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:int = parseInt(param1.target.caption);
         if(_loc2_ == 0 && param1.target.caption != "" || _loc2_ > 999 || _loc2_ > _offer.purchaseLimit)
         {
            param1.target.caption = var_1048.toString();
            return;
         }
         var_1048 = _loc2_;
         updatePriceText();
         updateButtonStates();
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.textDecoration = "underline";
         _loc3_.setStyle("a:link",_loc2_);
         param1.styleSheet = _loc3_;
      }
      
      private function getPreviewImageOverride(param1:TargetedOffer) : String
      {
         return var_55.catalog.getProperty("targeted.offer.override.preview_image." + param1.id);
      }
   }
}

