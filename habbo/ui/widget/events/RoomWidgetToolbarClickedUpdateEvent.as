package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetToolbarClickedUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const REQUEST_ME_MENU_TOOLBAR_CLICKED_EVENT:String = "RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED";
      
      public static const ICON_TYPE_ME_MENU:String = "ICON_TYPE_ME_MENU";
      
      public static const ICON_TYPE_ROOM_INFO:String = "ICON_TYPE_ROOM_INFO";
      
      private var var_4121:String;
      
      private var _active:Boolean = false;
      
      public function RoomWidgetToolbarClickedUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED",param3,param4);
         var_4121 = param1;
         _active = param2;
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      public function get iconType() : String
      {
         return var_4121;
      }
   }
}

