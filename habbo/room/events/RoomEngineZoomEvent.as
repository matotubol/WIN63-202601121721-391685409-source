package com.sulake.habbo.room.events
{
   public class RoomEngineZoomEvent extends RoomEngineEvent
   {
      
      public static const ROOM_ZOOM:String = "REE_ROOM_ZOOM";
      
      private var var_2493:Number = 1;
      
      private var var_3999:Boolean = false;
      
      public function RoomEngineZoomEvent(param1:int, param2:Number, param3:* = false, param4:Boolean = false, param5:Boolean = false)
      {
         super("REE_ROOM_ZOOM",param1,param4,param5);
         var_2493 = param2;
         var_3999 = param3;
      }
      
      public function get level() : Number
      {
         return var_2493;
      }
      
      public function get isFlipForced() : Boolean
      {
         return var_3999;
      }
   }
}

