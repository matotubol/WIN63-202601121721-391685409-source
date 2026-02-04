package com.sulake.habbo.navigator.view.search.results
{
   public class RoomEntryUtils
   {
      
      public function RoomEntryUtils()
      {
         super();
      }
      
      public static function getDoorModeIconAsset(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "newnavigator_doormode_doorbell_small";
            case 1:
               return "newnavigator_doormode_password_small";
            case 2:
               return "newnavigator_doormode_invisible_small";
            default:
               return "";
         }
      }
      
      public static function getModulatedBackgroundColor(param1:int, param2:uint) : uint
      {
         if(param1 == -1)
         {
            return param2;
         }
         var _loc5_:Number = (uint((0xFF0000 & param2) >> 16)) / 255;
         var _loc9_:Number = (uint((0xFF00 & param2) >> 8)) / 255;
         var _loc6_:Number = (uint(0xFF & param2)) / 255;
         var _loc10_:Number = (uint((0xFF0000 & param1) >> 16)) / 255;
         var _loc7_:Number = (uint((0xFF00 & param1) >> 8)) / 255;
         var _loc11_:Number = (uint(0xFF & param1)) / 255;
         var _loc3_:Number = _loc5_ * Math.min(1,_loc10_ * 1.5);
         var _loc8_:Number = _loc9_ * Math.min(1,_loc7_ * 1.5);
         var _loc4_:Number = _loc6_ * Math.min(1,_loc11_ * 1.5);
         return uint((uint(_loc3_ * 255) << 16) + (uint(_loc8_ * 255) << 8) + uint(_loc4_ * 255) + 4278190080);
      }
      
      public static function getFavoriteIcon(param1:Boolean) : String
      {
         return "newnavigator_icon_fav_" + (param1 ? "yes" : "no");
      }
   }
}

