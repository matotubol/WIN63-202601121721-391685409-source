package com.sulake.room.events
{
   import flash.events.Event;
   
   public class RoomToObjectEvent extends Event
   {
      
      public function RoomToObjectEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

