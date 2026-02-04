package com.sulake.habbo.room.events
{
   import flash.events.Event;
   
   public class RoomEngineEvent extends Event
   {
      
      public static const ROOM_ENGINE_INITIALIZED:String = "REE_ENGINE_INITIALIZED";
      
      public static const ROOM_INITIALIZED:String = "REE_INITIALIZED";
      
      public static const ROOM_DISPOSED:String = "REE_DISPOSED";
      
      public static const ROOM_ENGINE_GAME_MODE:String = "REE_GAME_MODE";
      
      public static const ROOM_ENGINE_NORMAL_MODE:String = "REE_NORMAL_MODE";
      
      public static const ROOM_OBJECTS_INITIALIZED:String = "REE_OBJECTS_INITIALIZED";
      
      public static const ROOM_ZOOMED:String = "REE_ROOM_ZOOMED";
      
      public static const ROOM_ENTRANCE_AFTER_SPECTATE:String = "REE_ENTRANCE_AFTER_SPECTATE";
      
      private var var_1951:int;
      
      public function RoomEngineEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_1951 = param2;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}

