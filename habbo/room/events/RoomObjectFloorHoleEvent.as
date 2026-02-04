package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectFloorHoleEvent extends RoomObjectEvent
   {
      
      public static const ADD_HOLE:String = "ROFHO_ADD_HOLE";
      
      public static const REMOVE_HOLE:String = "ROFHO_REMOVE_HOLE";
      
      public function RoomObjectFloorHoleEvent(param1:String, param2:IRoomObject, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}

