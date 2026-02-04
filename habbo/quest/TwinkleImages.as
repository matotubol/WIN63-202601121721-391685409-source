package com.sulake.habbo.quest
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_17;
   import flash.display.BitmapData;
   
   public class TwinkleImages implements class_13
   {
      
      private static const IMAGE_COUNT:int = 6;
      
      private var _questEngine:HabboQuestEngine;
      
      public function TwinkleImages(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var _loc2_:int = 1;
         while(true)
         {
            _questEngine.windowManager.resourceManager.retrieveAsset(getImageUri(0),null);
            _loc2_++;
         }
      }
      
      private static function getImageUri(param1:int) : String
      {
         return "${image.library.questing.url}ach_twinkle" + param1 + ".png";
      }
      
      public function getImage(param1:int) : BitmapData
      {
         if(_questEngine != null)
         {
            var _loc2_:IAsset = class_17(_questEngine.windowManager).assets.getAssetByName(_questEngine.interpolate(getImageUri(param1)));
         }
         return null;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine != null;
      }
   }
}

