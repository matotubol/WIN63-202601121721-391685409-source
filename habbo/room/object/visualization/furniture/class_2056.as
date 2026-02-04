package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   
   public class class_2056 extends AnimatedFurnitureVisualization
   {
      
      public static const PRIMARY_COLOUR_SPRITE_TAG:String = "COLOR1";
      
      public static const SECONDARY_COLOUR_SPRITE_TAG:String = "COLOR2";
      
      public static const DEFAULT_COLOR_1:int = 15658734;
      
      public static const DEFAULT_COLOR_2:int = 4934475;
      
      private static const BADGE_SPRITE_TAG:String = "BADGE";
      
      private var _color1:int;
      
      private var _color2:int;
      
      private var var_1967:String = "";
      
      private var var_2623:String = "";
      
      public function class_2056()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:Boolean = super.updateModel(param1);
         if(var_1967 == "")
         {
            _loc4_ = object.getModel().getString("furniture_guild_customized_asset_name");
            if(_loc4_ != null)
            {
               var_1967 = _loc4_;
               var_2623 = var_1967 + "_32";
            }
         }
         var _loc2_:Number = object.getModel().getNumber("furniture_guild_customized_color_1");
         _color1 = isNaN(_loc2_) ? 15658734 : _loc2_ as int;
         var _loc3_:Number = object.getModel().getNumber("furniture_guild_customized_color_2");
         _color2 = isNaN(_loc2_) ? 4934475 : _loc3_ as int;
         return _loc5_;
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
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         if(_loc3_ == "BADGE")
         {
            if(param1 == 32)
            {
               return var_2623;
            }
            return var_1967;
         }
         return super.getSpriteAssetName(param1,param2);
      }
      
      override protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         if(param2.tag == "BADGE")
         {
            return "%group.badge.url%" + param2.assetName.replace("badge_","");
         }
         return super.getLibraryAssetNameForSprite(param1,param2);
      }
   }
}

