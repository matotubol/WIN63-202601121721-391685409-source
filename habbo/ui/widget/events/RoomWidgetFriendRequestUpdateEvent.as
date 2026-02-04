package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetFriendRequestUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const SHOW_FRIEND_REQUEST:String = "RWFRUE_SHOW_FRIEND_REQUEST";
      
      public static const HIDE_FRIEND_REQUEST:String = "RWFRUE_HIDE_FRIEND_REQUEST";
      
      private var var_2563:int;
      
      private var var_1270:int;
      
      private var _userName:String;
      
      public function RoomWidgetFriendRequestUpdateEvent(param1:String, param2:int, param3:int = 0, param4:String = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_2563 = param2;
         var_1270 = param3;
         _userName = param4;
      }
      
      public function get requestId() : int
      {
         return var_2563;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

