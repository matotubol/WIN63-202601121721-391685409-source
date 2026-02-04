package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent
   {
      
      public static const const_322:String = "rsfgue_favourite_group_update";
      
      private var var_3915:int;
      
      private var var_4216:int;
      
      private var _habboGroupName:String;
      
      private var _status:int;
      
      public function RoomSessionFavouriteGroupUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:String, param6:Boolean = false, param7:Boolean = false)
      {
         super("rsfgue_favourite_group_update",param1,param6,param7);
         var_3915 = param2;
         var_4216 = param3;
         _habboGroupName = param5;
         _status = param4;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get habboGroupId() : int
      {
         return var_4216;
      }
      
      public function get habboGroupName() : String
      {
         return _habboGroupName;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}

