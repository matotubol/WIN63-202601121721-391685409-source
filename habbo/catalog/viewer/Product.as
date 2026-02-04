package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import flash.display.BitmapData;
   
   public class Product extends ProductGridItem implements class_1857, class_1829
   {
      
      public static const EFFECT_CLASSID_NINJA_DISAPPEAR:int = 108;
      
      private var var_576:String;
      
      private var var_3320:int;
      
      private var var_744:String;
      
      private var var_2475:int;
      
      private var var_1500:class_1949;
      
      private var var_587:class_1800;
      
      private var var_4849:Boolean;
      
      private var var_4579:int;
      
      private var var_3181:int;
      
      private var var_370:class_2557;
      
      public function Product(param1:String, param2:int, param3:String, param4:int, param5:class_1949, param6:class_1800, param7:HabboCatalog, param8:Boolean = false, param9:int = 0, param10:int = 0)
      {
         super(param7);
         var_576 = param1;
         var_3320 = param2;
         var_744 = param3;
         var_2475 = param4;
         var_1500 = param5;
         var_587 = param6;
         var_4849 = param8;
         var_4579 = param9;
         var_3181 = param10;
      }
      
      public static function stripAddonProducts(param1:Vector.<class_1857>) : Vector.<class_1857>
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            return param1;
         }
         var _loc3_:Vector.<class_1857> = new Vector.<class_1857>(0);
         for each(_loc2_ in param1)
         {
            if(_loc2_.productType != "b" && !(_loc2_.productType == "e" && _loc2_.productClassId == 108) && _loc2_.productType != "chat_style")
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function get productType() : String
      {
         return var_576;
      }
      
      public function get productClassId() : int
      {
         return var_3320;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_744 = param1;
      }
      
      public function get extraParam() : String
      {
         return var_744;
      }
      
      public function get productCount() : int
      {
         return var_2475;
      }
      
      public function get productData() : class_1949
      {
         return var_1500;
      }
      
      public function get furnitureData() : class_1800
      {
         return var_587;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return var_4849;
      }
      
      public function get uniqueLimitedItemSeriesSize() : int
      {
         return var_4579;
      }
      
      public function get uniqueLimitedItemsLeft() : int
      {
         return var_3181;
      }
      
      public function set uniqueLimitedItemsLeft(param1:int) : void
      {
         var_3181 = param1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_576 = "";
         var_3320 = 0;
         var_744 = "";
         var_2475 = 0;
         var_1500 = null;
         var_587 = null;
         if(catalog && catalog.sessionDataManager)
         {
            catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
         }
         super.dispose();
      }
      
      public function initIcon(param1:class_2557, param2:class_1829 = null, param3:class_259 = null, param4:class_1793 = null, param5:class_2251 = null, param6:IStuffData = null, param7:Function = null) : BitmapData
      {
         var _loc10_:IRoomEngine = null;
         var _loc8_:class_2198 = null;
         if(disposed)
         {
            return null;
         }
         var _loc9_:BitmapData = null;
         if(param2 == null)
         {
            param2 = this;
         }
         if(param1 is BundleGridViewCatalogWidget)
         {
            _loc10_ = (param1 as BundleGridViewCatalogWidget).offer.page.viewer.roomEngine;
         }
         else
         {
            _loc10_ = (param1 as ProductContainer).offer.page.viewer.roomEngine;
         }
         if(!_loc10_ || !catalog)
         {
            return null;
         }
         switch(var_576)
         {
            case "s":
               _loc8_ = _loc10_.getFurnitureIcon(productClassId,param2,null,param6);
               break;
            case "i":
               if(param4 && var_587)
               {
                  var _loc11_:String = "";
                  switch(var_587.className)
                  {
                     case "floor":
                        _loc11_ = ["th",var_587.className,param4.product.extraParam].join("_");
                        break;
                     case "wallpaper":
                        _loc11_ = ["th","wall",param4.product.extraParam].join("_");
                        break;
                     case "landscape":
                        _loc11_ = ["th",var_587.className,param4.product.extraParam.replace(".","_"),"001"].join("_");
                        break;
                     default:
                        _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,var_744);
                  }
                  catalog.setImageFromAsset(param5,null,param7);
                  break;
               }
               _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,var_744);
               break;
            case "e":
               _loc9_ = catalog.getPixelEffectIcon(productClassId);
               if(param2 == this)
               {
                  this.setIconImage(_loc9_,true);
               }
               break;
            case "h":
               _loc9_ = catalog.getSubscriptionProductIcon(productClassId);
               break;
            case "b":
               catalog.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               _loc9_ = catalog.sessionDataManager.getBadgeImage(var_744);
               var_370 = param1;
               break;
            case "r":
               _loc9_ = renderAvatarImage(var_744,param3);
               setIconImage(_loc9_,false);
               break;
            case "chat_style":
               _loc9_ = catalog.freeFlowChat.chatStyleLibrary.getStyle(int(var_744)).selectorPreview.clone();
               break;
            default:
               class_21.log("[Product] Can not yet handle this type of product: " + productType);
         }
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_.data;
            if(param2 == this)
            {
               this.setIconImage(_loc9_,true);
            }
         }
         return _loc9_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(!disposed)
         {
            setIconImage(param2,true);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(!disposed)
         {
            if(var_576 == "b" && param1.badgeId == var_744)
            {
               ProductGridItem(var_370).setIconImage(param1.badgeImage,false);
               if(catalog && catalog.sessionDataManager)
               {
                  catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               }
            }
         }
      }
      
      public function get isColorable() : Boolean
      {
         if(var_587 && var_587.fullName)
         {
            return var_587.fullName.indexOf("*") != -1;
         }
         return false;
      }
      
      override public function set view(param1:class_1812) : void
      {
         if(!param1)
         {
            return;
         }
         super.view = param1;
         if(var_2475 > 1)
         {
            var _loc2_:class_1741 = var_18.findChildByName("multiContainer");
            var _loc3_:ITextWindow = var_18.findChildByName("multiCounter") as ITextWindow;
         }
      }
   }
}

