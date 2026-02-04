package com.sulake.habbo.session
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.class_16;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class BadgeImageManager
   {
      
      public static const const_454:String = "group_badge";
      
      public static const TYPE_NORMAL:String = "normal_badge";
      
      private const ASSET_PREFIX:String = "badge_";
      
      private const ASSET_SMALL_POSTFIX:String = "_32";
      
      private var _assets:class_40;
      
      private var name_1:IEventDispatcher;
      
      private var var_637:class_16;
      
      private var var_3448:Dictionary = new Dictionary();
      
      public function BadgeImageManager(param1:class_40, param2:IEventDispatcher, param3:class_16)
      {
         super();
         if(param1 == null)
         {
            param1 = new AssetLibrary("badge_images");
         }
         _assets = param1;
         name_1 = param2;
         var_637 = param3;
      }
      
      public function dispose() : void
      {
         _assets = null;
      }
      
      public function getBadgeImage(param1:String, param2:String = "normal_badge", param3:Boolean = true, param4:Boolean = false) : BitmapData
      {
         var _loc5_:BitmapData = getBadgeImageInternal(param1,param2,param4);
         if(!_loc5_ && param3)
         {
            _loc5_ = getPlaceholder();
         }
         return _loc5_;
      }
      
      public function getSmallBadgeImage(param1:String, param2:String = "normal_badge") : BitmapData
      {
         if(getBadgeImageInternal(param1,param2,true) == null && getBadgeImageInternal(param1) != null)
         {
            createSmallBadgeBitmap("badge_" + param1,param1);
         }
         return getBadgeImage(param1,param2,false,true);
      }
      
      public function getBadgeImageWithInfo(param1:String) : BadgeInfo
      {
         var _loc2_:BitmapData = getBadgeImageInternal(param1);
         return _loc2_ != null ? new BadgeInfo(_loc2_,false) : new BadgeInfo(getPlaceholder(),true);
      }
      
      public function getBadgeImageAssetName(param1:String, param2:String = "normal_badge", param3:Boolean = false) : String
      {
         var _loc4_:String = "badge_" + param1 + (param3 ? "_32" : "");
         if(_assets.hasAsset(_loc4_))
         {
            return _loc4_;
         }
         getBadgeImageInternal(param1,param2,param3);
         return null;
      }
      
      public function getSmallScaleBadgeAssetName(param1:String, param2:String = "normal_badge") : String
      {
         var _loc3_:String = getBadgeImageAssetName(param1,param2,true);
         if(_loc3_ == null)
         {
            createSmallBadgeBitmap("badge_" + param1,param1);
            return getBadgeImageAssetName(param1,param2,true);
         }
         return _loc3_;
      }
      
      private function getBadgeImageInternal(param1:String, param2:String = "normal_badge", param3:Boolean = false) : BitmapData
      {
         var _loc5_:String = null;
         var _loc6_:String = "badge_" + param1 + (param3 ? "_32" : "");
         if(_assets.hasAsset(_loc6_))
         {
            var _loc7_:BitmapDataAsset = _assets.getAssetByName(_loc6_) as BitmapDataAsset;
            return (_loc7_.content as BitmapData).clone();
         }
         if(param3)
         {
            return null;
         }
         class_21.log("Request badge: " + param1);
         switch(param2)
         {
            case "normal_badge":
               if(var_637 != null)
               {
                  _loc5_ = var_637.getProperty("image.library.url");
                  _loc5_ = _loc5_ + ("album1584/" + param1 + ".png");
                  var _loc8_:URLRequest = new URLRequest(_loc5_);
               }
               break;
            case "group_badge":
               if(var_637 != null && !var_3448[_loc6_])
               {
                  _loc5_ = var_637.getProperty("group.badge.url");
                  _loc5_ = _loc5_.replace("%imagerdata%",param1);
                  if(_loc5_.substr(-4) == ".gif")
                  {
                     _loc5_ = _loc5_.slice(0,-3) + "png";
                  }
                  _loc8_ = new URLRequest(_loc5_);
                  var_3448[_loc6_] = true;
               }
         }
         return null;
      }
      
      private function getPlaceholder() : BitmapData
      {
         return BitmapData(_assets.getAssetByName("loading_icon").content).clone();
      }
      
      private function onBadgeImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:Bitmap = null;
         var _loc5_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc5_ != null)
         {
            if(_loc5_.assetLoader != null && _loc5_.assetLoader.content != null)
            {
               _loc4_ = _loc5_.assetName;
               _loc3_ = _loc4_.replace("badge_","");
               _loc2_ = _loc5_.assetLoader.content as Bitmap;
               if(_loc2_ == null)
               {
                  return;
               }
               name_1.dispatchEvent(new BadgeImageReadyEvent(_loc3_,_loc2_.bitmapData.clone()));
            }
         }
      }
      
      private function createSmallBadgeBitmap(param1:String, param2:String) : void
      {
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = renderSmallScaleBadgeBitmap(param1);
         if(_loc3_)
         {
            _loc4_ = new BitmapDataAsset(_assets.getAssetTypeDeclarationByClass(BitmapDataAsset));
            if(_loc4_ != null)
            {
               _assets.setAsset("badge_" + param2 + "_32",_loc4_);
               _loc4_.setUnknownContent(_loc3_);
            }
         }
      }
      
      private function renderSmallScaleBadgeBitmap(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc2_:Matrix = null;
         var _loc4_:IAsset = _assets.getAssetByName(param1);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.content as BitmapData;
            _loc5_ = new BitmapData(_loc3_.width / 2,_loc3_.height / 2,true,0);
            _loc2_ = new Matrix(0.5,0,0,0.5);
            _loc5_.draw(_loc3_,_loc2_,null,null,null,true);
            return _loc5_;
         }
         return null;
      }
   }
}

