package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class class_1866 extends AnimatedFurnitureVisualization
   {
      
      protected static const THUMBNAIL_SPRITE_TAG:String = "THUMBNAIL";
      
      private var var_3717:String = null;
      
      private var _thumbnailAssetNameNormal:String = null;
      
      private var var_4132:Boolean = false;
      
      private var var_4584:BitmapData;
      
      private var _thumbnailImageNormal:BitmapData;
      
      private var var_4558:int;
      
      private var var_3386:Boolean;
      
      public function class_1866()
      {
         super();
      }
      
      public function set hasOutline(param1:Boolean) : void
      {
         var_4132 = param1;
      }
      
      public function get hasThumbnailImage() : Boolean
      {
         return _thumbnailImageNormal != null;
      }
      
      public function setThumbnailImages(param1:BitmapData, param2:BitmapData = null) : void
      {
         _thumbnailImageNormal = param1;
         var_4584 = param2 ?? param1;
         var_3386 = true;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:Boolean = super.updateModel(param1);
         if(!object)
         {
            return _loc2_;
         }
         if(!var_3386 && var_4558 == direction)
         {
            return _loc2_;
         }
         refreshThumbnail();
         return true;
      }
      
      private function refreshThumbnail() : void
      {
         if(assetCollection == null)
         {
            return;
         }
         if(_thumbnailImageNormal != null)
         {
            addThumbnailAsset(_thumbnailImageNormal,64);
            addThumbnailAsset(var_4584,32);
         }
         else
         {
            clearThumbnailSpriteAssets();
            assetCollection.disposeAsset(getThumbnailAssetName(64));
            assetCollection.disposeAsset(getThumbnailAssetName(32));
         }
         var_3386 = false;
         var_4558 = direction;
      }
      
      private function addThumbnailAsset(param1:BitmapData, param2:int) : void
      {
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < spriteCount)
         {
            if(getSpriteTag(param2,direction,_loc5_) == "THUMBNAIL")
            {
               var _loc6_:String = getSpriteAssetNameWithoutFrame(param2,_loc5_,false) + getFrameNumber(param2,_loc5_);
               var _loc4_:IGraphicAsset = getAsset(null,_loc5_);
               if(_loc4_ != null)
               {
                  var _loc3_:BitmapData = generateTransformedThumbnail(param1,null);
                  var _loc7_:String = getThumbnailAssetName(param2);
                  clearThumbnailSpriteAssets();
                  assetCollection.disposeAsset(null);
                  assetCollection.addAsset(null,null,true,null.offsetX,null.offsetY);
               }
               return;
            }
            _loc5_++;
         }
      }
      
      private function clearThumbnailSpriteAssets() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectSprite = null;
         _loc2_ = 0;
         while(_loc2_ < spriteCount)
         {
            _loc1_ = getSprite(_loc2_);
            if(_loc1_ != null && _loc1_.tag == "THUMBNAIL")
            {
               _loc1_.asset = null;
            }
            _loc2_++;
         }
      }
      
      private function generateTransformedThumbnail(param1:BitmapData, param2:IGraphicAsset) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc6_:Matrix = new Matrix();
         var _loc5_:Number = param2.width / param1.width;
         switch(direction)
         {
            case 0:
            case 4:
               _loc6_.a = _loc5_;
               _loc6_.b = 0.5 * _loc5_;
               _loc6_.c = 0;
               _loc6_.d = _loc5_ * 1.1;
               _loc6_.tx = 0;
               _loc6_.ty = 0;
               break;
            case 2:
               _loc6_.a = _loc5_;
               _loc6_.b = -0.5 * _loc5_;
               _loc6_.c = 0;
               _loc6_.d = _loc5_ * 1.1;
               _loc6_.tx = 0;
               _loc6_.ty = 0.5 * _loc5_ * param1.width;
               break;
            default:
               _loc6_.a = _loc5_;
               _loc6_.b = 0;
               _loc6_.c = 0;
               _loc6_.d = _loc5_;
               _loc6_.tx = 0;
               _loc6_.ty = 0;
         }
         if(var_4132)
         {
            _loc3_ = new BitmapData(param2.width + 2,param2.height + 2,true,0);
            var _loc8_:Bitmap = new Bitmap(param1);
            var _loc7_:ColorTransform = new ColorTransform();
            _loc7_.color = 0;
            _loc3_.draw(null,_loc6_,null);
            _loc6_.tx += 1;
            _loc6_.ty -= 1;
            _loc3_.draw(null,_loc6_,null);
            _loc6_.ty += 2;
            _loc3_.draw(null,_loc6_,null);
            _loc6_.tx += 1;
            _loc6_.ty -= 1;
            _loc3_.draw(null,_loc6_,null);
            _loc6_.tx -= 1;
            _loc3_.draw(null,_loc6_);
         }
         else
         {
            _loc3_ = new BitmapData(param2.width,param2.height,true,0);
            _loc3_.draw(param1,_loc6_);
         }
         return _loc3_;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(_thumbnailImageNormal == null || getSpriteTag(param1,direction,param2) != "THUMBNAIL")
         {
            return super.getSpriteAssetName(param1,param2);
         }
         return getThumbnailAssetName(param1);
      }
      
      protected function getThumbnailAssetName(param1:int) : String
      {
         if(var_3717 == null)
         {
            var_3717 = getFullThumbnailAssetName(object.getId(),32);
            _thumbnailAssetNameNormal = getFullThumbnailAssetName(object.getId(),64);
         }
         return param1 == 32 ? var_3717 : _thumbnailAssetNameNormal;
      }
      
      protected function getFullThumbnailAssetName(param1:int, param2:int) : String
      {
         return [type,param1,"thumb",param2].join("_");
      }
   }
}

