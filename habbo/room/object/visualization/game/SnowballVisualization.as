package com.sulake.habbo.room.object.visualization.game
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.furniture.class_2115;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class SnowballVisualization extends RoomObjectSpriteVisualization
   {
      
      private static const SNOWBALL_ASSET_NAME:String = "snowball_small_png";
      
      private static const SNOWBALL_SHADOW_ASSET_NAME:String = "snowball_small_shadow_png";
      
      private static const const_724:int = 16;
      
      private var var_24:class_2115;
      
      private var var_1202:IRoomObjectSprite;
      
      public function SnowballVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var_1202 = null;
         super.dispose();
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var_24 = param1 as class_2115;
         createSprites(2);
         var _loc2_:BitmapDataAsset = var_24.assets.getAssetByName("snowball_small_png") as BitmapDataAsset;
         getSprite(0).asset = null.content as BitmapData;
         _loc2_ = var_24.assets.getAssetByName("snowball_small_shadow_png") as BitmapDataAsset;
         var_1202 = getSprite(1);
         var_1202.asset = null.content as BitmapData;
         var_1202.alpha = 100;
         var_1202.relativeDepth = 1;
         return true;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var_1202.offsetY = object.getLocation().z * 16;
         var_1202.alpha = Math.max(0,100 - var_1202.offsetY / 10);
      }
   }
}

