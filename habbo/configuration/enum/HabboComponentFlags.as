package com.sulake.habbo.configuration.enum
{
   public class HabboComponentFlags
   {
      
      public static const ROOM_VIEWER_MODE:int = 1;
      
      public function HabboComponentFlags()
      {
         super();
      }
      
      public static function isRoomViewerMode(param1:int) : Boolean
      {
         return (param1 & 1) != 0;
      }
   }
}

