package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDoorbellEvent extends RoomWidgetUpdateEvent
   {
      
      public static const RINGING:String = "RWDE_RINGING";
      
      public static const REJECTED:String = "RWDE_REJECTED";
      
      public static const ACCEPTED:String = "RWDE_ACCEPTED";
      
      private var _userName:String = "";
      
      public function RoomWidgetDoorbellEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _userName = param2;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

