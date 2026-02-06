package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.localization.class_27;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2375;
   
   public class ClubExtendConfirmationDialog
   {
      
      private static const CREDIT_IMAGE_COUNT:int = 7;
      
      private static const YOUR_PRICE_ICON_BITMAP_ELEMENT_NAME:String = "your_price_icon_left";
      
      private static const const_474:String = "${image.library.catalogue.url}catalogue/vip_extend_tsr.png";
      
      private static const TEASER_IMAGE_MIME_TYPE:String = "image/png";
      
      private static const ANIMATION_TRIGGER_INTERVAL:int = 2000;
      
      private static const const_846:int = 75;
      
      private static const LINK_COLOR_DEFAULT:uint = 0;
      
      private static const LINK_COLOR_HOVER:uint = 9552639;
      
      private var var_55:ClubExtendController;
      
      private var var_18:class_2250;
      
      private var _offer:class_2375;
      
      private var var_1240:IRegionWindow;
      
      private var var_1061:ITextWindow;
      
      private var var_707:class_2251;
      
      private var var_1145:Vector.<BitmapData>;
      
      private var var_1482:Timer;
      
      private var var_713:Timer;
      
      private var _animationFrame:int = 0;
      
      private var var_1983:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var _localizationKey:String = "catalog.club.extend.";
      
      public function ClubExtendConfirmationDialog(param1:ClubExtendController, param2:class_2375)
      {
         super();
         var_55 = param1;
         _offer = param2;
         var_1145 = new Vector.<BitmapData>(7);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _offer = null;
         var_55 = null;
         clearAnimation();
         if(var_1240)
         {
            var_1240.removeEventListener("WME_OUT",onMouseOutLaterRegion);
            var_1240.removeEventListener("WME_OVER",onMouseOverLaterRegion);
            var_1240 = null;
         }
         if(var_1061)
         {
            var_1061 = null;
         }
         if(var_707)
         {
            var_707 = null;
         }
         if(!var_1145)
         {
            if(var_18)
            {
               var_18.dispose();
               var_18 = null;
            }
            _disposed = true;
            return;
         }
         while(true)
         {
            var_1145[0].dispose();
            var_1145[0] = null;
            _loc1_++;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !var_55 || _disposed)
         {
            return;
         }
         var_18 = createWindow("club_extend_confirmation") as class_2250;
         if(!var_18)
         {
            return;
         }
         var_18.procedure = windowEventHandler;
         var_18.center();
         if(!_offer.vip)
         {
            _localizationKey += "basic.";
            var _loc10_:IIconWindow = var_18.findChildByName("club_level_icon") as IIconWindow;
            if(_loc10_)
            {
               null.style = 17;
               null.x += 15;
            }
         }
         var _loc3_:class_27 = var_55.localization;
         var_18.findChildByName("normal_price_price_left").caption = _offer.originalPrice.toString();
         var_18.findChildByName("normal_price_price_right").caption = _offer.originalActivityPointPrice.toString();
         var_18.findChildByName("you_save_price_left").caption = _offer.discountCreditAmount.toString();
         var_18.findChildByName("you_save_price_right").caption = _offer.discountActivityPointAmount.toString();
         var_18.findChildByName("your_price_price_left").caption = _offer.priceCredits.toString();
         var_18.findChildByName("your_price_price_right").caption = _offer.priceActivityPoints.toString();
         var_18.title.caption = _loc3_.getLocalization(_localizationKey + "confirm.caption");
         var_18.findChildByName("extend_title").caption = _loc3_.getLocalization(_localizationKey + "confirm.title");
         var_18.findChildByName("normal_price_label").caption = _loc3_.getLocalization(_localizationKey + "normal.label");
         var_18.findChildByName("you_save_label").caption = _loc3_.getLocalization(_localizationKey + "save.label");
         var_18.findChildByName("your_price_label").caption = _loc3_.getLocalization(_localizationKey + "price.label");
         var_18.findChildByName("buy_now_button").caption = _loc3_.getLocalization(_localizationKey + "buy.button");
         var_18.findChildByName("maybe_later_link").caption = _loc3_.getLocalization(_localizationKey + "later.link");
         if(_offer.subscriptionDaysLeft > 1)
         {
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","day",_offer.subscriptionDaysLeft.toString());
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","duration",(31 * _offer.months).toString());
            var _loc11_:String = _loc3_.getLocalization(_localizationKey + "expiration_days_left");
         }
         else
         {
            _loc11_ = _loc3_.getLocalization(_localizationKey + "expires_today");
         }
         var_18.findChildByName("offer_expiration").caption = null;
         var_1240 = var_18.findChildByName("maybe_later_region") as IRegionWindow;
         var_1061 = var_18.findChildByName("maybe_later_link") as ITextWindow;
         if(!var_1240 || !var_1061)
         {
            return;
         }
         var_1240.addEventListener("WME_OUT",onMouseOutLaterRegion);
         var_1240.addEventListener("WME_OVER",onMouseOverLaterRegion);
         var _loc5_:BitmapData = getBitmapDataFromAsset("icon_credit_0");
         setElementBitmapData("normal_price_icon_left",_loc5_);
         setElementBitmapData("you_save_icon_left",_loc5_);
         setActivityPointIconStyle("normal_price_icon_right");
         setActivityPointIconStyle("you_save_icon_right");
         setActivityPointIconStyle("your_price_icon_right");
         var _loc1_:class_2251 = var_18.findChildByName("club_teaser") as class_2251;
         _loc1_.x = 1;
         _loc1_.y = var_18.height - 144;
         _loc1_.height = 144;
         _loc1_.width = 133;
         var _loc7_:String = var_55.config.interpolate("${image.library.catalogue.url}catalogue/vip_extend_tsr.png");
         if(var_55.config)
         {
            _loc7_ = var_55.config.updateUrlProtocol(_loc7_);
         }
         loadAssetFromUrl("club_teaser","club_teaser",_loc7_,"image/png",onTeaserLoaded);
         var _loc9_:IItemListWindow = var_18.findChildByName("itemlist_vertical") as IItemListWindow;
         if(!_loc9_)
         {
            return;
         }
         var _loc4_:class_1812 = var_18.findChildByName("total_amount_line") as class_1812;
         if(!_loc4_)
         {
            return;
         }
         var _loc2_:class_1812 = var_18.findChildByName("background_container") as class_1812;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.height = _loc9_.y + _loc4_.height + _loc4_.y;
         var_707 = var_18.findChildByName("your_price_icon_left") as class_2251;
         if(var_707 == null)
         {
            return;
         }
         var _loc8_:int = 0;
         while(true)
         {
            var _loc6_:BitmapDataAsset = var_55.assets.getAssetByName("icon_credit_" + 0) as BitmapDataAsset;
            var _loc12_:BitmapData = _loc6_.content as BitmapData;
            var_1145[0] = null.clone();
            _loc8_++;
         }
      }
      
      private function setActivityPointIconStyle(param1:String) : void
      {
         var _loc2_:class_1741 = var_18.findChildByName(param1);
         _loc2_.style = class_2085.getIconStyleFor(_offer.originalActivityPointType,var_55.config,true);
      }
      
      private function onMouseOutLaterRegion(param1:WindowMouseEvent) : void
      {
         if(var_1061)
         {
            var_1061.textColor = 0;
         }
      }
      
      private function onMouseOverLaterRegion(param1:WindowMouseEvent) : void
      {
         if(var_1061)
         {
            var_1061.textColor = 9552639;
         }
      }
      
      private function startAnimation() : void
      {
         if(var_1482)
         {
            clearAnimation();
         }
         setAnimationFrame();
         var_1482 = new Timer(2000);
         var_1482.addEventListener("timer",onAnimationTrigger);
         var_1482.start();
      }
      
      private function clearAnimation() : void
      {
         _animationFrame = 0;
         var_1983 = 0;
         if(var_713)
         {
            var_713.stop();
            var_713 = null;
         }
         if(var_1482)
         {
            var_1482.stop();
            var_1482 = null;
         }
      }
      
      private function setAnimationFrame() : void
      {
         if(!var_707)
         {
            return;
         }
         if(var_707.bitmap)
         {
            var_707.bitmap.dispose();
         }
         if(_animationFrame < 7)
         {
            var_707.bitmap = new BitmapData(var_707.width,var_707.height,true,0);
            var_707.bitmap.copyPixels(var_1145[_animationFrame],var_1145[_animationFrame].rect,new Point(0,0));
         }
         else
         {
            class_21.log("Animation frame " + _animationFrame);
         }
      }
      
      private function startAnimationFrame() : void
      {
         var_713 = new Timer(75,7 - 1);
         var_713.addEventListener("timer",onAnimationFrame);
         var_713.addEventListener("timerComplete",onAnimationFrameComplete);
         var_713.start();
      }
      
      private function onAnimationTrigger(param1:TimerEvent) : void
      {
         startAnimationFrame();
      }
      
      private function onAnimationFrame(param1:TimerEvent) : void
      {
         _animationFrame += 1;
         setAnimationFrame();
      }
      
      private function onAnimationFrameComplete(param1:TimerEvent) : void
      {
         if(var_713)
         {
            var_713.stop();
            var_713 = null;
         }
         _animationFrame = 0;
         setAnimationFrame();
         if(var_1983 == 0)
         {
            var_1983 = 1;
            startAnimationFrame();
         }
         else
         {
            var_1983 = 0;
         }
      }
      
      private function getBitmapDataFromAsset(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = var_55.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function setElementBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc3_:class_2251 = var_18.findChildByName(param1) as class_2251;
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
         }
         if(param2 != null && _loc3_ != null)
         {
            if(_loc3_.width != param2.width)
            {
               _loc3_.width = param2.width;
            }
            if(_loc3_.height != param2.height)
            {
               _loc3_.height = param2.height;
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function loadAssetFromUrl(param1:String, param2:String, param3:String, param4:String, param5:Function) : Boolean
      {
         var _loc8_:BitmapData = getBitmapDataFromAsset(param2);
         if(_loc8_ != null)
         {
            setElementBitmapData(param1,_loc8_);
            return true;
         }
         var _loc6_:URLRequest = new URLRequest(param3);
         var _loc7_:AssetLoaderStruct = var_55.assets.loadAssetFromFile(param2,_loc6_,param4);
         if(!_loc7_)
         {
            return false;
         }
         _loc7_.addEventListener("AssetLoaderEventComplete",param5);
         return true;
      }
      
      private function onTeaserLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:BitmapData = null;
         if(!_disposed)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               _loc3_ = getBitmapDataFromAsset(_loc2_.assetName);
               setElementBitmapData("club_teaser",_loc3_);
            }
         }
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(!param1 || !param2 || !var_55 || !_offer || _disposed)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "buy_now_button":
               var_55.confirmSelection();
               break;
            case "header_button_close":
            case "maybe_later_region":
               var_55.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : class_1741
      {
         if(!var_55 || !var_55.assets || !var_55.windowManager || _disposed)
         {
            return null;
         }
         var _loc3_:XmlAsset = var_55.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return var_55.windowManager.buildFromXML(_loc2_);
      }
   }
}

