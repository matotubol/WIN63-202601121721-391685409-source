package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomEngineUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const GAME_MODE:String = "RWREUE_GAME_MODE";
      
      public static const NORMAL_MODE:String = "RWREUE_NORMAL_MODE";
      
      private var var_1951:int = 0;
      
      public function RoomWidgetRoomEngineUpdateEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
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

