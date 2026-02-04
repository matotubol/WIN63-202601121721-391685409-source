package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPresentOpenMessage extends RoomWidgetMessage
   {
      
      public static const const_615:String = "RWPOM_OPEN_PRESENT";
      
      private var var_315:int;
      
      public function RoomWidgetPresentOpenMessage(param1:String, param2:int)
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

