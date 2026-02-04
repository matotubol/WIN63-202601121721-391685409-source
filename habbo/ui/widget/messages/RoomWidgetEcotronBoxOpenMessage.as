package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenMessage extends RoomWidgetMessage
   {
      
      public static const const_746:String = "RWEBOM_OPEN_ECOTRONBOX";
      
      private var var_315:int;
      
      public function RoomWidgetEcotronBoxOpenMessage(param1:String, param2:int)
      {
         super(param1);
         var_315 = param2;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
   }
}

