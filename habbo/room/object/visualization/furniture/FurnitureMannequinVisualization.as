package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import flash.utils.Dictionary;
   
   public class FurnitureMannequinVisualization extends FurnitureVisualization implements class_259
   {
      
      private static const AVATAR_IMAGE_SPRITE_TAG:String = "avatar_image";
      
      private static var _customPlaceholders:Dictionary;
      
      private static var var_1982:int;
      
      private const MANNEQUIN_BODY:String = "hd-99999-99998";
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_337:int;
      
      private var _needsUpdate:Boolean = false;
      
      private var _dynamicAssetName:String;
      
      private var var_24:AvatarFurnitureVisualizationData;
      
      private var var_1134:Boolean = false;
      
      public function FurnitureMannequinVisualization()
      {
         super();
         var_1982 = var_1982 + 1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      override public function dispose() : void
      {
         if(!var_1134)
         {
            var_24 = null;
            var_1134 = true;
            if(_dynamicAssetName && assetCollection)
            {
               clearDynamicSpriteAssets();
               assetCollection.disposeAsset(_dynamicAssetName);
               _dynamicAssetName = null;
            }
            super.dispose();
            var_1982 = var_1982 - 1;
            if(var_1982 == 0 && _customPlaceholders)
            {
               for each(var _loc1_ in _customPlaceholders)
               {
                  _loc1_.dispose();
               }
               _customPlaceholders = null;
            }
         }
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var_24 = param1 as AvatarFurnitureVisualizationData;
         super.initialize(param1);
         return true;
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Boolean = super.updateObject(param1,param2);
         if(_loc3_)
         {
            if(var_337 != param1)
            {
               var_337 = param1;
               addAvatarAsset();
            }
         }
         return _loc3_;
      }
      
      private function addAvatarAsset(param1:Boolean = false) : void
      {
         var _loc3_:class_1827 = null;
         var _loc2_:class_1827 = null;
         if(!isAvatarAssetReady() || param1)
         {
            _loc3_ = var_24.getAvatar(var_975,var_337,var_111,this);
            if(_loc3_)
            {
               if(_loc3_.isPlaceholder())
               {
                  _loc3_.dispose();
                  _loc2_ = getCustomPlaceholder(var_337);
                  _loc2_.setDirection("full",direction);
                  assetCollection.addAsset(getAvatarAssetName(),_loc2_.getImage("full",true),true);
                  _needsUpdate = true;
                  return;
               }
               _loc3_.setDirection("full",direction);
               if(_dynamicAssetName)
               {
                  clearDynamicSpriteAssets();
                  assetCollection.disposeAsset(_dynamicAssetName);
               }
               assetCollection.addAsset(getAvatarAssetName(),_loc3_.getImage("full",true),true);
               _dynamicAssetName = getAvatarAssetName();
               _needsUpdate = true;
               _loc3_.dispose();
            }
         }
      }
      
      private function clearDynamicSpriteAssets() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectSprite = null;
         _loc2_ = 0;
         while(_loc2_ < spriteCount)
         {
            _loc1_ = getSprite(_loc2_);
            if(_loc1_ != null && _loc1_.assetName == _dynamicAssetName)
            {
               _loc1_.asset = null;
            }
            _loc2_++;
         }
      }
      
      override public function getSpriteList() : Array
      {
         var _loc1_:class_1827 = var_24.getAvatar(var_975,var_337,var_111,this);
         if(_loc1_ == null)
         {
            return super.getSpriteList();
         }
         _loc1_.setDirection("full",direction);
         return _loc1_.getServerRenderData();
      }
      
      private function getCustomPlaceholder(param1:int) : class_1827
      {
         if(!_customPlaceholders)
         {
            _customPlaceholders = new Dictionary();
         }
         var _loc2_:class_1827 = _customPlaceholders[param1];
         if(_loc2_ == null)
         {
            _loc2_ = var_24.getAvatar("hd-99999-99998",param1,null,null);
            _customPlaceholders[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc3_:IRoomObject = null;
         var _loc4_:IRoomObjectModel = null;
         var _loc2_:String = null;
         var _loc5_:Boolean = super.updateModel(param1);
         if(_loc5_)
         {
            _loc3_ = object;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.getModel();
               if(_loc4_ != null)
               {
                  _loc2_ = _loc4_.getString("furniture_mannequin_figure");
                  if(_loc2_)
                  {
                     var_111 = _loc4_.getString("furniture_mannequin_gender");
                     var_975 = _loc2_ + "." + "hd-99999-99998";
                     addAvatarAsset();
                  }
               }
            }
         }
         if(!_loc5_)
         {
            _loc5_ = _needsUpdate;
         }
         _needsUpdate = false;
         return _loc5_;
      }
      
      private function isAvatarAssetReady() : Boolean
      {
         return var_975 && getAsset(getAvatarAssetName()) != null;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         if(var_975 != null && _loc3_ == "avatar_image" && isAvatarAssetReady())
         {
            return getAvatarAssetName();
         }
         return super.getSpriteAssetName(param1,param2);
      }
      
      private function getAvatarAssetName() : String
      {
         var _loc1_:IRoomObject = object;
         if(!_loc1_)
         {
            return null;
         }
         return "mannequin_" + var_975 + "_" + var_337 + "_" + direction + "_" + _loc1_.getId();
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(param1 == var_975)
         {
            addAvatarAsset(true);
         }
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String = getSpriteTag(param1,param2,param3);
         if(_loc4_ == "avatar_image" && isAvatarAssetReady())
         {
            return -getSprite(param3).width / 2;
         }
         return super.getSpriteXOffset(param1,param2,param3);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String = getSpriteTag(param1,param2,param3);
         if(_loc4_ == "avatar_image" && isAvatarAssetReady())
         {
            return -getSprite(param3).height;
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
   }
}

