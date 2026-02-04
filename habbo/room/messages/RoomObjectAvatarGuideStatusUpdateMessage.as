package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarGuideStatusUpdateMessage extends RoomObjectUpdateStateMessage
   {
      
      private var _guideStatus:int;
      
      public function RoomObjectAvatarGuideStatusUpdateMessage(param1:int)
      {
         super();
         _guideStatus = param1;
      }
      
      public function get guideStatus() : int
      {
         return _guideStatus;
      }
   }
}

