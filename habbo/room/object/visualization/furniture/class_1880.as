package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   
   public class class_1880 extends AnimatedFurnitureVisualization
   {
      
      private static const BADGE_SPRITE_TAG:String = "BADGE";
      
      private var var_1967:String = "";
      
      private var var_2623:String = "";
      
      private var var_3614:int = -1;
      
      public function class_1880()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:* = false;
         var _loc3_:Boolean = super.updateModel(param1);
         if(!isNaN(object.getModel().getNumber("furniture_badge_image_status")))
         {
            _loc2_ = object.getModel().getNumber("furniture_badge_image_status") != 0;
            if(_loc2_ && var_1967 == "")
            {
               var_1967 = object.getModel().getString("furniture_badge_asset_name");
               if(var_2623 == "")
               {
                  var_2623 = var_1967 + "_32";
               }
               if(object.getModel().hasNumber("furniture_badge_visible_in_state"))
               {
                  var_3614 = object.getModel().getNumber("furniture_badge_visible_in_state");
               }
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         if(_loc3_ != "BADGE" || var_3614 != -1 && object.getState(0) != var_3614)
         {
            return super.getSpriteAssetName(param1,param2);
         }
         if(param1 == 32)
         {
            return var_2623;
         }
         return var_1967;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         if(getSpriteTag(param1,param2,param3) == "BADGE")
         {
            var _loc5_:IGraphicAsset = getAsset(param1 == 32 ? var_2623 : var_1967,param3);
            if(param1 == 64)
            {
               _loc4_ += (40 - null.width) / 2;
               if(param2 == 2 && (type == "china_c24_resolution1" || type == "china_c24_resolution2"))
               {
                  _loc4_ -= 40;
               }
            }
            else
            {
               _loc4_ += (20 - null.width) / 2;
            }
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         if(getSpriteTag(param1,param2,param3) == "BADGE")
         {
            var _loc5_:IGraphicAsset = getAsset(param1 == 32 ? var_2623 : var_1967,param3);
            if(param1 == 64)
            {
               _loc4_ += (40 - null.height) / 2;
            }
            else
            {
               _loc4_ += (20 - null.height) / 2;
            }
         }
         return _loc4_;
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         if(param2.tag == "BADGE")
         {
            return "%image.library.url%album1584/" + param2.assetName.replace("badge_","") + ".png";
         }
         return super.getLibraryAssetNameForSprite(param1,param2);
      }
   }
}

