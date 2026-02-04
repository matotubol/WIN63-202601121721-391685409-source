package com.sulake.room.utils
{
   public class RoomId
   {
      
      private static const PREVIEW_ROOM_ID_BASE:int = 2147418112;
      
      public function RoomId()
      {
         super();
      }
      
      public static function makeRoomPreviewerId(param1:int) : int
      {
         return (param1 & 0xFFFF) + 2147418112;
      }
      
      public static function isRoomPreviewerId(param1:int) : Boolean
      {
         return param1 >= 2147418112;
      }
   }
}

