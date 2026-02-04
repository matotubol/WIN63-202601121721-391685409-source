package com.sulake.habbo.session.enum
{
   public class RoomTradingLevelEnum
   {
      
      public static const NO_TRADING:int = 0;
      
      public static const ROOM_CONTROLLER_REQUIRED:int = 1;
      
      public static const FREE_TRADING:int = 2;
      
      public function RoomTradingLevelEnum()
      {
         super();
      }
      
      public static function getLocalizationKey(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "${trading.mode.not.allowed}";
            case 1:
               return "${trading.mode.controller}";
            case 2:
               return "${trading.mode.free}";
            default:
               return "";
         }
      }
   }
}

