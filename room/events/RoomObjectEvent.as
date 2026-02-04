package com.sulake.room.events
{
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class RoomObjectEvent extends Event
   {
      
      private var var_612:IRoomObject;
      
      public function RoomObjectEvent(param1:String, param2:IRoomObject, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_612 = param2;
      }
      
      public function get object() : IRoomObject
      {
         return var_612;
      }
      
      public function get objectId() : int
      {
         if(var_612 != null)
         {
            return var_612.getId();
         }
         return -1;
      }
      
      public function get objectType() : String
      {
         if(var_612 != null)
         {
            return var_612.getType();
         }
         return null;
      }
   }
}

