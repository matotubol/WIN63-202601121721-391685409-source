package com.sulake.habbo.room.events
{
   public class RoomEngineRoomAdEvent extends RoomEngineObjectEvent
   {
      
      public static const FURNI_CLICK:String = "RERAE_FURNI_CLICK";
      
      public static const FURNI_DOUBLE_CLICK:String = "RERAE_FURNI_DOUBLE_CLICK";
      
      public static const TOOLTIP_SHOW:String = "RERAE_TOOLTIP_SHOW";
      
      public static const TOOLTIP_HIDE:String = "RERAE_TOOLTIP_HIDE";
      
      public function RoomEngineRoomAdEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
   }
}

