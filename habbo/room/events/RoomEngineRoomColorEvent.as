package com.sulake.habbo.room.events
{
   public class RoomEngineRoomColorEvent extends RoomEngineEvent
   {
      
      public static const ROOM_COLOR:String = "REE_ROOM_COLOR";
      
      private var _color:uint;
      
      private var var_4922:uint;
      
      private var var_4020:Boolean;
      
      public function RoomEngineRoomColorEvent(param1:int, param2:uint, param3:uint, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super("REE_ROOM_COLOR",param1,param5,param6);
         _color = param2;
         var_4922 = param3;
         var_4020 = param4;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return var_4922;
      }
      
      public function get bgOnly() : Boolean
      {
         return var_4020;
      }
   }
}

