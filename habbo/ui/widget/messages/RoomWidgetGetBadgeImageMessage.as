package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_GET_BADGE_IMAGE:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";
      
      private var var_605:String = "";
      
      public function RoomWidgetGetBadgeImageMessage(param1:String)
      {
         super("RWGOI_MESSAGE_GET_BADGE_IMAGE");
         var_605 = param1;
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
   }
}

