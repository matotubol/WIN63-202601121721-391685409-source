package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectDataRequestEvent extends RoomObjectEvent
   {
      
      public static const CURRENT_USER_ID:String = "RODRE_CURRENT_USER_ID";
      
      public static const URL_PREFIX:String = "RODRE_URL_PREFIX";
      
      public function RoomObjectDataRequestEvent(param1:String, param2:IRoomObject, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}

