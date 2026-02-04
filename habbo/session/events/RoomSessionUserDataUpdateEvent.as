package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   
   public class RoomSessionUserDataUpdateEvent extends RoomSessionEvent
   {
      
      public static const USER_DATA_UPDATED:String = "rsudue_user_data_updated";
      
      private var _addedUsers:Vector.<class_2146>;
      
      public function RoomSessionUserDataUpdateEvent(param1:IRoomSession, param2:Vector.<class_2146>, param3:Boolean = false, param4:Boolean = false)
      {
         super("rsudue_user_data_updated",param1,param3,param4);
         _addedUsers = param2;
      }
      
      public function get addedUsers() : Vector.<class_2146>
      {
         return _addedUsers;
      }
   }
}

