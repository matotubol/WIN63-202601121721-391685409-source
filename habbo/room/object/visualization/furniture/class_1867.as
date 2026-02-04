package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   
   public class class_1867 extends class_1866
   {
      
      private static const PRIMARY_COLOUR_SPRITE_TAG:String = "COLOR1";
      
      private static const SECONDARY_COLOUR_SPRITE_TAG:String = "COLOR2";
      
      private static const DEFAULT_COLOR_1:int = 15658734;
      
      private static const DEFAULT_COLOR_2:int = 4934475;
      
      private var _color1:int;
      
      private var _color2:int;
      
      public function class_1867()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:Boolean = super.updateModel(param1);
         if(!hasThumbnailImage)
         {
            _loc4_ = object.getModel().getString("furniture_guild_customized_asset_name");
            if(_loc4_ != null)
            {
               setThumbnailImages(safeGetBitmapAsset(_loc4_),safeGetBitmapAsset(_loc4_ + "_32"));
            }
         }
         var _loc2_:Number = object.getModel().getNumber("furniture_guild_customized_color_1");
         _color1 = isNaN(_loc2_) ? 15658734 : _loc2_ as int;
         var _loc3_:Number = object.getModel().getNumber("furniture_guild_customized_color_2");
         _color2 = isNaN(_loc2_) ? 4934475 : _loc3_ as int;
         return _loc5_;
      }
      
      private function safeGetBitmapAsset(param1:String) : BitmapData
      {
         var _loc2_:IGraphicAsset = assetCollection.getAsset(param1);
         if(_loc2_ == null || _loc2_.asset == null)
         {
            return null;
         }
         return BitmapData(_loc2_.asset.content);
      }
      
      override protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String;
         switch(_loc4_ = getSpriteTag(param1,direction,param2))
         {
            case "COLOR1":
               return _color1;
            case "COLOR2":
               return _color2;
            default:
               return super.getSpriteColor(param1,param2,param3);
         }
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         if(param2.tag == "THUMBNAIL")
         {
            if(object && object.getModel().getString("furniture_guild_customized_asset_name"))
            {
               return "%group.badge.url%" + object.getModel().getString("furniture_guild_customized_asset_name").replace("badge_","");
            }
         }
         return super.getLibraryAssetNameForSprite(param1,param2);
      }
   }
}

