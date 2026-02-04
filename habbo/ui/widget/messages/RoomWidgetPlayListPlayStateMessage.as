package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage
   {
      
      public static const TOGGLE_PLAY_PAUSE:String = "RWPLPS_TOGGLE_PLAY_PAUSE";
      
      private var var_2536:int;
      
      private var var_2134:int;
      
      public function RoomWidgetPlayListPlayStateMessage(param1:String, param2:int, param3:int = -1)
      {
         super(param1);
         var_2536 = param2;
         var_2134 = param3;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get position() : int
      {
         return var_2134;
      }
   }
}

