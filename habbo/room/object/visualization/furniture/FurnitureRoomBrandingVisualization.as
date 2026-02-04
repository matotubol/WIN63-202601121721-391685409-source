package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class FurnitureRoomBrandingVisualization extends FurnitureVisualization
   {
      
      private static const BRANDED_IMAGE_SPRITE_TAG:String = "branded_image";
      
      private static const OBJECT_STATE_DEFAULT:int = 0;
      
      private static const OBJECT_STATE_FLIPH:int = 1;
      
      private static const const_1107:int = 2;
      
      private static const const_907:int = 3;
      
      protected var var_319:String;
      
      protected var var_1852:Boolean = false;
      
      protected var var_3031:int;
      
      protected var var_2852:int;
      
      protected var var_3531:int;
      
      private var _dynamicAssetName:String;
      
      public function FurnitureRoomBrandingVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_dynamicAssetName && assetCollection)
         {
            clearBrandedSpriteAssets();
            assetCollection.disposeAsset(_dynamicAssetName);
            _dynamicAssetName = null;
         }
         super.dispose();
         var_319 = null;
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         if(super.updateObject(param1,param2))
         {
            if(var_1852)
            {
               checkAndCreateImageForCurrentState(param1);
            }
            return true;
         }
         return false;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:IRoomObject = null;
         var _loc3_:IRoomObjectModel = null;
         var _loc4_:Boolean = super.updateModel(param1);
         if(_loc4_)
         {
            _loc2_ = object;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.getModel();
               if(_loc3_ != null)
               {
                  var_3031 = _loc3_.getNumber("furniture_branding_offset_x");
                  var_2852 = _loc3_.getNumber("furniture_branding_offset_y");
                  var_3531 = _loc3_.getNumber("furniture_branding_offset_z");
               }
            }
         }
         if(!var_1852)
         {
            var_1852 = checkIfImageReady();
            if(var_1852)
            {
               checkAndCreateImageForCurrentState(param1);
               return true;
            }
         }
         else if(checkIfImageChanged())
         {
            var_1852 = false;
            var_319 = null;
            return true;
         }
         return _loc4_;
      }
      
      protected function checkIfImageChanged() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:String = null;
         var _loc1_:IRoomObject = object;
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getString("furniture_branding_image_url");
               if(_loc2_ != null && _loc2_ != var_319)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      protected function checkIfImageReady() : Boolean
      {
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:IGraphicAsset = null;
         var _loc2_:BitmapData = null;
         var _loc1_:IRoomObject = object;
         if(_loc1_ != null)
         {
            _loc4_ = _loc1_.getModel();
            if(_loc4_ != null)
            {
               _loc3_ = _loc4_.getString("furniture_branding_image_url");
               if(_loc3_ != null)
               {
                  if(var_319 == null || var_319 != _loc3_)
                  {
                     _loc5_ = _loc4_.getNumber("furniture_branding_image_status");
                     if(_loc5_ == 1)
                     {
                        _loc6_ = assetCollection.getAsset(_loc3_);
                        if(_loc6_ != null)
                        {
                           _loc2_ = _loc6_.asset.content as BitmapData;
                           if(_loc2_ != null)
                           {
                              imageReady(_loc2_,_loc3_);
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      override protected function updateSprites(param1:int, param2:Boolean, param3:int) : void
      {
         super.updateSprites(param1,param2,param3);
      }
      
      protected function imageReady(param1:BitmapData, param2:String) : void
      {
         class_21.log("billboard visualization got image from url = " + param2);
         if(param1 != null)
         {
            var_319 = param2;
         }
         else
         {
            var_319 = null;
         }
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc7_:int = 0;
         var _loc4_:int = getSize(param1);
         var _loc5_:String = type;
         var _loc6_:String = "";
         if(param2 < spriteCount - 1)
         {
            _loc6_ = String.fromCharCode("a".charCodeAt() + param2);
         }
         else
         {
            _loc6_ = "sd";
         }
         if(_loc4_ == 1)
         {
            _loc5_ += "_icon_" + _loc6_;
         }
         else
         {
            _loc7_ = getFrameNumber(param1,param2);
            _loc5_ += "_" + _loc4_ + "_" + _loc6_ + "_" + direction + "_" + _loc7_;
         }
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         if(var_319 != null && _loc3_ == "branded_image")
         {
            return var_319 + "_" + _loc4_ + "_" + object.getState(0);
         }
         return _loc5_;
      }
      
      private function checkAndCreateImageForCurrentState(param1:int) : void
      {
         var _loc2_:BitmapData = null;
         var _loc6_:Matrix = null;
         if(object == null || var_319 == null)
         {
            return;
         }
         var _loc11_:IGraphicAsset = assetCollection.getAsset(var_319);
         if(_loc11_ == null)
         {
            return;
         }
         var _loc14_:int = object.getState(0);
         var _loc9_:int = getSize(param1);
         var _loc12_:String = var_319 + "_" + _loc9_ + "_" + _loc14_;
         var _loc15_:IGraphicAsset = assetCollection.getAsset(_loc12_);
         if(_loc15_ != null)
         {
            return;
         }
         var _loc10_:BitmapData = _loc11_.asset.content as BitmapData;
         if(_loc10_ == null)
         {
            class_21.log("could not find bitmap data for image " + _loc12_);
            return;
         }
         var _loc4_:Boolean = true;
         if(var_319.indexOf("noscale") > -1)
         {
            _loc4_ = false;
         }
         if(var_319.indexOf("force32") > -1)
         {
            _loc9_ = 32;
         }
         if(_loc9_ == 32 && _loc4_)
         {
            _loc6_ = new Matrix();
            _loc6_.scale(0.5,0.5);
            _loc2_ = new BitmapData(_loc10_.width / 2,_loc10_.height / 2,true,16777215);
            _loc2_.draw(_loc10_,_loc6_);
         }
         else
         {
            _loc2_ = _loc10_.clone();
         }
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc13_:Boolean = false;
         switch(_loc14_)
         {
            case 0:
               _loc7_ = 0;
               _loc8_ = 0;
               _loc5_ = false;
               _loc13_ = false;
               break;
            case 1:
               _loc7_ = -_loc2_.width;
               _loc8_ = 0;
               _loc5_ = true;
               _loc13_ = false;
               break;
            case 2:
               _loc7_ = -_loc2_.width;
               _loc8_ = -_loc2_.height;
               _loc5_ = true;
               _loc13_ = true;
               break;
            case 3:
               _loc7_ = 0;
               _loc8_ = -_loc2_.height;
               _loc5_ = false;
               _loc13_ = true;
               break;
            default:
               class_21.log("could not handle unknown state " + _loc14_);
         }
         if(_dynamicAssetName)
         {
            clearBrandedSpriteAssets();
            assetCollection.disposeAsset(_dynamicAssetName);
         }
         _dynamicAssetName = _loc12_;
         var _loc3_:Boolean = assetCollection.addAsset(_loc12_,_loc2_,true,_loc7_,_loc8_,_loc5_,_loc13_);
         if(!_loc3_)
         {
            class_21.log("could not add asset for image " + _loc12_);
         }
      }
      
      private function clearBrandedSpriteAssets() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectSprite = null;
         _loc2_ = 0;
         while(_loc2_ < spriteCount)
         {
            _loc1_ = getSprite(_loc2_);
            if(_loc1_ != null && _loc1_.tag == "branded_image")
            {
               _loc1_.asset = null;
            }
            _loc2_++;
         }
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         var _loc3_:String = null;
         if(param2.tag != "branded_image")
         {
            return super.getLibraryAssetNameForSprite(param1,param2);
         }
         if(object)
         {
            _loc3_ = object.getModel().getString("furniture_branding_image_url");
         }
         if(_loc3_ && _loc3_.length > 0)
         {
            return _loc3_;
         }
         return super.getLibraryAssetNameForSprite(param1,param2);
      }
   }
}

