package com.sulake.habbo.catalog
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.club.VipBenefitsWindow;
   import com.sulake.habbo.catalog.purse.class_2085;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.room.utils.ColorConverter;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1766;
   
   public class HabboCatalogUtils implements class_13, class_1829
   {
      
      private static const PRICE_CREDIT:String = "credit";
      
      private static const PRICE_SILVER:String = "silver";
      
      private static const PRICE_ACTIVITY_POINT:String = "activityPoint";
      
      private static const DEFAULT_ACTIVITY_POINTS_PRICE_COLOR:* = 9032648;
      
      private var BADGE_CHATSTYLE_WIDGET_NAME:String = "HCU_dynamic_badge";
      
      private var _disposed:Boolean = false;
      
      private var _catalog:HabboCatalog;
      
      private var var_1521:VipBenefitsWindow;
      
      private var var_2232:Array = new Array(0);
      
      private var var_2931:int;
      
      private var _productBitmapWrappers:Dictionary = new Dictionary();
      
      private var var_4630:Boolean = false;
      
      private var var_4556:Boolean = false;
      
      private var var_4905:Boolean = false;
      
      public function HabboCatalogUtils(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public static function buildersClub(param1:String) : Boolean
      {
         return param1.indexOf("builders_club") == 0 || param1.indexOf("loyalty_bc") == 0;
      }
      
      public static function replaceCenteredImage(param1:class_2251, param2:BitmapData, param3:Rectangle = null) : void
      {
         if(!param1.bitmap)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         else
         {
            param1.bitmap.fillRect(param1.bitmap.rect,0);
         }
         var _loc5_:BitmapData = param1.bitmap;
         var _loc4_:Rectangle = param3 ?? param2.rect;
         _loc5_.copyPixels(param2,_loc4_,new Point((_loc5_.width - _loc4_.width) / 2,(_loc5_.height - _loc4_.height) / 2),null,null,true);
         param1.invalidate();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1521 != null)
            {
               var_1521.dispose();
               var_1521 = null;
            }
            _catalog = null;
            _productBitmapWrappers = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function createWindow(param1:String, param2:uint = 1, param3:class_55 = null) : class_1741
      {
         var _loc5_:Array = null;
         var _loc6_:class_2251 = null;
         if(_catalog.windowManager == null || _catalog.assets == null)
         {
            return null;
         }
         var _loc9_:XmlAsset = _catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc9_ == null || _loc9_.content == null)
         {
            return null;
         }
         var _loc8_:class_1741 = _catalog.windowManager.buildFromXML(_loc9_.content as XML,param2,param3);
         var _loc4_:class_1812 = _loc8_ as class_1812;
         if(_loc4_ != null)
         {
            _loc5_ = [];
            _loc4_.groupChildrenWithTag("bitmap",_loc5_,-1);
            for each(var _loc7_ in _loc5_)
            {
               _loc6_ = _loc7_ as class_2251;
               if(_loc6_ != null)
               {
                  _loc6_.disposesBitmap = false;
                  setCatalogItemImage(_loc6_,_loc6_.bitmapAssetName);
               }
            }
         }
         return _loc8_;
      }
      
      public function showPriceInContainer(param1:class_1812, param2:class_1793, param3:int = 1, param4:Boolean = false, param5:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc6_:Array = getPriceArray(param2,param3,param4);
         renderPriceInContainer(param1,_loc6_,param4,param5,false);
      }
      
      private function renderPriceInContainer(param1:class_1812, param2:Array, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc7_:IItemListWindow = createPriceContainer(param1);
         if(_loc7_ == null)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            renderPriceItem(_loc7_,_loc6_,param2[_loc6_],param3,param4,param5);
            _loc6_++;
         }
         var _loc8_:int = _loc6_ * 2 + 2;
         while(_loc7_.numListItems > _loc8_)
         {
            _loc7_.removeListItemAt(_loc8_ - 1);
         }
         param1.addChild(_loc7_);
      }
      
      private function renderPriceItem(param1:IItemListWindow, param2:int, param3:Object, param4:Boolean, param5:Boolean, param6:Boolean) : void
      {
         var _loc7_:ITextWindow = param1.getListItemByName("amount_" + param2) as ITextWindow;
         var _loc8_:IIconWindow = IIconWindow(param1.getListItemByName("unit_" + param2));
         _loc7_.text = param6 ? "" : (param2 > 0 ? "+ " : "") + param3.amount;
         _loc8_.style = class_2085.getIconStyleFor(param3.unit,_catalog,true,param5);
         _loc8_.width = param4 && param5 ? 53 : 22;
         _loc8_.fitToSize();
      }
      
      private function createPriceContainer(param1:class_1812) : IItemListWindow
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IItemListWindow = createWindow("price_display") as IItemListWindow;
         if(_loc2_ == null)
         {
            return null;
         }
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0).dispose();
         }
         return _loc2_;
      }
      
      private function getPriceArray(param1:class_1793, param2:int, param3:Boolean) : Array
      {
         var _loc4_:Array = [];
         if(param1.priceInCredits > 0)
         {
            var _loc6_:int = calculateBundlePrice(param1.bundlePurchaseAllowed,param1.priceInCredits,param2);
            var _loc5_:int = int(param3 ? _catalog.getSeasonalCurrencyActivityPointType() : -1);
            _loc4_.push({
               "amount":0,
               "unit":-1
            });
         }
         if(param1.priceInActivityPoints > 0)
         {
            _loc6_ = calculateBundlePrice(param1.bundlePurchaseAllowed,param1.priceInActivityPoints,param2);
            _loc4_.push({
               "amount":0,
               "unit":param1.activityPointType
            });
         }
         if(param1.priceInSilver > 0)
         {
            _loc4_.push({
               "amount":param1.priceInSilver,
               "unit":1000
            });
         }
         if(param1.priceInEmerald > 0)
         {
            _loc4_.push({
               "amount":param1.priceInEmerald,
               "unit":1001
            });
         }
         if(_loc4_.length == 0)
         {
            _loc4_.push({
               "amount":0,
               "unit":-1
            });
         }
         return _loc4_;
      }
      
      public function getPriceMap(param1:class_1793, param2:int) : class_55
      {
         var _loc3_:class_55 = new class_55();
         if(param1.priceInCredits > 0)
         {
            var _loc4_:int = calculateBundlePrice(param1.bundlePurchaseAllowed,param1.priceInCredits,param2);
            _loc3_.add("credit",{"amount":0});
         }
         if(param1.priceInActivityPoints > 0)
         {
            _loc4_ = calculateBundlePrice(param1.bundlePurchaseAllowed,param1.priceInActivityPoints,param2);
            _loc3_.add("activityPoint",{
               "amount":0,
               "activityPointType":param1.activityPointType
            });
         }
         if(param1.priceInSilver > 0)
         {
            _loc3_.add("silver",{"amount":param1.priceInSilver});
         }
         if(_loc3_.length == 0)
         {
            _loc3_.add("credit",{"amount":0});
         }
         return _loc3_;
      }
      
      public function showPriceOnProduct(param1:class_1793, param2:class_1812, param3:class_1741, param4:class_1741, param5:int, param6:Boolean, param7:int, param8:Boolean = false, param9:Boolean = false) : class_1741
      {
         if(param3 != null)
         {
            param2.removeChild(param3);
            param3.dispose();
         }
         if(_catalog.catalogType == "BUILDERS_CLUB")
         {
            return null;
         }
         param3 = _catalog.utils.createWindow("priceDisplayWidget");
         param2.addChild(param3);
         var _loc11_:class_1812 = param2.findChildByName("price_box_new") as class_1812;
         if(_loc11_ != null)
         {
            _catalog.utils.showPriceInContainer(_loc11_,param1,1,param8,param9);
            var _loc10_:class_1741 = param2.findChildByName("room_canvas_container");
            if(_loc10_ == null)
            {
               _loc10_ = param4;
            }
            if(param1.priceInActivityPoints == 0)
            {
               param3.color = 14992765;
            }
            if(param1.priceInCredits == 0)
            {
               if(param1.activityPointType == 0)
               {
                  param3.color = 11257559;
               }
               else if(class_2085.isSeasonal(param1.activityPointType))
               {
                  param3.color = getSeasonalCurrencyPriceColor(param1.activityPointType);
               }
               else
               {
                  param3.color = 9032648;
               }
            }
            if(param1.priceInSilver > 0)
            {
               param3.color = 15790320;
            }
         }
         return param3;
      }
      
      private function getSeasonalCurrencyPriceColor(param1:int) : uint
      {
         if(!class_2085.isSeasonal(param1))
         {
            return 9032648;
         }
         var _loc3_:String = _catalog.getProperty("seasonalcurrency.id." + param1);
         if(_loc3_ == "")
         {
            return 9032648;
         }
         var _loc2_:String = _catalog.getProperty("seasonalcurrency." + _loc3_ + ".color");
         if(_loc2_ == "")
         {
            return 9032648;
         }
         return ColorConverter.hexToUint(_catalog.getProperty("seasonalcurrency.preset." + _loc2_ + ".border"));
      }
      
      public function showExtraOnProduct(param1:int, param2:String, param3:class_1812, param4:int, param5:int, param6:Boolean = true, param7:Boolean = true) : void
      {
         var _loc12_:BitmapData = null;
         var _loc8_:class_1812 = param3.findChildByName(BADGE_CHATSTYLE_WIDGET_NAME) as class_1812;
         if(_loc8_ == null)
         {
            _loc8_ = createWindow("badgeDisplayWidget") as class_1812;
            _loc8_.name = BADGE_CHATSTYLE_WIDGET_NAME;
         }
         var _loc11_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc8_.findChildByName("asset_image"));
         var _loc13_:class_2010 = _loc8_.findChildByName("badge_image") as class_2010;
         var _loc9_:class_3087 = _loc13_.widget as class_3087;
         var _loc10_:class_2251 = _loc8_.findChildByName("chat_style") as class_2251;
         if(param1 == 9)
         {
            _loc11_.assetUri = "catalogue_chatstyle_background";
            _loc13_.visible = false;
            _loc10_.visible = true;
            _loc12_ = _catalog.freeFlowChat.chatStyleLibrary.getStyle(int(param2)).selectorPreview.clone();
            _loc10_.bitmap = _loc12_;
         }
         else if(param1 == 4)
         {
            _loc11_.assetUri = "catalogue_badge_background";
            _loc13_.visible = true;
            _loc10_.visible = false;
            _loc9_.badgeId = param2;
         }
         _loc8_.width = _loc11_.width;
         _loc8_.height = _loc11_.height;
         param3.addChild(_loc8_);
         _loc8_.x = param7 ? param4 : param3.width - _loc8_.width - param4;
         _loc8_.y = param6 ? param5 : param3.height - _loc8_.height - param5;
      }
      
      public function hideExtraFromProduct(param1:class_1812) : void
      {
         var _loc2_:class_1812 = param1.findChildByName(BADGE_CHATSTYLE_WIDGET_NAME) as class_1812;
         if(_loc2_)
         {
            param1.removeChild(_loc2_);
         }
      }
      
      public function showAssetImageAsBadgeOnProduct(param1:String, param2:class_1812, param3:int, param4:int, param5:Boolean = true, param6:Boolean = true) : void
      {
         var _loc7_:class_1812 = param2.findChildByName(BADGE_CHATSTYLE_WIDGET_NAME) as class_1812;
         if(_loc7_ == null)
         {
            _loc7_ = createWindow("badgeDisplayWidget") as class_1812;
            _loc7_.name = BADGE_CHATSTYLE_WIDGET_NAME;
         }
         _loc7_.findChildByName("chat_style").visible = false;
         _loc7_.findChildByName("badge_image").visible = false;
         var _loc8_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc7_.findChildByName("badge_image"));
         _loc8_.assetUri = param1;
         _loc7_.width = _loc8_.width;
         _loc7_.height = _loc8_.height;
         param2.addChild(_loc7_);
         _loc7_.x = param6 ? param3 : param2.width - _loc7_.width - param3;
         _loc7_.y = param5 ? param4 : param2.height - _loc7_.height - param4;
      }
      
      public function setCatalogItemImage(param1:class_2251, param2:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc6_:IAsset = _catalog.assets.getAssetByName(param2);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc6_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1.bitmap != null)
         {
            param1.bitmap.dispose();
            param1.bitmap = null;
         }
         if(param1.bitmap == null)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         var _loc4_:int = (param1.width - _loc3_.width) * 0.5;
         var _loc5_:int = (param1.height - _loc3_.height) * 0.5;
         param1.bitmap.draw(_loc3_,new Matrix(1,0,0,1,_loc4_,_loc5_));
      }
      
      public function showVipBenefits() : void
      {
         if(_catalog.getBoolean("catalog.vip.benefits.enabled"))
         {
            if(var_1521 == null || var_1521.disposed)
            {
               var_1521 = new VipBenefitsWindow(_catalog);
            }
         }
         else
         {
            openLink(_catalog.getProperty("link.format.club"));
         }
      }
      
      public function openLink(param1:String) : void
      {
         if(param1 != "")
         {
            _catalog.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLinkAlertClose);
            HabboWebTools.openWebPage(param1,"habboMain");
         }
      }
      
      private function onExternalLinkAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      public function calculateBundlePrice(param1:Boolean, param2:int, param3:int) : int
      {
         return param2 * param3;
      }
      
      public function getDiscountItemsCount(param1:int) : int
      {
         var _loc2_:int = getBasicBundleDiscountSize(param1);
         _loc2_ += getBonusBundleDiscountSize(param1);
         return int(_loc2_ + getThresholdBundleDiscountSize(param1));
      }
      
      private function getBasicBundleDiscountSize(param1:int) : int
      {
         var _loc3_:class_1766 = _catalog.bundleDiscountRuleset;
         if(!_loc3_ || _loc3_.bundleSize <= 0)
         {
            return 0;
         }
         var _loc2_:int = param1 / _loc3_.bundleSize;
         return _loc2_ * _loc3_.bundleDiscountSize;
      }
      
      private function getBonusBundleDiscountSize(param1:int) : int
      {
         var _loc3_:class_1766 = _catalog.bundleDiscountRuleset;
         if(!_loc3_ || _loc3_.bundleSize <= 0)
         {
            return 0;
         }
         var _loc2_:int = param1 / _loc3_.bundleSize;
         if(_loc2_ >= _loc3_.bonusThreshold)
         {
            var _loc4_:int = param1 % _loc3_.bundleSize;
            if(_loc4_ == _loc3_.bundleSize - 1)
            {
               _loc5_++;
            }
            var _loc5_:int = 0 + (_loc2_ - _loc3_.bonusThreshold);
         }
         return 0;
      }
      
      private function getThresholdBundleDiscountSize(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:class_1766 = _catalog.bundleDiscountRuleset;
         if(_loc2_)
         {
            for each(var _loc3_ in _loc2_.additionalBonusDiscountThresholdQuantities)
            {
               if(param1 >= _loc3_)
               {
                  _loc4_++;
               }
            }
         }
         return _loc4_;
      }
      
      public function get bundleDiscountFlatPriceSteps() : Array
      {
         return var_2232;
      }
      
      public function get bundleDiscountHighestFlatPriceStep() : int
      {
         return var_2931;
      }
      
      public function resolveBundleDiscountFlatPriceSteps() : void
      {
         var_2232 = [];
         var_2931 = 0;
         var _loc1_:int = 0;
         while(true)
         {
            var _loc2_:int = calculateBundlePrice(true,1,0);
            var _loc3_:int = calculateBundlePrice(true,1,0 + 1);
            var_2232.push(0);
            var_2931 = 0;
            _loc1_++;
         }
      }
      
      public function spinnerValueChangedEventTrack() : void
      {
         if(!var_4630)
         {
            HabboTracking.getInstance().trackEventLog("Catalog","spinnerValueChanged","client.bundle.discounts");
            var_4630 = true;
         }
      }
      
      public function bundlesInfoShownEventTrack() : void
      {
         if(!var_4556)
         {
            HabboTracking.getInstance().trackEventLog("Catalog","bundlesInfoOpened","client.bundle.discounts");
            var_4556 = true;
         }
      }
      
      public function discountShownEventTrack() : void
      {
         if(!var_4905)
         {
            HabboTracking.getInstance().trackEventLog("Catalog","discountItemShown","client.bundle.discounts");
            var_4905 = true;
         }
      }
      
      public function displayProductIcon(param1:String, param2:int, param3:class_2251) : void
      {
         var _loc4_:class_2198 = null;
         if(_catalog == null)
         {
            return;
         }
         switch(param1)
         {
            case "s":
               _loc4_ = _catalog.roomEngine.getFurnitureIcon(param2,this);
               break;
            case "i":
               _loc4_ = _catalog.roomEngine.getWallItemIcon(param2,this);
               break;
            case "e":
               param3.bitmap = _catalog.getPixelEffectIcon(param2);
               break;
            case "h":
               param3.bitmap = _catalog.getSubscriptionProductIcon(param2);
         }
         if(_loc4_ != null)
         {
            param3.bitmap = _loc4_.data;
            if(_loc4_.id != 0)
            {
               var _loc5_:Vector.<class_2251> = _productBitmapWrappers[_loc4_.id];
               if(_loc5_ == null)
               {
                  _loc5_ = new Vector.<class_2251>(0);
                  _productBitmapWrappers[_loc4_.id] = undefined;
               }
               undefined.push(param3);
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:Vector.<class_2251> = _productBitmapWrappers[param1];
         if(_loc3_ == null)
         {
            return;
         }
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.bitmap = param2;
         }
         delete _productBitmapWrappers[param1];
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

