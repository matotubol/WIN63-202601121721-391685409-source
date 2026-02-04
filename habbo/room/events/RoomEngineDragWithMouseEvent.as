package com.sulake.habbo.room.events
{
   public class RoomEngineDragWithMouseEvent extends RoomEngineEvent
   {
      
      public static const const_1048:String = "REDWME_DRAG_START";
      
      public static const const_391:String = "REDWME_DRAG_END";
      
      public function RoomEngineDragWithMouseEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}

